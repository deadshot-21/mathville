using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;
using FlutterUnityIntegration;
using UnityEngine.EventSystems;
using System;
using TMPro;



public class NumberController : MonoBehaviour, IEventSystemHandler
{
    // Start is called before the first frame update
    public GameObject[] numbers;
    // public List<GameObject> numberList;
    public Camera mainCamera;
    private List<GameObject> createdObjects = new List<GameObject>();
    private float rotationSpeed = 30.0f;
    private ARRaycastManager arRaycastManager;
    private ARSessionOrigin arSessionOrigin;
    private int numbersPlaced = 0;
    private List<Vector3> placedNumberPositions = new List<Vector3>();
    private List<int> randomNumbers = new List<int>();
    private List<int> numbersThatCanBeUsed = new List<int>();

    public GameObject numberCanvas;
    public TextMeshProUGUI numberText;
    public LayerMask numbersLayer;
    [SerializeField]
    string _ans;

    void Start()
    {
        _ans = "0";
        generateRandomNumber(int.Parse(_ans));
        arRaycastManager = FindObjectOfType<ARRaycastManager>();
        arSessionOrigin = FindObjectOfType<ARSessionOrigin>();
        StartCoroutine(PlaceNumbers());
    }

    // Update is called once per frame
    void Update()
    {
        // UnityMessageManager.Instance.SendMessageToFlutter("Message from Unity");
        foreach (GameObject obj in createdObjects)
        {
            RotateObject(obj);
        }
        if (Input.touchCount > 0)
        {
            Touch touch = Input.GetTouch(0) ;
            Vector2 touchPosition = touch.position;

            // if (touch.phase == TouchPhase.Began)
            // {
                Ray ray = mainCamera.ScreenPointToRay(touchPosition);
                RaycastHit hit;

                if (Physics.Raycast(ray, out hit,Mathf.Infinity, numbersLayer))
                {
                    GameObject touchedObject = hit.collider.gameObject;

                    // Check if the touched object is in the createdObjects list.
                    foreach (var obj in createdObjects)
                    {
                        if (touchedObject.CompareTag(obj.transform.tag))
                        {
                            // if (obj.transform.tag == _ans)
                            // {
                                // UnityMessageManager.Instance.SendMessageToFlutter(obj.transform.tag);
                                // Application.Quit();
                            // }
                            // numberCanvas.SetActive(true);
                            // numberText.text = obj.name;
                            // else
                            // {
                            UnityMessageManager.Instance.SendMessageToFlutter(obj.name);
                            // }
                            
                            Destroy(obj);
                            int index = createdObjects.IndexOf(obj);
                            createdObjects.RemoveAt(index);
                            placedNumberPositions.RemoveAt(index);
                            // Application.Quit();
                        }
                    }
                }
            // }
        }
    }

    public void SetNumber(String number)
    {
        _ans = number.ToString();
        generateRandomNumber(int.Parse(_ans));
        // numberCanvas.SetActive(true);

    }

    // void SetNumberList(){
    //     foreach (var item in numbers)
    //     {
    //         numberList.Add(item);
    //     }
    //     for (int i = 10; i < 20; i++)
    //     {
    //         int digit1 = i / 10;
    //         int digit2 = i % 10;
    //         numberList.Add(CombineObjects(numbers[digit1], numbers[digit2], i));
    //     }
    // }

    GameObject CombineObjects(GameObject obj1, GameObject obj2, int number)
    {
        // Create a new empty game object to hold the combined objects
        GameObject combinedObject = new GameObject(number.ToString());
        // ERROR HERE SOHAM
		var meshFilter = gameObject.AddComponent<MeshFilter>();
		combinedObject.AddComponent<MeshRenderer>();
        // Set the position of the combined object to the position of the first object
        combinedObject.transform.position = new Vector3(0, 0, 0);
        // SOHAM COMMENT TRY COMBINED POSITION 0,0,0 AND PLACE THE NUMBER LEFT AND RIGHT
        // CENTER OF THE BOX COLLIDER WOULD BE 0,0,0
        obj1.transform.position = new Vector3(-0.4f, 0, 0);
        // Attach the first object as a child of the combined object
        obj1.transform.parent = combinedObject.transform;

        // Set the position of the second object relative to the first one
        obj2.transform.position = new Vector3(0.4f, 0, 0);

        // Attach the second object as a child of the combined object
        obj2.transform.parent = combinedObject.transform;

        BoxCollider combinedCollider = combinedObject.AddComponent<BoxCollider>();

        // Calculate the size of the BoxCollider based on the combined colliders of the child objects
        BoxCollider boxCollider1 = obj1.GetComponentInChildren<BoxCollider>();
        BoxCollider boxCollider2 = obj2.GetComponentInChildren<BoxCollider>();

            // Calculate the combined size and center of the BoxCollider
        // Vector3 center = (boxCollider1.center + boxCollider2.center) / 2f + new Vector3(GetObjectWidth(obj1) / 2f, 0, 0);
        Vector3 center = new Vector3(0.5f,0,0);
        Vector3 size = new Vector3(
            GetObjectX(obj1) + GetObjectX(obj2) + 0.5f,
            // Mathf.Abs(GetObjectX(obj1) - GetObjectX(obj2)) + boxCollider1.size.x + boxCollider2.size.x,
            Mathf.Max(boxCollider1.size.y, boxCollider2.size.y)+0.2f,
            Mathf.Max(boxCollider1.size.z, boxCollider2.size.z)
        );

        // Set the size and center of the combined BoxCollider
        combinedCollider.size = size;
        combinedCollider.center = center;
        combinedObject.name = number.ToString();
        // Return the final combined object
        return combinedObject;
    }

    //  void AddBoxCollider(GameObject obj)
    // {
    //     // Add a BoxCollider to the combined object
    //     BoxCollider boxCollider = obj.AddComponent<BoxCollider>();

    //     // Adjust the size of the BoxCollider based on the combined objects' bounds
    //     Bounds combinedBounds = CalculateCombinedBounds(obj);
    //     boxCollider.size = combinedBounds.size;
    // }

    // Bounds CalculateCombinedBounds(GameObject obj)
    // {
    //     // Calculate the combined bounds of all child objects
    //     Renderer[] renderers = obj.GetComponentsInChildren<Renderer>();
    //     Bounds combinedBounds = new Bounds();

    //     foreach (Renderer renderer in renderers)
    //     {
    //         combinedBounds.Encapsulate(renderer.bounds);
    //     }

    //     return combinedBounds;
    // }

    float GetObjectWidth(GameObject obj)
    {
        // Assuming the objects have a renderer component (adjust if needed)
        Renderer renderer = obj.GetComponentInChildren<MeshRenderer>();
        if (renderer != null)
        {
            // Return the width of the object
            return renderer.bounds.size.x;
        }
        else
        {
            // Default width if renderer is not found
            return 1.0f;
        }
    }

    float GetObjectX(GameObject obj)
    {
        // Assuming the objects have a renderer component (adjust if needed)
        Renderer renderer = obj.GetComponentInChildren<MeshRenderer>();
        return renderer.bounds.size.x;
    }

    public void generateRandomNumber(int number)
    {
        randomNumbers = new List<int>();
        int minValue = Math.Max(0,number-5);
        int maxValue = number+5;
        System.Random random = new System.Random();
        for (int i = 0; i < 5; i++)
        {
            int randomNumber = random.Next(minValue, maxValue + 1);
            randomNumbers.Add(randomNumber);
        }
        randomNumbers.Add(number);
        // numberCanvas.SetActive(true);
        // numberText.text = randomNumbers.Count.ToString();
    }
    private IEnumerator PlaceNumbers()
    {
        while (true){
        
            // numbersThatCanBeUsed = new List<int>{2,10};
            numbersThatCanBeUsed = new List<int>(randomNumbers);
            
            int index=0;
            while(numbersThatCanBeUsed.Count > 0)
            {
                index = UnityEngine.Random.Range(0, numbersThatCanBeUsed.Count);
                int n = numbersThatCanBeUsed[index];
                // int n = numbersThatCanBeUsed[0];
                GameObject createNumberToPlace = new GameObject();
                
                
                if (arRaycastManager != null && arSessionOrigin != null)
                {
                    List<ARRaycastHit> hits = new List<ARRaycastHit>();
                    if (arRaycastManager.Raycast(new Vector2(Screen.width / 2, Screen.height / 2), hits, TrackableType.PlaneWithinPolygon))
                    {
                        Pose hitPose = hits[0].pose;
                        Vector3 hitPosition = hitPose.position;
                        if (IsPositionFarther(hitPosition))
                        {
                            GameObject newNumber = new GameObject();
                            if (n >= 10 && n <= 99)
                            {
                                // Separate the digits
                                int digit1 = n / 10;
                                int digit2 = n % 10;
                                if (digit1 == digit2)
                                {
                                    GameObject obj1 = Instantiate(numbers[digit1]);
                                    GameObject obj2 = Instantiate(numbers[digit2]);
                                    newNumber = PlaceNumberOnPlane(CombineObjects(obj1, obj2, n), hitPose);
                                }
                                else
                                {
                                    newNumber = PlaceNumberOnPlane(CombineObjects(numbers[digit1], numbers[digit2], n), hitPose);
                                }
                            }
                            else{
                                
                                newNumber = PlaceNumberOnPlane(numbers[n], hitPose);
                                
                            }
                            newNumber.name = n.ToString();
                            newNumber.layer = 3;
                            placedNumberPositions.Add(hitPosition);
                            createdObjects.Add(newNumber);
                            numbersPlaced++;
                            numbersThatCanBeUsed.RemoveAt(index);
                            StartCoroutine(DestroyNumberAfterDelay(newNumber, hitPosition));
                        }
                    }
                }
                yield return null;
            }
        }
    }

    void CombineColliders(BoxCollider combinedCollider, GameObject obj1, GameObject obj2)
    {
        // Get the BoxColliders of the child objects
        BoxCollider boxCollider1 = obj1.GetComponent<BoxCollider>();
        BoxCollider boxCollider2 = obj2.GetComponent<BoxCollider>();

            // Calculate the combined size and center of the BoxCollider
        Vector3 center = (boxCollider1.center + boxCollider2.center) / 2f;
        Vector3 size = new Vector3(
            Mathf.Abs(boxCollider1.center.x - boxCollider2.center.x) + boxCollider1.size.x + boxCollider2.size.x,
            Mathf.Min(boxCollider1.size.y, boxCollider2.size.y),
            Mathf.Min(boxCollider1.size.z, boxCollider2.size.z)
        );

        // Set the size and center of the combined BoxCollider
        combinedCollider.size = size;
        combinedCollider.center = center;
    
    }

     private bool IsPositionFarther(Vector3 newPosition)
    {
        if (numbersPlaced == 0)
        {
            return true; // First number can always be placed
        }

        foreach (Vector3 position in placedNumberPositions)
        {
            float distance = Vector3.Distance(newPosition, position);
            if (distance < 3.0f) // You can adjust this threshold as needed
            {
                return false; // The new position is too close to an existing number
            }
        }

        return true;
    }

    private void RotateObject(GameObject obj)
    {
        obj.transform.Rotate(Vector3.up * rotationSpeed * Time.deltaTime);
    }

    private GameObject PlaceNumberOnPlane(GameObject numberPrefab, Pose pose)
    {
        Quaternion rotation = pose.rotation;
        Vector3 position = pose.position;

        // Adjust the height of the number to be above the plane.
        // position.y = 0.01f;

        GameObject newNumber = Instantiate(numberPrefab, position, rotation);
        newNumber.transform.localScale = Vector3.one * 1f; // Scale as needed
        return newNumber;
    }

    private IEnumerator DestroyNumberAfterDelay(GameObject number, Vector3 position)
    {
        yield return new WaitForSeconds(6.0f);
        if (createdObjects.Contains(number))
        {
            placedNumberPositions.Remove(position); // Remove the position from the list
            createdObjects.Remove(number); // Remove the object from the list
            Destroy(number); // Destroy the object after 5 seconds
        }
    }

}
