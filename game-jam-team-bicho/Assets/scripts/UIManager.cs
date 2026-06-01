
using UnityEngine;
using TMPro;
using System.Collections.Generic;
using System.Linq;
 
public class UIManager : MonoBehaviour
{
    public static UIManager Instance;
 
    [Header("Diálogo")]
    public TMP_Text dialogueText;
    public GameObject continueButton;
 
    [Header("Paneles de opciones")]
    public Transform questionPanel;  // Verde  - QUEST (fase 1)
    public Transform documentPanel; // Morado - DOC  (fase 2)
    public Transform decisionPanel; // Naranja - DEC  (fase 2)
 
    [Header("Prefabs")]
    public ChoiceButton choiceButtonPrefab;
 
    private List<ChoiceButton> _activeButtons = new();
 
    // Choices pendientes de la fase 2 (DOC + DEC), guardadas hasta que
    // el jugador haya elegido (o no) su QUEST.
    private List<InkChoice> _pendingPhase2 = new();
    private bool _questChosen = false;
 
    void Awake()
    {
        if (Instance == null) Instance = this;
        else Destroy(gameObject);
    }
 
    void Start()
    {
        DialogueManager.Instance.OnNewText    += HandleNewText;
        DialogueManager.Instance.OnChoicesReady += HandleChoices;
        DialogueManager.Instance.OnDayEnd     += HandleDayEnd;
    }
 
    // ── Texto nuevo ──────────────────────────────────────────────────────────
    private void HandleNewText(string text)
    {
        dialogueText.text = text;
        ClearButtons();
        continueButton.SetActive(true);
    }
 
    // ── Llegada de choices desde Ink ─────────────────────────────────────────
    private void HandleChoices(List<InkChoice> choices)
    {
        continueButton.SetActive(false);
        ClearButtons();
        _pendingPhase2.Clear();
        _questChosen = false;
 
        var quests = choices.Where(c => c.Type == ChoiceType.Question).ToList();
        var phase2 = choices.Where(c => c.Type != ChoiceType.Question).ToList();
 
        if (quests.Count > 0)
        {
            // Fase 1: mostrar solo QUEST; guardar DOC+DEC para después
            _pendingPhase2 = phase2;
            foreach (var q in quests)
                SpawnButton(q, questionPanel);
        }
        else
        {
            // Sin preguntas: ir directo a fase 2
            ShowPhase2(phase2);
        }
    }
 
    // ── Fase 2: DOC + DEC ────────────────────────────────────────────────────
    private void ShowPhase2(List<InkChoice> choices)
    {
        foreach (var c in choices)
        {
            Transform parent = c.Type == ChoiceType.Document ? documentPanel : decisionPanel;
            SpawnButton(c, parent);
        }
    }
 
    // ── Selección de una choice ───────────────────────────────────────────────
    public void OnChoiceSelected(InkChoice choice)
    {
        switch (choice.Type)
        {
            case ChoiceType.Question:
                if (_questChosen) return; // ya se eligió una, ignorar doble click
                _questChosen = true;
 
                // Destruir todos los botones QUEST
                foreach (var btn in _activeButtons.Where(b => b.ChoiceData.Type == ChoiceType.Question).ToList())
                {
                    _activeButtons.Remove(btn);
                    Destroy(btn.gameObject);
                }
 
                // Mostrar DOC + DEC ahora
                ShowPhase2(_pendingPhase2);
                _pendingPhase2.Clear();
                break;
 
            case ChoiceType.Document:
                // Destruir solo este botón DOC (ya se usó)
                var docBtn = _activeButtons.FirstOrDefault(b => b.ChoiceData.Index == choice.Index);
                if (docBtn != null)
                {
                    _activeButtons.Remove(docBtn);
                    Destroy(docBtn.gameObject);
                }
                break;
 
            case ChoiceType.Decision:
                // Avanzar: limpiar todo
                ClearButtons();
                break;
        }
 
        DialogueManager.Instance.ChooseOption(choice.Index);
    }
 
    // ── Botón Continuar ───────────────────────────────────────────────────────
    public void OnContinuePressed()
    {
        DialogueManager.Instance.Continue();
    }
 
    // ── Fin de día ────────────────────────────────────────────────────────────
    private void HandleDayEnd()
    {
        ClearButtons();
        continueButton.SetActive(false);
        Debug.Log("[UIManager] Día completado.");
        // TODO: pantalla entre días
    }
 
    // ── Helpers ───────────────────────────────────────────────────────────────
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
        _questChosen = false;
    }
}