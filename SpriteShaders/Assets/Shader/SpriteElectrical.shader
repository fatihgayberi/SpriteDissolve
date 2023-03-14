Shader "Wonnasmith/SpriteElectrical"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Skeleton ("Texture", 2D) = "white" {}
        _Electrical ("Electrical", 2D) = "white" {}
        

        _ColorA ("Color A", Color) = (1,1,1,1)
        _ColorB ("Color B", Color) = (1,1,1,1)
        _WaveSpeed ("Wave Speed ", Float) = 0.01
        _ColorStart ("Color Start", Range(0,1)) = 0
        _ColorEnd ("Color End", Range(0,1)) = 1
        _SkeletonPercent ("Skeleton Percent", Range(0,1)) = 1
    }
    SubShader
    {
        Tags{ "RenderType"="Transparent" "Queue"="Transparent"}
        
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            #define TAU 6.28318530718

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normals : NORMAL;
                float4 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 worldPos : TEXCOORD1;
                float3 normal : TEXCOORD2;
            };

              
            sampler2D _MainTex;
            sampler2D _Skeleton;

            
            sampler2D _Electrical;
            float4 _ColorA;
            float4 _ColorB;
            float _ColorStart;
            float _ColorEnd;
            float _WaveSpeed;

            
            half _SkeletonPercent;

            v2f vert (appdata v)
            {
                v2f o;
                o.worldPos = mul(UNITY_MATRIX_M, v.vertex); // object to world pos
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normals);
                o.uv = v.uv;

                return o;
            }

            float InverseLerp(float a, float b, float v)
            {
                return (v-a)/(b-a);
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float4 man = tex2D(_MainTex, i.uv);
                float4 skeleton = tex2D(_Skeleton, i.uv);
                float4 electrical = tex2D(_Electrical, i.uv);

                clip(skeleton + man - 0.5);
                

                float s = saturate(InverseLerp(_ColorStart, _ColorEnd,  i.uv.y));

                float xOffset = cos(electrical.y * _Time.x);
                float t = cos((electrical.x + xOffset - _Time.y * _WaveSpeed ) * TAU * 15) * 0.5 + 0.5;

                float topBottomRemover = (abs(i.normal.y) < 0.999);
                float waves = t * topBottomRemover;

                float4 gradiedent = lerp(_ColorA, _ColorB, s);

                return lerp(man, skeleton, _SkeletonPercent) + (gradiedent * waves * _SkeletonPercent);
            }
            ENDCG
        }
    }
}
