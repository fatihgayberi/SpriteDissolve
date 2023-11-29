Shader "Wonnasmith/TextureClear"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _MaskTex ("Mask Texture", 2D) = "white" {}
		_Amount("Amount", Range(-100,100)) = 0
    }

    // Shader için sabitler
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            sampler2D _MaskTex;
            float4 _MousePos; // Mouse pozisyonu
		    half _Amount;
            half2 _MainTex_TexelSize;

            v2f vert (appdata_t v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                // Fare pozisyonunu texture koordinatlarına dönüştürün
                float2 texCoord = i.uv;

                // Fare pozisyonunu texture boyutuna göre yeniden ölçeklendirin
                texCoord.x *= _MainTex_TexelSize.x;
                texCoord.y *= _MainTex_TexelSize.y;

                // Fare pozisyonuna yakın bir bölgeyi kontrol edin ve bu bölgeyi tamamen siyah yapın
                float radius = 0.2; // Silme yarıçapı
                float dist = distance(texCoord, _MousePos);
                if (dist < _Amount)
                {
                    return fixed4(0, 0, 0, 0); // Tamamen siyah yapın
                }
                else
                {
                    return tex2D(_MainTex, i.uv); // Texture'ın orijinal rengini döndürün
                }
            }

            ENDCG
        }
    }
}