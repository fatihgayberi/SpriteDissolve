Shader "Wonnasmith/CameraUIGrid"
{
    Properties{
		_Color ("Tint", Color) = (0, 0, 0, 1)
		_MainTex ("Texture", 2D) = "white" {}
        _Rows ("Rows", Float) = 1
        _Columns ("Columns", Float) = 1
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
                // Sample texture using calculated UV
                fixed4 col = tex2D(_MainTex, i.uv + (_Rows, _Columns));

                clip(col.a - 0.5);

                return col;
            }
            ENDCG
		}
	}
}
