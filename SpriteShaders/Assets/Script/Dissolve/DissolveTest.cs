using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Wonnasmith
{
    public class DissolveTest : MonoBehaviour
    {
        [SerializeField] private DissolveController dissolveController;
        [SerializeField] private bool isDissolveTest;

        private void Update()
        {
            if (isDissolveTest)
            {
                isDissolveTest = false;

                if (dissolveController != null)
                {
                    dissolveController.Dissolve();
                }
            }
        }
    }
}
