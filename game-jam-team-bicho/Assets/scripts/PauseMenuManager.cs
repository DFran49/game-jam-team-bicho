using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;
using UnityEngine.SceneManagement;
using TMPro;

public class PauseMenuManager : MonoBehaviour
{
    [Header("Escena")]
    public string gameSceneName = "Game"; // nombre exacto de la escena de juego

    [Header("Paneles")]
    public GameObject pausePanel;       // panel raíz
    public GameObject buttonsPanel;     // panel con los 3 botones
    public GameObject optionsPanel;     // panel de ajustes de sonido

    [Header("Botones")]
    public Button botonJugar;
    public Button botonOpciones;
    public Button botonSalir;
    public Button botonVolverDesdeOpciones; // botón "Volver" dentro del optionsPanel

    [Header("Opciones — Sonido")]
    public Slider sliderMusica;
    public Slider sliderEfectos;
    public Slider sliderGeneral;

    // ── Privados ──────────────────────────────────────────────────────────────
    private InputAction _pauseAction;
    private bool        _pausado = false;
    private bool        _esEscenaHome;

    // Claves para PlayerPrefs
    private const string KEY_MUSICA   = "vol_musica";
    private const string KEY_EFECTOS  = "vol_efectos";
    private const string KEY_GENERAL  = "vol_general";

    // ── Awake ─────────────────────────────────────────────────────────────────
    void Awake()
    {
        _esEscenaHome = SceneManager.GetActiveScene().name != gameSceneName;

        _pauseAction = new InputAction(
            name: "Pause",
            type: InputActionType.Button,
            binding: "<Keyboard>/escape"
        );
        _pauseAction.performed += _ => TogglePausa();

        // Estado inicial
        pausePanel.SetActive(false);
        buttonsPanel.SetActive(true);
        optionsPanel.SetActive(false);

        // Listeners botones
        botonJugar.onClick.AddListener(OnJugar);
        botonOpciones.onClick.AddListener(OnOpciones);
        botonSalir.onClick.AddListener(OnSalir);
        botonVolverDesdeOpciones.onClick.AddListener(OnVolverDesdeOpciones);

        // Listeners sliders
        sliderMusica.onValueChanged.AddListener(v => {
            PlayerPrefs.SetFloat(KEY_MUSICA, v);
            AudioManager.Instance?.SetMusicVolume(v);
        });
        sliderEfectos.onValueChanged.AddListener(v => {
            PlayerPrefs.SetFloat(KEY_EFECTOS, v);
            AudioManager.Instance?.SetSFXVolume(v);
        });
        sliderGeneral.onValueChanged.AddListener(v => {
            PlayerPrefs.SetFloat(KEY_GENERAL, v);
            AudioManager.Instance?.SetMasterVolume(v);
        });

        CargarPreferencias();

        // En home, Escape no pausa el juego, solo muestra/oculta el menú
        // En game, pausa el tiempo
        if (_esEscenaHome)
            botonJugar.GetComponentInChildren<TMP_Text>().text = "Jugar";
        else
            botonJugar.GetComponentInChildren<TMP_Text>().text = "Reanudar";
    }

    void OnEnable()  => _pauseAction.Enable();
    void OnDisable() => _pauseAction.Disable();

    // ── Toggle pausa ──────────────────────────────────────────────────────────
    public void TogglePausa()
    {
        Debug.Log($"Pulsado escape");
        _pausado = !_pausado;
        pausePanel.SetActive(_pausado);
        buttonsPanel.SetActive(true);
        optionsPanel.SetActive(false);

        // Solo pausar tiempo en la escena de juego
        if (!_esEscenaHome)
            Time.timeScale = _pausado ? 0f : 1f;
    }

    // ── Botones ───────────────────────────────────────────────────────────────
    private void OnJugar()
    {
        if (_esEscenaHome)
        {
            Time.timeScale = 1f;
            SceneManager.LoadScene(gameSceneName);
        }
        else
        {
            _pausado = false;
            pausePanel.SetActive(false);
            Time.timeScale = 1f;
        }
    }

    private void OnOpciones()
    {
        buttonsPanel.SetActive(false);
        optionsPanel.SetActive(true);
    }

    private void OnVolverDesdeOpciones()
    {
        PlayerPrefs.Save();
        optionsPanel.SetActive(false);
        buttonsPanel.SetActive(true);
    }

    private void OnSalir()
    {
        Time.timeScale = 1f;
        PlayerPrefs.Save();
#if UNITY_EDITOR
        UnityEditor.EditorApplication.isPlaying = false;
#else
        Application.Quit();
#endif
    }

    // ── Preferencias ──────────────────────────────────────────────────────────
    private void CargarPreferencias()
    {
        sliderMusica.value   = PlayerPrefs.GetFloat(KEY_MUSICA,  1f);
        sliderEfectos.value  = PlayerPrefs.GetFloat(KEY_EFECTOS, 1f);
        sliderGeneral.value  = PlayerPrefs.GetFloat(KEY_GENERAL, 1f);
    }
}