using UnityEngine;
using UnityEngine.UI;
using TMPro;
using System.Collections.Generic;
 
public class NPCManager : MonoBehaviour
{
    public static NPCManager Instance;
 
    [Header("UI")]
    public Image npcImage;
    public TMP_Text npcNameText;
 
    private Dictionary<string, NPCData> _npcDict = new();
    private string _currentNpcId = "";
 
    void Awake()
    {
        if (Instance == null) Instance = this;
        else Destroy(gameObject);
    }
 
    public void Initialize()
    {
        TextAsset json = Resources.Load<TextAsset>("Data/npc_data");
        if (json == null)
        {
            Debug.LogError("[NPCManager] No se encontró Data/npc_data.json en Resources.");
            return;
        }
 
        NPCDatabase database = JsonUtility.FromJson<NPCDatabase>(json.text);
        foreach (var npc in database.npcs)
        {
            npc.Init();
            _npcDict[npc.id] = npc;
        }
 
        Debug.Log($"[NPCManager] {_npcDict.Count} NPCs cargados.");
    }
 
    // Llamado desde tag # NPC: dorothy
    public void MostrarNPC(string npcId)
    {
        if (npcId == "none")
        {
            OcultarNPC();
            return;
        }
 
        if (!_npcDict.TryGetValue(npcId, out var data))
        {
            Debug.LogWarning($"[NPCManager] NPC no encontrado: {npcId}");
            return;
        }
 
        _currentNpcId = npcId;
        npcNameText.text = data.nombre;
 
        // Cargar estado por defecto
        string path = data.GetPath(data.defaultEstado ?? "neutral");
        CargarSprite(path);
        npcImage.gameObject.SetActive(true);
    }
 
    // Llamado desde tag # STATE: happy
    public void SetEstado(string estado)
    {
        if (string.IsNullOrEmpty(_currentNpcId)) return;
 
        string path = _npcDict[_currentNpcId].GetPath(estado);
        CargarSprite(path);
    }
 
    public void OcultarNPC()
    {
        npcImage.gameObject.SetActive(false);
        npcNameText.text = "";
        _currentNpcId = "";
    }
 
    private void CargarSprite(string path)
    {
        if (string.IsNullOrEmpty(path))
        {
            Debug.LogWarning("[NPCManager] Ruta de sprite vacía.");
            return;
        }
 
        Sprite sprite = Resources.Load<Sprite>(path);
        if (sprite == null)
        {
            Debug.LogWarning($"[NPCManager] Sprite no encontrado en: {path}");
            return;
        }
 
        npcImage.sprite = sprite;
    }
}