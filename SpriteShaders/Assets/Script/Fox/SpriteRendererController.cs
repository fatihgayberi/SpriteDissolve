using System;
using UnityEngine;

namespace Wonnasmith
{
    public class SpriteRendererController : MonoBehaviour
    {
        [SerializeField] private SpriteRenderer spriteRenderer;

        private void OnEnable()
        {
            MoveController.RightMove += OnRightMove;
            MoveController.LeftMove += OnLeftMove;
        }
        private void OnDisable()
        {
            MoveController.RightMove -= OnRightMove;
            MoveController.LeftMove -= OnLeftMove;
        }

        private void OnRightMove()
        {
            if (spriteRenderer == null) return;

            spriteRenderer.flipX = false;
        }

        private void OnLeftMove()
        {
            if (spriteRenderer == null) return;
            
            spriteRenderer.flipX = true;
        }
    }
}