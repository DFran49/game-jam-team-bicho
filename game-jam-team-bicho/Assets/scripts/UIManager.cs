using UnityEngine;
using UnityEngine.UI;
using TMPro;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class UIManager : MonoBehaviour
{
    public static UIManager Instance;

    [Header("Diálogo")]
    public GameObject dialoguePanel;
    public TMP_Text   dialogueText;
    public GameObject continueButton;

    [Header("Paneles de opciones")]
    public GameObject questionPanelObj;
    public GameObject actionPanelObj;
    public Transform  questionPanel;
    public Transform  actionPanel;

    [Header("Documentos")]
    public GameObject documentosPanel;
    public Image      imagenPrototipo;
    public Image      imagenPersonaje;

    [Header("Palanca")]
    public GameObject palancaObj;
    public GameObject palancaInvertidaObj;
    public GameObject palancaBaseObj;
    public Color palancaColorActiva = new Color(1f, 0.9f, 0.2f);

    [Header("Fade")]
    public float fadeDuration      = 0.5f;
    [Range(1.2f, 1.5f)]
    public float fadeOutMultiplier = 1.35f;  // cuánto más rápido es el fadeOut vs fadeIn

    [Header("Palanca - Animación")]
    public float palancaAnimDuration = 0.5f; // duración en segundos de cada tramo de la palanca

    // ── Privados ──────────────────────────────────────────────────────────────
    private CanvasGroup _dialogueCG;
    private CanvasGroup _questionCG;
    private CanvasGroup _actionCG;

    private RectTransform _palancaRect;
    private RectTransform _palancaInvertidaRect;
    private Image         _palancaImage;
    private Image         _palancaBaseImage;
    private float         _palancaAlturaOriginal;
    private Color         _palancaColorOriginal;
    private Color         _palancaBaseColorOriginal;
    private InkChoice     _pendingDec      = null;
    private bool          _palancaAnimando = false;
    private Coroutine     _palancaCoroutine = null;

    private bool _animando = false;
    private Coroutine _uiCoroutine = null; // solo esta se cancela, nunca la palanca

    private List<ChoiceButton> _activeButtons  = new();
    private HashSet<string>    _usedDocTexts   = new();
    private List<InkChoice>    _pendingPhase2  = new();
    private bool               _questChosen    = false;

    [Header("Prefabs")]
    public ChoiceButton choiceButtonPrefab;

    // ── Awake / Start ─────────────────────────────────────────────────────────
    void Awake()
    {
        if (Instance == null) Instance = this;
        else { Destroy(gameObject); return; }

        _dialogueCG = GetOrAddCG(dialoguePanel);
        _questionCG = GetOrAddCG(questionPanelObj);
        _actionCG   = GetOrAddCG(actionPanelObj);

        SetCG(_dialogueCG, 0f, false);
        SetCG(_questionCG, 0f, false);
        SetCG(_actionCG,   0f, false);
        documentosPanel.SetActive(false);

        _palancaRect          = palancaObj.GetComponent<RectTransform>();
        _palancaInvertidaRect = palancaInvertidaObj.GetComponent<RectTransform>();
        _palancaImage         = palancaObj.GetComponent<Image>();
        _palancaBaseImage     = palancaBaseObj.GetComponent<Image>();
        _palancaAlturaOriginal = _palancaRect.sizeDelta.y;
        _palancaInvertidaRect.sizeDelta = new Vector2(_palancaInvertidaRect.sizeDelta.x, 0f);
        palancaInvertidaObj.SetActive(false);
        _palancaColorOriginal     = _palancaImage.color;
        _palancaBaseColorOriginal = _palancaBaseImage.color;
    }

    void Start()
    {
        DialogueManager.Instance.OnNewText      += HandleNewText;
        DialogueManager.Instance.OnChoicesReady += HandleChoices;
        DialogueManager.Instance.OnDayEnd       += HandleDayEnd;
    }

    // ── Texto nuevo ──────────────────────────────────────────────────────────
    private void HandleNewText(string text)
    {
        dialogueText.text = text;
        continueButton.SetActive(true);
        documentosPanel.SetActive(false);
        // Solo cancelar la corrutina de UI, nunca la de la palanca
        if (_uiCoroutine != null) StopCoroutine(_uiCoroutine);
        _uiCoroutine = StartCoroutine(MostrarDialogo());
    }

    private IEnumerator MostrarDialogo()
    {
        _animando = true;
        int pendientes = 2;
        StartCoroutine(FadeOut(_questionCG, () => pendientes--));
        StartCoroutine(FadeOut(_actionCG,   () => pendientes--));
        yield return StartCoroutine(FadeIn(_dialogueCG));
        yield return new WaitUntil(() => pendientes == 0);
        ClearButtons(); // destruir botones solo cuando los paneles ya están ocultos
        _animando = false;
    }

    // ── Choices ───────────────────────────────────────────────────────────────
    private void HandleChoices(List<InkChoice> choices)
    {
        continueButton.SetActive(false);
        if (_uiCoroutine != null) StopCoroutine(_uiCoroutine);
        _uiCoroutine = StartCoroutine(MostrarOpciones(choices));
    }

    private IEnumerator MostrarOpciones(List<InkChoice> choices)
    {
        _animando = true;

        var quests = choices.Where(c => c.Type == ChoiceType.Question).ToList();
        var phase2 = choices.Where(c => c.Type != ChoiceType.Question).ToList();

        if (!_questChosen && quests.Count > 0)
        {
            _pendingPhase2 = phase2;

            // Spawnear solo las QUEST que no están ya en pantalla
            var textosExistentes = _activeButtons
                .Where(b => b.ChoiceData.Type == ChoiceType.Question)
                .Select(b => b.ChoiceData.DisplayText)
                .ToHashSet();
            foreach (var q in quests)
                if (!textosExistentes.Contains(q.DisplayText))
                    SpawnButton(q, questionPanel);

            if (!questionPanelObj.activeSelf)
            {
                int pendientes = 1;
                StartCoroutine(FadeOut(_dialogueCG, () => pendientes--));
                yield return StartCoroutine(FadeIn(_questionCG));
                yield return new WaitUntil(() => pendientes == 0);
            }
        }
        else
        {
            SpawnPhase2(phase2);
            int pendientes = 1;
            StartCoroutine(FadeOut(_dialogueCG, () => pendientes--));
            if (!actionPanelObj.activeSelf)
                yield return StartCoroutine(FadeIn(_actionCG));
            yield return new WaitUntil(() => pendientes == 0);
        }

        _animando = false;
    }

    private void SpawnPhase2(List<InkChoice> choices)
    {
        foreach (var c in choices)
        {
            if (c.Type == ChoiceType.Document && _usedDocTexts.Contains(c.DisplayText)) continue;
            bool yaExiste = _activeButtons.Any(b =>
                b.ChoiceData.Type == c.Type && b.ChoiceData.DisplayText == c.DisplayText);
            if (!yaExiste)
                SpawnButton(c, actionPanel);
        }
    }

    // ── Selección de choice ───────────────────────────────────────────────────
    public void OnChoiceSelected(InkChoice choice)
    {
        switch (choice.Type)
        {
            case ChoiceType.Question:
                if (_questChosen) return;
                // Eliminar solo el botón pulsado, no todos los QUEST
                var questBtn = _activeButtons.FirstOrDefault(b =>
                    b.ChoiceData.Type == ChoiceType.Question &&
                    b.ChoiceData.DisplayText == choice.DisplayText);
                if (questBtn != null) { _activeButtons.Remove(questBtn); Destroy(questBtn.gameObject); }

                // Comprobar si quedan más QUEST: si no, pasar a fase 2
                bool quedanQuests = _activeButtons.Any(b => b.ChoiceData.Type == ChoiceType.Question);
                if (!quedanQuests)
                {
                    _questChosen = true;
                    SpawnPhase2(_pendingPhase2);
                    _pendingPhase2.Clear();
                    if (!actionPanelObj.activeSelf)
                        StartCoroutine(FadeIn(_actionCG));
                }
                break;

            case ChoiceType.Document:
                _usedDocTexts.Add(choice.DisplayText);
                var docBtn = _activeButtons.FirstOrDefault(b =>
                    b.ChoiceData.Type == ChoiceType.Document &&
                    b.ChoiceData.DisplayText == choice.DisplayText);
                if (docBtn != null) { _activeButtons.Remove(docBtn); Destroy(docBtn.gameObject); }
                MostrarDocumentoSiProcede(choice.DisplayText);
                break;

            case ChoiceType.Decision:
                if (RequierePalanca(choice))
                {
                    _pendingDec = choice;
                    _palancaImage.color     = palancaColorActiva;
                    _palancaBaseImage.color = palancaColorActiva;
                    return;
                }
                ClearButtons();
                break;
        }

        DialogueManager.Instance.ChooseOption(choice.Index);
    }

    // ── Documentos ────────────────────────────────────────────────────────────
    private void MostrarDocumentoSiProcede(string texto)
    {
        string t = texto.ToLower();
        bool esDNI     = t.Contains("documento de identidad") || t.Contains("identificación");
        bool esPermiso = t.Contains("permiso de trabajo") || t.Contains("permiso");
        documentosPanel.SetActive(esDNI || esPermiso);
    }

    // ── Palanca ───────────────────────────────────────────────────────────────
    private bool RequierePalanca(InkChoice choice) =>
        choice.DisplayText.StartsWith("Dejar pasar");

    public void OnPalancaPressed()
    {
        if (_pendingDec == null || _palancaAnimando) return;
        if (_palancaCoroutine != null) StopCoroutine(_palancaCoroutine);
        _palancaCoroutine = StartCoroutine(AnimarPalanca(_pendingDec));
        _pendingDec = null;
    }

    private IEnumerator AnimarPalanca(InkChoice choice)
    {
        _palancaAnimando = true;

        float t = 0f;
        while (t < 1f)
        {
            t += Time.deltaTime / palancaAnimDuration;
            _palancaRect.sizeDelta = new Vector2(_palancaRect.sizeDelta.x,
                Mathf.Lerp(_palancaAlturaOriginal, 0f, Mathf.Clamp01(t)));
            yield return null;
        }
        _palancaRect.sizeDelta = new Vector2(_palancaRect.sizeDelta.x, 0f);
        palancaObj.SetActive(false);

        palancaInvertidaObj.SetActive(true);
        t = 0f;
        while (t < 1f)
        {
            t += Time.deltaTime / palancaAnimDuration;
            _palancaInvertidaRect.sizeDelta = new Vector2(_palancaInvertidaRect.sizeDelta.x,
                Mathf.Lerp(0f, _palancaAlturaOriginal, Mathf.Clamp01(t)));
            yield return null;
        }
        _palancaInvertidaRect.sizeDelta = new Vector2(_palancaInvertidaRect.sizeDelta.x, _palancaAlturaOriginal);

        ClearButtons();
        DialogueManager.Instance.ChooseOption(choice.Index);

        yield return new WaitForSeconds(2f);

        t = 0f;
        while (t < 1f)
        {
            t += Time.deltaTime / palancaAnimDuration;
            _palancaInvertidaRect.sizeDelta = new Vector2(_palancaInvertidaRect.sizeDelta.x,
                Mathf.Lerp(_palancaAlturaOriginal, 0f, Mathf.Clamp01(t)));
            yield return null;
        }
        _palancaInvertidaRect.sizeDelta = new Vector2(_palancaInvertidaRect.sizeDelta.x, 0f);
        palancaInvertidaObj.SetActive(false);

        palancaObj.SetActive(true);
        t = 0f;
        while (t < 1f)
        {
            t += Time.deltaTime / palancaAnimDuration;
            _palancaRect.sizeDelta = new Vector2(_palancaRect.sizeDelta.x,
                Mathf.Lerp(0f, _palancaAlturaOriginal, Mathf.Clamp01(t)));
            yield return null;
        }
        _palancaRect.sizeDelta = new Vector2(_palancaRect.sizeDelta.x, _palancaAlturaOriginal);

        _palancaImage.color     = _palancaColorOriginal;
        _palancaBaseImage.color = _palancaBaseColorOriginal;
        _palancaAnimando = false;
        _palancaCoroutine = null;
    }

    // ── Continuar ─────────────────────────────────────────────────────────────
    public void OnContinuePressed()
    {
        if (_animando) return;
        documentosPanel.SetActive(false);
        DialogueManager.Instance.Continue();
    }

    // ── Fin de día ────────────────────────────────────────────────────────────
    private void HandleDayEnd()
    {
        if (_uiCoroutine != null) StopCoroutine(_uiCoroutine);
        SetCG(_dialogueCG, 0f, false);
        SetCG(_questionCG, 0f, false);
        SetCG(_actionCG,   0f, false);
        continueButton.SetActive(false);
        documentosPanel.SetActive(false);
        _animando = false;
        ClearButtons();
        Debug.Log("[UIManager] Día completado.");
    }

    // ── Fade helpers ──────────────────────────────────────────────────────────
    private IEnumerator FadeIn(CanvasGroup cg)
    {
        cg.gameObject.SetActive(true);
        cg.interactable   = false;
        cg.blocksRaycasts = false;
        float t = 0f;
        while (t < fadeDuration)
        {
            t += Time.deltaTime;
            cg.alpha = Mathf.Clamp01(t / fadeDuration);
            yield return null;
        }
        SetCG(cg, 1f, true);
    }

    private IEnumerator FadeOut(CanvasGroup cg, System.Action onDone = null)
    {
        if (!cg.gameObject.activeSelf) { onDone?.Invoke(); yield break; }
        cg.interactable   = false;
        cg.blocksRaycasts = false;
        float duration = fadeDuration / fadeOutMultiplier; // más rápido que el fadeIn
        float t = duration;
        while (t > 0f)
        {
            t -= Time.deltaTime;
            cg.alpha = Mathf.Clamp01(t / duration);
            yield return null;
        }
        SetCG(cg, 0f, false);
        onDone?.Invoke();
    }

    private void SetCG(CanvasGroup cg, float alpha, bool active)
    {
        cg.alpha          = alpha;
        cg.interactable   = active;
        cg.blocksRaycasts = active;
        cg.gameObject.SetActive(active);
    }

    private CanvasGroup GetOrAddCG(GameObject go)
    {
        var cg = go.GetComponent<CanvasGroup>();
        if (cg == null) cg = go.AddComponent<CanvasGroup>();
        return cg;
    }

    // ── Botones helpers ───────────────────────────────────────────────────────
    private void SpawnButton(InkChoice choice, Transform parent)
    {
        var btn = Instantiate(choiceButtonPrefab, parent);
        btn.Setup(choice);
        _activeButtons.Add(btn);
    }

    private void ClearButtons()
    {
        foreach (var btn in _activeButtons)
            if (btn != null) Destroy(btn.gameObject);
        _activeButtons.Clear();
        _pendingPhase2.Clear();
        _questChosen  = false;
        _pendingDec   = null;
        _usedDocTexts.Clear();
    }
}