Shader "Unlit/ToonShaderQuantized"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color", Color) = (0.5, 0.65, 1, 1)
        [HDR]
        _AmbientColor("Ambient Color", Color) = (0.4,0.4,0.4,1)
        _NumBin("NumBin", Range(2,10)) = 7
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" "LightMode" = "ForwardBase" "PassFlags" = "OnlyDirectional" }
        LOD 100

        Pass
        {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            struct appdata
            {
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
                float4 vertex: POSITION;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float3 normal: NORMAL;
                float4 position: SV_POSITION;
            };

            float4 _Color;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _AmbientColor;
            int _NumBin;

            v2f vert (appdata v)
            {
                v2f o;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.position = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float3 normal = normalize(i.normal);
                
                float nDotL = max(0.0f, dot(_WorldSpaceLightPos0, normal));
                float lightIntensity = int (nDotL * _NumBin) / float (_NumBin); // divide to many diffuse's group
                float4 diffuseLight = lightIntensity * _LightColor0;

                return  (_AmbientColor + diffuseLight) *
                        _Color * tex2D(_MainTex, i.uv);
            }
            
            ENDCG
        }
    }
}
