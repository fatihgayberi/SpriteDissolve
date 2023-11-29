using System;
using UnityEngine;

namespace Wonnasmith.Outline
{
    [Serializable]
    public class OutlineTest : MonoBehaviour
    {
        [Serializable]
        private class OutlineControllerDatas
        {
            public bool outlineActive = true;
            public OutlineController outlineController;
        }

        [SerializeField] private OutlineControllerDatas[] outlineControllerDatasArray;

        private void Update()
        {
            foreach (OutlineControllerDatas outlineDatas in outlineControllerDatasArray)
            {
                if (outlineDatas == null)
                {
                    continue;
                }

                if (outlineDatas.outlineController == null)
                {
                    continue;
                }

                outlineDatas.outlineController.OutlineActivator(outlineDatas.outlineActive);
            }
        }
    }
}