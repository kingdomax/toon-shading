using UnityEngine;
using System.Collections.Generic;

public class Manipulator : MonoBehaviour
{
    public float RotationSpeed = 10.0f;
    public List<GameObject> _rotateableObjs = new List<GameObject>();
    
    void Update()
    {
        if (_rotateableObjs != null)
        {
            foreach (GameObject obj in _rotateableObjs) 
            { 
                obj.transform.Rotate(Vector3.forward * (RotationSpeed * Time.deltaTime));
            }
        }
    }
}
