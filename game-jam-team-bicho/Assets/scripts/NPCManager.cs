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
		    Debug.LogError("No se encontró npc_database.json");
		    return;
		}

        NPCDatabase database = JsonUtility.FromJson<NPCDatabase>(json.text);

        foreach (var npc in database.npcs)
            _npcDict[npc.id] = npc;
    }

    public void MostrarNPC(string npcId)
    {
        if (npcId == "none")
        {
            OcultarNPC();
            return;
        }

        if (!_npcDict.ContainsKey(npcId))
        {
            Debug.LogWarning($"[NPCManager] NPC no encontrado: {npcId}");
            return;
        }

        _currentNpcId = npcId;
        var data = _npcDict[npcId];
        npcNameText.text = data.nombre;

        CargarSprite(data.spritePath + "");
        npcImage.gameObject.SetActive(true);
    }

    // Llamado desde tag # STATE: fang
    public void SetEstado(string estado)
    {
        if (string.IsNullOrEmpty(_currentNpcId)) return;

        var data = _npcDict[_currentNpcId];
        CargarSprite(data.spritePath + "_" + estado);
    }

    public void OcultarNPC()
    {
        npcImage.gameObject.SetActive(false);
        npcNameText.text = "";
        _currentNpcId = "";
    }

    private void CargarSprite(string path)
    {
        Sprite sprite = Resources.Load<Sprite>(path);

        if (sprite == null)
        {
            Debug.LogWarning($"[NPCManager] Sprite no encontrado en: {path}");
            return;
        }

        npcImage.sprite = sprite;
    }
}