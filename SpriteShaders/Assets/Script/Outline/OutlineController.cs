using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Wonnasmith
{
    public class OutlineController : MonoBehaviour
    {
        [SerializeField] private Color outlineColor;

        private SpriteRenderer _spriteRenderer;

        private MaterialPropertyBlock _materialPropertyBlock;

        private const string strOutlineActive = "_isOutlineActive";


        private void Start()
        {
            _spriteRenderer = GetComponent<SpriteRenderer>();
        }


        public void OutlineActivator(bool isOutlineActive)
        {
            if (_spriteRenderer == null)
            {
                return;
            }

            if (_materialPropertyBlock == null)
            {
                _materialPropertyBlock = new MaterialPropertyBlock();
            }

            float otulineFlag = isOutlineActive ? 1 : 0;

            _materialPropertyBlock.SetFloat(strOutlineActive, otulineFlag);
            _materialPropertyBlock.SetColor(strOutlineActive, outlineColor);

            _spriteRenderer.SetPropertyBlock(_materialPropertyBlock);
        }
    }
}