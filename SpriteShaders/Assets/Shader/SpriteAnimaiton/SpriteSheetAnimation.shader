Shader "Wonnasmith/SpriteSheetAnimation"
{
    Properties{
		_Color ("Tint", Color) = (0, 0, 0, 1)
		_MainTex ("Texture", 2D) = "white" {}
        _Rows ("Rows", Float) = 1
        _Columns ("Columns", Float) = 1
        _Speed ("Speed", Float) = 1
        _AnimNum ("Anim Num", Float) = 1
	}

	SubShader{
        Tags { "RenderType" = "Opaque" }

		Pass{
			CGPROGRAM
            
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			float4 _MainTex_ST;

			fixed4 _Color;
            float _Rows;
            float _Columns;
            float _Speed;
            float _AnimNum;

			struct appdata{
				float2 uv : TEXCOORD0;
				float4 vertex : POSITION;
			};

			struct v2f{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};
            
			sampler2D _MainTex;

			v2f vert(appdata v){
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				return o;
			}

            fixed4 frag (v2f i) : SV_Target
            {
                // return tex2D(_MainTex, i.uv);

                // Calculate current frame index based on time and speed
                float currentTime = _Time.y * _Speed; // o anki time
                float totalFrames = _Rows * _Columns; // oyundaki toplam satir sutun saiyisi
                float currentFrame = (currentTime % totalFrames);

                // Calculate UV coordinates for the current frame
                float2 frameUV;
                frameUV.x = floor(currentFrame % _Columns) / _Columns;
                frameUV.y = 1.0 - _AnimNum/_Rows;//floor(1- ((currentFrame / _Columns) / _Rows));

                // Sample texture using calculated UV
                fixed4 col = tex2D(_MainTex, i.uv + frameUV);

                clip(col.a - 0.5); // Eger alpha degeri _Cutoff'tan dusukse, pixeli cizme.


                return col;
            }
            ENDCG
		}
	}
}
