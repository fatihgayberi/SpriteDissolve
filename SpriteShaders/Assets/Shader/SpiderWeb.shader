Shader "Wonnasmith/SpiderWeb"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _WaveSpeed("Wave Speed", Float) = 1
        // [PerRendererData, Toggle]_WaveActive("Wave Active", Float) = 1 // dalganin aktif olmasini istiyorsak 1 istemiyorsak 0 atamasi yapilmali
    }
    SubShader
    {
		Tags{ 
			"RenderType"="Transparent" 
			"Queue"="Transparent"
		}

		Blend SrcAlpha OneMinusSrcAlpha

		ZWrite off
		Cull off
		
        Pass
        {
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert
			#pragma fragment frag

			sampler2D _MainTex;
			float4 _MainTex_ST;

			fixed4 _Color;
            Float _WaveSpeed;
            // Float _WaveActive;

			struct appdata{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				fixed4 color : COLOR;
			};

			struct v2f{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
				fixed4 color : COLOR;
			};

			v2f vert(appdata v){
				v2f o;
				o.position = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.color = v.color;
				
                return o;
			}

            fixed4 frag (v2f i) : SV_Target
            {
                fixed2 inputUV = i.uv + /*(*/fixed2(sin(i.uv.y * 30.0 + (_Time.y * _WaveSpeed)) / 100.0 , sin(i.uv.x * 0.01 + (_Time.x * _WaveSpeed)) / 100.0)/*) * _WaveActive*/;
                fixed4 col = tex2D(_MainTex, inputUV);
                clip(col.a - 0.5); // Eger alpha degeri _Cutoff'tan dusukse, pixeli cizme.

                return col;
            }
            ENDCG
        }
    }
}
