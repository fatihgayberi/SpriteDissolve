using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Wonnasmith
{
    public class DissolveController : MonoBehaviour
    {
        [SerializeField] private SpriteRenderer spriteRenderer;
        [SerializeField] private float duration;
        [SerializeField] private Color endColor;

        private MaterialPropertyBlock _materialPropertyBlock;
        private Coroutine _dissolveCoroutine;

        private float _deltaAmaunt;
        private float _currentAmount;
        private float _elapsedTime = 0;

        public void Dissolve()
        {
            if (spriteRenderer == null)
            {
                return;
            }

            if (_materialPropertyBlock == null)
            {
                _materialPropertyBlock = new MaterialPropertyBlock();
            }

            _currentAmount = 0;

            _materialPropertyBlock.SetColor("_ColorEnd", endColor);
            _materialPropertyBlock.SetFloat("_Amount", _currentAmount);

            spriteRenderer.SetPropertyBlock(_materialPropertyBlock);

            _dissolveCoroutine = StartCoroutine(IenumeratorDissolve());
        }


        private IEnumerator IenumeratorDissolve()
        {
            while (_elapsedTime < duration)
            {
                _currentAmount = Mathf.Lerp(0, 1, _elapsedTime / duration);

                _elapsedTime += Time.deltaTime;

                _materialPropertyBlock.SetFloat("_Amount", _currentAmount);
                spriteRenderer.SetPropertyBlock(_materialPropertyBlock);

                yield return null;
            }
        }
    }
}