// Compiled shader for all platforms, uncompressed size: 0.3KB

Shader "Custom/TranspUnlit" {
Properties {
 _Color ("Color & Transparency", Color) = (0,0,0,0)
}
SubShader { 
 Tags { "QUEUE"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" }
  Color [_Color]
  ZWrite off
  Blend SrcAlpha OneMinusSrcAlpha
 }
}
Fallback "Unlit/Transparent"
}