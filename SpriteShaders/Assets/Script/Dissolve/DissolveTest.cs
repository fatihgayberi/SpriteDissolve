using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Wonnasmith
{
    public class DissolveTest : MonoBehaviour
    {
        [SerializeField] private DissolveController dissolveController;
        [SerializeField] private bool isDissolveStart;
        [SerializeField] private bool isDissolveStop;

        private void Update()
        {
            if (isDissolveStart)
            {
                isDissolveStart = false;

                if (dissolveController != null)
                {
                    dissolveController.Dissolve();
                }
            }

            if (isDissolveStop)
            {
                isDissolveStop = false;

                if (dissolveController != null)
                {
                    dissolveController.DissolveReset();
                }
            }
        }
    }
}
