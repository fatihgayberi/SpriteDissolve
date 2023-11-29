Shader "Wonnasmith/MotionBlur"
 {
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BaseTex ("Base Texture", 2D) = "white" {}
		_won ("_won", Float) = 0.5
		_Threshold ("_Threshold", Float) = 0.5
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

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };


            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;

                return o;
            }

            sampler2D _MainTex;
            sampler2D _BaseTex;
		    half _won;
		    half _Threshold;

            fixed4 frag (v2f i) : COLOR
            {
                fixed2 blurUV =  fixed2(i.uv.x * _Threshold, i.uv.y);

                half4 mainColor = tex2D(_MainTex, blurUV);
                half4 baseColor = tex2D(_MainTex, i.uv / 2);

                mainColor.a = saturate(mainColor) + _won;


                return  baseColor - mainColor;
            }
            ENDCG
        }
    }
}