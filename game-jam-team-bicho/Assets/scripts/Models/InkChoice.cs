using Ink.Runtime;

public class InkChoice
{
    public int Index;
    public string DisplayText;
    public ChoiceType Type;

    public InkChoice(Choice inkChoice)
    {
        Index = inkChoice.index;
        string raw = inkChoice.text;

        if (raw.StartsWith("QUEST: "))
        {
            Type = ChoiceType.Question;
            DisplayText = raw.Substring(7);
        }
        else if (raw.StartsWith("DOC: "))
        {
            Type = ChoiceType.Document;
            DisplayText = raw.Substring(5);
        }
        else if (raw.StartsWith("DEC: "))
        {
            Type = ChoiceType.Decision;
            DisplayText = raw.Substring(5);
        }
        else
        {
            Type = ChoiceType.Question;
            DisplayText = raw;
        }
    }
}