using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Wonnasmith
{
    public class AnimatorController : MonoBehaviour
    {
        private class AnimationNameDatas
        {
            public readonly string idleAnimationName = "TriggerIdle";
            public readonly string moveAnimationName = "TriggerMove";
        }

        [SerializeField] private Animator animator;
        private AnimationNameDatas animationNameDatas = new AnimationNameDatas();

        private void OnEnable()
        {
            MoveController.RightMove += OnMove;
            MoveController.LeftMove += OnMove;
            MoveController.StopMove += StopMove;
        }
        private void OnDisable()
        {
            MoveController.RightMove -= OnMove;
            MoveController.LeftMove -= OnMove;
            MoveController.StopMove -= StopMove;
        }

        private void OnMove()
        {
            if (animator == null) return;

            animator.SetTrigger(animationNameDatas.moveAnimationName);
        }

        private void StopMove()
        {
            if (animator == null) return;

            animator.SetTrigger(animationNameDatas.idleAnimationName);
        }
    }
}
