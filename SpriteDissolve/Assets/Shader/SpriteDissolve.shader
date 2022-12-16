Shader "Wonnasmith/SpriteDissolve"
{
    Properties
    {
		_ColorStart ("Color Start", Color) = (1,1,1,1)
		_ColorEnd ("Color End", Color) = (1,1,1,1)
        _ColorSpeed("Color Speed", Range(0, 1)) = 1

        _MainTex ("Texture", 2D) = "white" {}

        //Dissolve properties
		_DissolveTexture("Dissolve Texutre", 2D) = "white" {} 
		_Amount("Amount", Range(0,1)) = 0
    }
    SubShader
    {
        		Tags{ "RenderType"="Transparent" "Queue"="Transparent"}

		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite off

        // // No culling or depth
        // Cull Off ZWrite Off ZTest Always

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
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

		    //Dissolve properties
		    sampler2D _DissolveTexture;
		    half _Amount;
		    half _Blend;
		    half _ColorSpeed;
            sampler2D _MainTex;
    		fixed4 _ColorStart;
    		fixed4 _ColorEnd;

            fixed4 frag (v2f i) : SV_Target
            {
                //Dissolve function
			    half dissolve_value = tex2D(_DissolveTexture, i.uv).r;
			    clip(dissolve_value - _Amount);

                fixed4 col = tex2D(_MainTex, i.uv) * lerp(_ColorStart, _ColorEnd, _Amount * (_ColorSpeed + 1));

                return col;
            }
            ENDCG
        }
    }
}