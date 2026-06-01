using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    public static GameManager Instance;

    [Header("Managers (asignar en Inspector)")]
    public NPCManager npcManager;
    public ParanoiaManager paranoiaManager;
    public DialogueManager dialogueManager;
    public UIManager uiManager;

    private int _currentDay = 0;

    void Awake()
    {
        if (Instance == null) Instance = this;
        else Destroy(gameObject);
    }

    void Start()
    {
        npcManager.Initialize();
        IniciarDia(0);
    }

    public void IniciarDia(int day)
    {
        _currentDay = day;
        Debug.Log($"[GameManager] Iniciando día {day + 1}");
        dialogueManager.StartDay(day);
    }

    public void AvanzarDia()
    {
        _currentDay++;

        if (_currentDay >= dialogueManager.inkDays.Length)
        {
            Debug.Log("[GameManager] Historia completada.");
            // TODO: pantalla de fin
            return;
        }

        IniciarDia(_currentDay);
    }
}