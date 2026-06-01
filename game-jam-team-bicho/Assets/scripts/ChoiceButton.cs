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
        UIManager.Instance.OnChoiceSelected(ChoiceData);
    }

    public void SetInteractable(bool value)
    {
        button.interactable = value;
    }
}