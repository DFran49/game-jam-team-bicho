using UnityEngine;
using Ink.Runtime;
using System.Collections.Generic;
 
public class DialogueManager : MonoBehaviour
{
    public static DialogueManager Instance;
 
    [Header("Ink Assets (uno por día)")]
    public TextAsset[] inkDays;
 
    private Story _story;
    private int _currentDay = 0;
 
    private static Dictionary<string, object> _crossDayVars = new();
 
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
 
        foreach (var kv in _crossDayVars)
        {
            try { _story.variablesState[kv.Key] = kv.Value; }
            catch { }
        }
 
        Continue();
    }
 
    public void Continue()
    {
        if (_story.canContinue)
        {
            string text = _story.Continue();
            ProcessTags(_story.currentTags);
 
            if (string.IsNullOrWhiteSpace(text))
            {
                Continue();
                return;
            }
 
            OnNewText?.Invoke(text.Trim());
            return;
        }
 
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

    // Resuelve el índice actual en Ink buscando por texto y prefijo de tipo.
    // Necesario porque los índices cambian conforme se consumen opciones *.
    public int ResolveChoiceIndex(string displayText, ChoiceType type)
    {
        string prefix = type switch
        {
            ChoiceType.Question => "QUEST: ",
            ChoiceType.Document => "DOC: ",
            ChoiceType.Decision => "DEC: ",
            _ => ""
        };
        string fullText = prefix + displayText;

        for (int i = 0; i < _story.currentChoices.Count; i++)
        {
            if (_story.currentChoices[i].text == fullText)
                return i;
        }
        return -1;
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
 
            string key   = parts[0].Trim().ToUpper();
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
                case "SAVE_VAR":
                    SaveCrossDayVar(value.Trim());
                    break;
            }
        }
    }
 
    private void SaveCrossDayVar(string varName)
    {
        try
        {
            object val = _story.variablesState[varName];
            _crossDayVars[varName] = val;
            Debug.Log($"[DialogueManager] SAVE_VAR: {varName} = {val}");
        }
        catch
        {
            Debug.LogWarning($"[DialogueManager] SAVE_VAR: variable '{varName}' no encontrada.");
        }
    }
}