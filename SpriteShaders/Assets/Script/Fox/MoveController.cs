using UnityEngine;

namespace Wonnasmith
{
    public class MoveController : MonoBehaviour
    {
        public delegate void MoveStatusChange();
        public static event /*MoveController.*/MoveStatusChange StopMove;
        public static event /*MoveController.*/MoveStatusChange LeftMove;
        public static event /*MoveController.*/MoveStatusChange RightMove;
        public static event /*MoveController.*/MoveStatusChange ForwardMove;
        public static event /*MoveController.*/MoveStatusChange BackMove;

        [SerializeField] private float moveSpeed = 5f;

        [SerializeField] private Rigidbody2D rb;

        private void Update()
        {
            Move();
        }

        private void Move()
        {
            if (rb == null) return;

            float moveX = Input.GetAxis("Horizontal");

            Vector2 movement = new Vector2(moveX, 0);
            rb.velocity = movement * moveSpeed;

            if (moveX == 0)
                StopMove?.Invoke();
            else if (moveX > 0)
                RightMove?.Invoke();
            else if (moveX < 0)
                LeftMove?.Invoke();
        }
    }
}
