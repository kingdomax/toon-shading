using UnityEngine;
using System.Collections.Generic;

public class Manipulator : MonoBehaviour
{
    public float RotationSpeed = 10.0f;
    
    private List<GameObject> _objs = new List<GameObject>();
    
    void Awake()
    {
        foreach (Transform child in transform) { _objs.Add(child.gameObject); }
    }

    void Update()
    {
        foreach (GameObject child in _objs) { child.transform.Rotate(Vector3.forward * (RotationSpeed * Time.deltaTime)); }
    }
}
