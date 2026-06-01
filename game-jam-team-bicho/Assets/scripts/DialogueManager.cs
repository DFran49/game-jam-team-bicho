using UnityEngine;
using Ink.Runtime;
using System.Collections.Generic;
 
public class DialogueManager : MonoBehaviour
{
    public static DialogueManager Instance;
 
    [Header("Ink Assets (uno por día)")]
    public TextAsset[] inkDays; // Arrastra Day1, Day2... en orden
 
    private Story _story;
    private int _currentDay = 0;
 
    // Eventos que escucha UIManager
    public System.Action<string> OnNewText;
    public System.Action<List<InkChoice>> OnChoicesReady;
    public System.Action OnDayEnd;
 
    void Awake()
    {
        if (Instance == null) Instance = this;
        else Destroy(gameObject);
    }
 
    public void StartDay(int dayIndex)
    {
        _currentDay = dayIndex;
        _story = new Story(inkDays[dayIndex].text);
        Continue();
    }
 
    // Avanza la historia y procesa lo que venga
    public void Continue()
    {
        if (_story.canContinue)
        {
            string text = _story.Continue();
            ProcessTags(_story.currentTags);
 
            // Texto vacío (nodos de control) → avanza solo
            if (string.IsNullOrWhiteSpace(text))
            {
                Continue();
                return;
            }
 
            OnNewText?.Invoke(text.Trim());
 
            // ← CLAVE: solo evaluar choices si NO hay texto que mostrar primero.
            // Con el "return" aquí, el jugador verá el texto y pulsará Continuar
            // para que entonces se evalúe el estado siguiente.
            return;
        }
 
        // Solo llegamos aquí si canContinue era false desde el principio
        if (_story.currentChoices.Count > 0)
            BuildAndSendChoices();
        else
            OnDayEnd?.Invoke();
    }
 
    public void ChooseOption(int index)
    {
        _story.ChooseChoiceIndex(index);
        Continue();
    }
 
    private void BuildAndSendChoices()
    {
        var choices = new List<InkChoice>();
        foreach (var c in _story.currentChoices)
            choices.Add(new InkChoice(c));
 
        OnChoicesReady?.Invoke(choices);
    }
 
    private void ProcessTags(List<string> tags)
    {
        foreach (var tag in tags)
        {
            string[] parts = tag.Split(':');
            if (parts.Length < 2) continue;
 
            string key = parts[0].Trim().ToUpper();
            string value = parts[1].Trim().ToLower();
 
            switch (key)
            {
                case "NPC":
                    NPCManager.Instance.MostrarNPC(value);
                    break;
                case "STATE":
                    NPCManager.Instance.SetEstado(value);
                    break;
                case "PARANOIA":
                    if (int.TryParse(value, out int amount))
                        ParanoiaManager.Instance.AddParanoia(amount);
                    break;
                case "DAY_END":
                    OnDayEnd?.Invoke();
                    break;
            }
        }
    }
}
 