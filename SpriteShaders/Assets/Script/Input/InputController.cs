using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Wonnasmith.InputWonna
{
    public class InputController : MonoBehaviour
    {
        public Material material;
        List<Vector2> shaderCoords = new List<Vector2>();

        void Update()
        {
            Vector3 mousePosition = Input.mousePosition;

            Ray ray = Camera.main.ScreenPointToRay(mousePosition);
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit))
            {
                Vector2 coords = (hit.textureCoord);

                material.SetVector("_MousePos", coords);
            }

            foreach (Vector2 item in shaderCoords)
            {
            }
        }
    }
}
