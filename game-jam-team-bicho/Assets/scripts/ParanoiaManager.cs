using UnityEngine;
using UnityEngine.UI;

public class ParanoiaManager : MonoBehaviour
{
    public static ParanoiaManager Instance;

    [Header("UI")]
    public Slider paranoiaSlider;
    public int maxParanoia = 20;

    public int CurrentParanoia { get; private set; }

    void Awake()
    {
        if (Instance == null) Instance = this;
        else Destroy(gameObject);
    }

    public void AddParanoia(int amount)
    {
        CurrentParanoia = Mathf.Clamp(CurrentParanoia + amount, 0, maxParanoia);

        if (paranoiaSlider != null)
            paranoiaSlider.value = (float)CurrentParanoia / maxParanoia;

        Debug.Log($"[Paranoia] {CurrentParanoia}/{maxParanoia}");
    }
}