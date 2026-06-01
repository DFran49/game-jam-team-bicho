using System.Collections.Generic;

[System.Serializable]
public class NPCData
{
    public string id;
    public string nombre;
    public string spritePath; // "Sprites/NPCs/dorothy"
}

[System.Serializable]
public class NPCDatabase
{
    public List<NPCData> npcs;
}