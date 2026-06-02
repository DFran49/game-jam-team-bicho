using System.Collections.Generic;
 
[System.Serializable]
public class SpriteEntry
{
    public string estado;
    public string path;
}
 
[System.Serializable]
public class NPCData
{
    public string id;
    public string nombre;
    public string defaultEstado;        // estado inicial al mostrar el NPC
    public List<SpriteEntry> sprites;   // JsonUtility sí serializa List<>
 
    // Helpers en runtime (no serializados)
    private Dictionary<string, string> _spriteMap;
 
    public void Init()
    {
        _spriteMap = new Dictionary<string, string>();
        if (sprites == null) return;
        foreach (var e in sprites)
            _spriteMap[e.estado] = e.path;
    }
 
    // Devuelve la ruta para un estado; si no existe, usa defaultEstado; si tampoco, el primero disponible.
    public string GetPath(string estado)
    {
        if (_spriteMap == null) Init();
 
        if (_spriteMap.TryGetValue(estado, out var path)) return path;
        if (!string.IsNullOrEmpty(defaultEstado) && _spriteMap.TryGetValue(defaultEstado, out path)) return path;
        if (sprites != null && sprites.Count > 0) return sprites[0].path;
        return "";
    }
}
 
[System.Serializable]
public class NPCDatabase
{
    public List<NPCData> npcs;
}