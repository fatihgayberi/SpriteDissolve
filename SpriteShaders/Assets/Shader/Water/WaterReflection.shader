// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Wonnasmith/Water/WaterReflection"
{
    Properties
    {
        _MainTex ("Water Noise", 2D) = "white" {}
        _InputTex ("Input Texture", 2D) = "white" {}

        _WaterColor("Water Color", Color) = (1,1,1,1)
        _ReflectionWaveSpeed("Reflection Wave Speed", Float) = 1

        _NoiseThresholdMin("Noise ThresholdMin", Range(0,2)) = 0.01
        _NoiseThresholdMax("Noise ThresholdMax", Range(0,2)) = 0.01
        _ScrollXSpeed("_Scroll Speed X", Range(-1,1)) = 0.01
        _ScrollYSpeed("_Scroll Speed Y", Range(-1,1)) = 0.01
    }
    SubShader
    {
        Tags {"Queue"="Transparent" "RenderType"="Transparent"}
     
        Blend SrcAlpha OneMinusSrcAlpha 

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float2 uv : TEXCOORD0;
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            sampler2D _InputTex;

            Float _NoiseWaveSpeed;
            Float _NoiseThresholdMin;
            Float _NoiseThresholdMax;

            fixed _ScrollXSpeed;
            fixed _ScrollYSpeed;

            Float _ReflectionWaveSpeed;
            fixed4 _WaterColor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                // o.uv = mul(unity_ObjectToWorld, v.vertex);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                i.uv.y =  1 - i.uv.y;

                fixed2 waterUV = i.uv + fixed2(sin(_ScrollXSpeed * _Time.y) , cos(_ScrollYSpeed * _Time.y));
                fixed2 inputUV = i.uv + fixed2(sin(i.uv.y * 30.0 + (_Time.y * _ReflectionWaveSpeed)) / 100.0 , sin(i.uv.x * 0.01 + (_Time.x * _ReflectionWaveSpeed)) / 100.0);

                fixed4 waterNoise = tex2D(_MainTex, waterUV);
                fixed4 inputCol = tex2D(_InputTex, inputUV);

                waterNoise.a = saturate((waterNoise.x + waterNoise.y + waterNoise.z) - lerp(_NoiseThresholdMin, _NoiseThresholdMax, sin(_Time.y)));


                return (waterNoise + inputCol ) * _WaterColor;
            }
            ENDCG
        }
    }
}

