using UnityEngine;
using UnityEngine.Audio;

public class AudioManager : MonoBehaviour
{
    public static AudioManager Instance;

    [Header("Audio Mixer")]
    public AudioMixer mixer; // arrastra tu AudioMixer aquí

    // Nombres de los parámetros expuestos en el AudioMixer
    private const string PARAM_MASTER  = "MasterVolume";
    private const string PARAM_MUSICA  = "MusicVolume";
    private const string PARAM_EFECTOS = "SFXVolume";

    void Awake()
    {
        if (Instance == null)
        {
            Instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
            return;
        }
    }

    public void SetMasterVolume(float value) => SetVolume(PARAM_MASTER, value);
    public void SetMusicVolume(float value)  => SetVolume(PARAM_MUSICA,  value);
    public void SetSFXVolume(float value)    => SetVolume(PARAM_EFECTOS, value);

    // Los sliders van de 0 a 1, el mixer trabaja en dB (-80 a 0)
    private void SetVolume(string param, float value)
    {
        float db = value > 0.001f ? Mathf.Log10(value) * 20f : -80f;
        mixer.SetFloat(param, db);
    }
}