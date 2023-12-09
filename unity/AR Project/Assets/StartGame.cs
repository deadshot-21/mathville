using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

public class StartGame : MonoBehaviour
{
    public float timeLeft = 3.0f;
    public TextMeshProUGUI startText; // used for showing countdown from 3, 2, 1 
    public GameObject arComponents; // used for enabling AR components
    public GameObject numberController;
    public GameObject timerScreen;

    void Start(){
        arComponents.SetActive(false);
        numberController.SetActive(false);
        timerScreen.SetActive(true);
    }

    void Update()
    {
        timeLeft -= Time.deltaTime;
        startText.text = (timeLeft).ToString("0");
        if (timeLeft < 0)
        {
            arComponents.SetActive(true);
            numberController.SetActive(true);
            timerScreen.SetActive(false);
        }
    }
}


