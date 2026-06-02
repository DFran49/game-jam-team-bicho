using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class ChoiceButton : MonoBehaviour
{
    [Header("UI")]
    public TMP_Text buttonText;
    public Button button;

    public InkChoice ChoiceData { get; private set; }

    public void Setup(InkChoice choice)
    {
        ChoiceData = choice;
        buttonText.text = choice.DisplayText;
        button.onClick.RemoveAllListeners();
        button.onClick.AddListener(OnClick);
    }

    private void OnClick()
    {
        // Resolver el índice actual en Ink por texto en el momento del click,
        // ya que los índices cambian conforme se consumen opciones con *.
        int resolvedIndex = DialogueManager.Instance.ResolveChoiceIndex(ChoiceData.DisplayText, ChoiceData.Type);
        if (resolvedIndex < 0)
        {
            Debug.LogWarning($"[ChoiceButton] No se encontró la choice '{ChoiceData.DisplayText}' en Ink.");
            return;
        }
        // Actualizar el índice antes de enviarlo
        ChoiceData.Index = resolvedIndex;
        UIManager.Instance.OnChoiceSelected(ChoiceData);
    }

    public void SetInteractable(bool value)
    {
        button.interactable = value;
    }
}