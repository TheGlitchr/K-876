// Compiled shader for all platforms, uncompressed size: 58.6KB

Shader "EVE/Terrain" {
Properties {
 _Color ("Color Tint", Color) = (1,1,1,1)
 _MainTex ("Main (RGB)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _SpecularColor ("Specular tint", Color) = (1,1,1,1)
 _SpecularPower ("Shininess", Float) = 0.078125
 _midTex ("Detail (RGB)", 2D) = "white" {}
 _steepTex ("Detail for Vertical Surfaces (RGB)", 2D) = "white" {}
 _DetailScale ("Detail Scale", Range(0,1000)) = 200
 _DetailVertScale ("Detail Scale", Range(0,1000)) = 200
 _DetailOffset ("Detail Offset", Vector) = (0.5,0.5,0,0)
 _DetailDist ("Detail Distance", Range(0,1)) = 0.00875
 _MinLight ("Minimum Light", Range(0,1)) = 0.5
 _Albedo ("Albedo Index", Range(0,5)) = 1.2
 _CityOverlayTex ("Overlay (RGB)", 2D) = "white" {}
 _CityOverlayDetailScale ("Overlay Detail Scale", Range(0,1000)) = 80
 _CityDarkOverlayDetailTex ("Overlay Detail (RGB) (A)", 2D) = "white" {}
 _CityLightOverlayDetailTex ("Overlay Detail (RGB) (A)", 2D) = "white" {}
 _SunDir ("Sun Direction", Vector) = (1,1,1,1)
 _PlanetOpacity ("PlanetOpacity", Float) = 1
 _OceanRadius ("Ocean Radius", Float) = 63000
 _OceanColor ("Ocean Color Tint", Color) = (1,1,1,1)
 _OceanDepthFactor ("Ocean Depth Factor", Float) = 0.002
 _PlanetOrigin ("Planet Center", Vector) = (0,0,0,1)
}
SubShader { 
 Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }


 // Stats for Vertex shader:
 //       d3d11 : 29 math
 //        d3d9 : 39 math
 // Stats for Fragment shader:
 //        d3d9 : 1 math
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry" "RenderType"="Opaque" }
  Lighting On
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
uniform vec3 _SunDir;
uniform vec3 _PlanetOrigin;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec3 p_3;
  p_3 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.w = sqrt(dot (p_3, p_3));
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.x = gl_MultiTexCoord0.x;
  tmpvar_5.y = gl_MultiTexCoord0.y;
  tmpvar_5.z = gl_MultiTexCoord1.x;
  tmpvar_5.w = gl_MultiTexCoord1.y;
  vec3 tmpvar_6;
  tmpvar_6 = -(tmpvar_5.xyz);
  tmpvar_1.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, normalize(_SunDir));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_Color;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_4).xyz);
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = mix (1.0, clamp (floor((1.01 + tmpvar_7)), 0.0, 1.0), clamp ((10.0 * -(tmpvar_7)), 0.0, 1.0));
  xlv_TEXCOORD7 = (_PlanetOrigin - _WorldSpaceCameraPos);
  xlv_TEXCOORD8 = normalize((tmpvar_2 - _WorldSpaceCameraPos));
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform sampler2D _BumpMap;
uniform sampler2D _midTex;
uniform sampler2D _steepTex;
uniform float _DetailScale;
uniform float _DetailVertScale;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec3 norm_1;
  vec2 uv_2;
  vec2 localCoords_3;
  vec4 detail_4;
  float vertLerp_5;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD5);
  float r_7;
  if ((abs(tmpvar_6.z) > (1e-08 * abs(tmpvar_6.x)))) {
    float y_over_x_8;
    y_over_x_8 = (tmpvar_6.x / tmpvar_6.z);
    float s_9;
    float x_10;
    x_10 = (y_over_x_8 * inversesqrt(((y_over_x_8 * y_over_x_8) + 1.0)));
    s_9 = (sign(x_10) * (1.5708 - (sqrt((1.0 - abs(x_10))) * (1.5708 + (abs(x_10) * (-0.214602 + (abs(x_10) * (0.0865667 + (abs(x_10) * -0.0310296)))))))));
    r_7 = s_9;
    if ((tmpvar_6.z < 0.0)) {
      if ((tmpvar_6.x >= 0.0)) {
        r_7 = (s_9 + 3.14159);
      } else {
        r_7 = (r_7 - 3.14159);
      };
    };
  } else {
    r_7 = (sign(tmpvar_6.x) * 1.5708);
  };
  vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  vertLerp_5 = clamp (((32.0 * (clamp (dot (xlv_TEXCOORD1.xyz, -(tmpvar_11)), 0.0, 1.0) - 0.95)) + 0.5), 0.0, 1.0);
  vec2 uv_12;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD5);
  vec2 uv_14;
  float r_15;
  if ((abs(tmpvar_13.z) > (1e-08 * abs(tmpvar_13.x)))) {
    float y_over_x_16;
    y_over_x_16 = (tmpvar_13.x / tmpvar_13.z);
    float s_17;
    float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((tmpvar_13.z < 0.0)) {
      if ((tmpvar_13.x >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(tmpvar_13.x) * 1.5708);
  };
  uv_14.x = (0.5 + (0.159155 * r_15));
  uv_14.y = (0.31831 * (1.5708 - (sign(tmpvar_13.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_13.y))) * (1.5708 + (abs(tmpvar_13.y) * (-0.214602 + (abs(tmpvar_13.y) * (0.0865667 + (abs(tmpvar_13.y) * -0.0310296)))))))))));
  uv_12.x = (uv_14.x * (4.0 * _DetailScale));
  uv_12.y = (uv_14.y * (2.0 * _DetailScale));
  vec2 tmpvar_19;
  tmpvar_19 = dFdx(tmpvar_13.xz);
  vec2 tmpvar_20;
  tmpvar_20 = dFdy(tmpvar_13.xz);
  vec4 tmpvar_21;
  tmpvar_21.x = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_21.y = dFdx(uv_12.y);
  tmpvar_21.z = (0.31831 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_21.w = dFdy(uv_12.y);
  vec2 tmpvar_22;
  vec3 tmpvar_23;
  tmpvar_23 = abs(tmpvar_13);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_23.z >= tmpvar_23.x));
  float tmpvar_25;
  tmpvar_25 = float((mix (tmpvar_23.x, tmpvar_23.z, tmpvar_24) >= tmpvar_23.y));
  float tmpvar_26;
  tmpvar_26 = sign(mix (-(tmpvar_13.y), mix (tmpvar_13.x, tmpvar_13.z, tmpvar_24), tmpvar_25));
  vec3 tmpvar_27;
  tmpvar_27.xz = vec2(1.0, 1.0);
  tmpvar_27.y = -(tmpvar_26);
  vec3 tmpvar_28;
  tmpvar_28.xz = vec2(1.0, 1.0);
  tmpvar_28.y = tmpvar_26;
  vec3 tmpvar_29;
  tmpvar_29.xy = vec2(1.0, 1.0);
  tmpvar_29.z = -(tmpvar_26);
  vec3 tmpvar_30;
  tmpvar_30 = mix ((tmpvar_29 * tmpvar_13.yzx), mix ((tmpvar_27 * tmpvar_13.xzy), (tmpvar_28 * tmpvar_13.zxy), vec3(tmpvar_24)), vec3(tmpvar_25));
  tmpvar_22 = (((0.5 * tmpvar_30.yz) / abs(tmpvar_30.x)) + 0.5);
  uv_12 = tmpvar_22;
  detail_4 = texture2DGradARB (_midTex, (tmpvar_22 * _DetailScale), tmpvar_21.xy, tmpvar_21.zw);
  vec2 uv_31;
  vec3 tmpvar_32;
  tmpvar_32 = normalize(xlv_TEXCOORD5);
  vec2 uv_33;
  float r_34;
  if ((abs(tmpvar_32.z) > (1e-08 * abs(tmpvar_32.x)))) {
    float y_over_x_35;
    y_over_x_35 = (tmpvar_32.x / tmpvar_32.z);
    float s_36;
    float x_37;
    x_37 = (y_over_x_35 * inversesqrt(((y_over_x_35 * y_over_x_35) + 1.0)));
    s_36 = (sign(x_37) * (1.5708 - (sqrt((1.0 - abs(x_37))) * (1.5708 + (abs(x_37) * (-0.214602 + (abs(x_37) * (0.0865667 + (abs(x_37) * -0.0310296)))))))));
    r_34 = s_36;
    if ((tmpvar_32.z < 0.0)) {
      if ((tmpvar_32.x >= 0.0)) {
        r_34 = (s_36 + 3.14159);
      } else {
        r_34 = (r_34 - 3.14159);
      };
    };
  } else {
    r_34 = (sign(tmpvar_32.x) * 1.5708);
  };
  uv_33.x = (0.5 + (0.159155 * r_34));
  uv_33.y = (0.31831 * (1.5708 - (sign(tmpvar_32.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_32.y))) * (1.5708 + (abs(tmpvar_32.y) * (-0.214602 + (abs(tmpvar_32.y) * (0.0865667 + (abs(tmpvar_32.y) * -0.0310296)))))))))));
  uv_31.x = (uv_33.x * (4.0 * _DetailVertScale));
  uv_31.y = (uv_33.y * (2.0 * _DetailVertScale));
  vec2 tmpvar_38;
  tmpvar_38 = dFdx(tmpvar_32.xz);
  vec2 tmpvar_39;
  tmpvar_39 = dFdy(tmpvar_32.xz);
  vec4 tmpvar_40;
  tmpvar_40.x = (0.159155 * sqrt(dot (tmpvar_38, tmpvar_38)));
  tmpvar_40.y = dFdx(uv_31.y);
  tmpvar_40.z = (0.31831 * sqrt(dot (tmpvar_39, tmpvar_39)));
  tmpvar_40.w = dFdy(uv_31.y);
  vec2 tmpvar_41;
  vec3 tmpvar_42;
  tmpvar_42 = abs(tmpvar_32);
  float tmpvar_43;
  tmpvar_43 = float((tmpvar_42.z >= tmpvar_42.x));
  float tmpvar_44;
  tmpvar_44 = float((mix (tmpvar_42.x, tmpvar_42.z, tmpvar_43) >= tmpvar_42.y));
  float tmpvar_45;
  tmpvar_45 = sign(mix (-(tmpvar_32.y), mix (tmpvar_32.x, tmpvar_32.z, tmpvar_43), tmpvar_44));
  vec3 tmpvar_46;
  tmpvar_46.xz = vec2(1.0, 1.0);
  tmpvar_46.y = -(tmpvar_45);
  vec3 tmpvar_47;
  tmpvar_47.xz = vec2(1.0, 1.0);
  tmpvar_47.y = tmpvar_45;
  vec3 tmpvar_48;
  tmpvar_48.xy = vec2(1.0, 1.0);
  tmpvar_48.z = -(tmpvar_45);
  vec3 tmpvar_49;
  tmpvar_49 = mix ((tmpvar_48 * tmpvar_32.yzx), mix ((tmpvar_46 * tmpvar_32.xzy), (tmpvar_47 * tmpvar_32.zxy), vec3(tmpvar_43)), vec3(tmpvar_44));
  tmpvar_41 = (((0.5 * tmpvar_49.yz) / abs(tmpvar_49.x)) + 0.5);
  uv_31 = tmpvar_41;
  detail_4 = mix (texture2DGradARB (_steepTex, (tmpvar_41 * _DetailVertScale), tmpvar_40.xy, tmpvar_40.zw), detail_4, vec4(vertLerp_5));
  vec3 tmpvar_50;
  tmpvar_50 = normalize(xlv_TEXCOORD5);
  vec2 uv_51;
  float r_52;
  if ((abs(tmpvar_50.z) > (1e-08 * abs(tmpvar_50.x)))) {
    float y_over_x_53;
    y_over_x_53 = (tmpvar_50.x / tmpvar_50.z);
    float s_54;
    float x_55;
    x_55 = (y_over_x_53 * inversesqrt(((y_over_x_53 * y_over_x_53) + 1.0)));
    s_54 = (sign(x_55) * (1.5708 - (sqrt((1.0 - abs(x_55))) * (1.5708 + (abs(x_55) * (-0.214602 + (abs(x_55) * (0.0865667 + (abs(x_55) * -0.0310296)))))))));
    r_52 = s_54;
    if ((tmpvar_50.z < 0.0)) {
      if ((tmpvar_50.x >= 0.0)) {
        r_52 = (s_54 + 3.14159);
      } else {
        r_52 = (r_52 - 3.14159);
      };
    };
  } else {
    r_52 = (sign(tmpvar_50.x) * 1.5708);
  };
  uv_51.x = (0.5 + (0.159155 * r_52));
  uv_51.y = (0.31831 * (1.5708 - (sign(tmpvar_50.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_50.y))) * (1.5708 + (abs(tmpvar_50.y) * (-0.214602 + (abs(tmpvar_50.y) * (0.0865667 + (abs(tmpvar_50.y) * -0.0310296)))))))))));
  vec2 tmpvar_56;
  tmpvar_56 = dFdx(tmpvar_50.xz);
  vec2 tmpvar_57;
  tmpvar_57 = dFdy(tmpvar_50.xz);
  vec4 tmpvar_58;
  tmpvar_58.x = (0.159155 * sqrt(dot (tmpvar_56, tmpvar_56)));
  tmpvar_58.y = dFdx(uv_51.y);
  tmpvar_58.z = (0.31831 * sqrt(dot (tmpvar_57, tmpvar_57)));
  tmpvar_58.w = dFdy(uv_51.y);
  vec2 tmpvar_59;
  tmpvar_59 = (texture2DGradARB (_BumpMap, uv_51, tmpvar_58.xy, tmpvar_58.zw).wy - vec2(0.5, 0.5));
  localCoords_3.y = tmpvar_59.y;
  localCoords_3.x = (tmpvar_59.x * 0.5);
  float r_60;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    float y_over_x_61;
    y_over_x_61 = (tmpvar_11.x / tmpvar_11.z);
    float s_62;
    float x_63;
    x_63 = (y_over_x_61 * inversesqrt(((y_over_x_61 * y_over_x_61) + 1.0)));
    s_62 = (sign(x_63) * (1.5708 - (sqrt((1.0 - abs(x_63))) * (1.5708 + (abs(x_63) * (-0.214602 + (abs(x_63) * (0.0865667 + (abs(x_63) * -0.0310296)))))))));
    r_60 = s_62;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_60 = (s_62 + 3.14159);
      } else {
        r_60 = (r_60 - 3.14159);
      };
    };
  } else {
    r_60 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_60));
  uv_2.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  uv_2.x = (uv_2.x - 0.5);
  vec2 tmpvar_64;
  tmpvar_64 = (uv_2 + localCoords_3);
  uv_2 = tmpvar_64;
  norm_1.z = cos((6.28319 * tmpvar_64.x));
  norm_1.x = sin((6.28319 * tmpvar_64.x));
  norm_1.y = cos((3.14159 * tmpvar_64.y));
  norm_1 = -(norm_1);
  gl_FragData[0] = xlv_TEXCOORD0;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 39 math
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_SunDir]
Vector 10 [_PlanetOrigin]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord4 o3
dcl_texcoord5 o4
dcl_texcoord6 o5
dcl_texcoord7 o6
dcl_texcoord8 o7
def c11, 0.00000000, 10.00000000, 1.00976563, -1.00000000
def c12, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dp3 r0.x, c9, c9
rsq r0.x, r0.x
mul r1.xyz, r0.x, c9
mov r1.w, c11.x
mov r0.xy, v3
mov r0.z, v4.x
dp3 r0.w, -r0, r1
mov r1.xyz, v2
dp4 r2.x, r1, c4
dp4 r2.z, r1, c6
dp4 r2.y, r1, c5
add r2.w, r0, c11.z
dp3 r1.x, r2, r2
rsq r1.x, r1.x
mul o3.xyz, r1.x, r2
frc r1.y, r2.w
add_sat r1.y, r2.w, -r1
add r1.w, r1.y, c11
mul_sat r2.x, -r0.w, c11.y
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
add r1.xyz, -r1, c8
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul o7.xyz, r0.w, -r1
mov r1.xyz, c10
mad o5.x, r2, r1.w, c12
mov o1, v1
mov o2.xyz, v2
rcp o2.w, r0.w
mov o4.xyz, -r0
add o6.xyz, -c8, r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 29 math
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 336
Vector 272 [_SunDir] 3
Vector 320 [_PlanetOrigin] 3
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedldodeepgaojonhjfbabdojhchhichglpabaaaaaammagaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaakoaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapabaaaalhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaaaaaafaepfdejfeejepeoaaedepemepfcaaeoepfceneb
emaafeeffiedepepfceeaafeebeoehefeofeaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiahaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaahaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaneaaaaaaaiaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oiaeaaaaeaaaabaadkabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaadbcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadiccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaabaaaaaaegbobaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaelaaaaaficcabaaaacaaaaaadkaabaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegbcbaaaacaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaacaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaaj
bcaabaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaaegiccaaaaaaaaaaabbaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadgaaaaafdcaabaaaabaaaaaa
egbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaaeaaaaaabaaaaaai
bcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaaaaaaaaadgaaaaag
hccabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaakoehibdpdicaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaacambebcaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaialpdcaaaaaj
iccabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaabeaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec3 _SunDir;
uniform highp vec3 _PlanetOrigin;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump float NdotL_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  tmpvar_3.w = sqrt(dot (p_6, p_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = tmpvar_1;
  highp vec4 tmpvar_8;
  tmpvar_8.x = _glesMultiTexCoord0.x;
  tmpvar_8.y = _glesMultiTexCoord0.y;
  tmpvar_8.z = _glesMultiTexCoord1.x;
  tmpvar_8.w = _glesMultiTexCoord1.y;
  highp vec3 tmpvar_9;
  tmpvar_9 = -(tmpvar_8.xyz);
  tmpvar_3.xyz = tmpvar_1;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(_SunDir);
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_10);
  NdotL_2 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = mix (1.0, clamp (floor((1.01 + NdotL_2)), 0.0, 1.0), clamp ((10.0 * -(NdotL_2)), 0.0, 1.0));
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_7).xyz);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = (_PlanetOrigin - _WorldSpaceCameraPos);
  xlv_TEXCOORD8 = normalize((tmpvar_5 - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _midTex;
uniform sampler2D _steepTex;
uniform highp float _DetailScale;
uniform highp float _DetailVertScale;
uniform highp float _DetailDist;
uniform highp float _PlanetOpacity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float handoff_2;
  mediump float detailLevel_3;
  mediump vec3 norm_4;
  highp vec2 uv_5;
  highp vec2 localCoords_6;
  mediump vec4 detail_7;
  mediump float vertLerp_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.31831 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD5);
  highp float tmpvar_22;
  tmpvar_22 = clamp (((32.0 * (clamp (dot (xlv_TEXCOORD1.xyz, -(tmpvar_21)), 0.0, 1.0) - 0.95)) + 0.5), 0.0, 1.0);
  vertLerp_8 = tmpvar_22;
  mediump vec4 tex_23;
  highp vec2 uv_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  uv_24.x = (uv_26.x * (4.0 * _DetailScale));
  uv_24.y = (uv_26.y * (2.0 * _DetailScale));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_24.y);
  tmpvar_33.z = (0.31831 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_24.y);
  highp vec2 tmpvar_34;
  mediump float s_35;
  mediump float nylerp_36;
  mediump float zxlerp_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(tmpvar_25);
  highp float tmpvar_39;
  tmpvar_39 = float((tmpvar_38.z >= tmpvar_38.x));
  zxlerp_37 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = float((mix (tmpvar_38.x, tmpvar_38.z, zxlerp_37) >= tmpvar_38.y));
  nylerp_36 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = mix (tmpvar_25.x, tmpvar_25.z, zxlerp_37);
  s_35 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = sign(mix (-(tmpvar_25.y), s_35, nylerp_36));
  s_35 = tmpvar_42;
  mediump vec3 tmpvar_43;
  tmpvar_43.xz = vec2(1.0, 1.0);
  tmpvar_43.y = -(s_35);
  mediump vec3 tmpvar_44;
  tmpvar_44.xz = vec2(1.0, 1.0);
  tmpvar_44.y = s_35;
  mediump vec3 tmpvar_45;
  tmpvar_45.xy = vec2(1.0, 1.0);
  tmpvar_45.z = -(s_35);
  highp vec3 tmpvar_46;
  tmpvar_46 = mix ((tmpvar_45 * tmpvar_25.yzx), mix ((tmpvar_43 * tmpvar_25.xzy), (tmpvar_44 * tmpvar_25.zxy), vec3(zxlerp_37)), vec3(nylerp_36));
  tmpvar_34 = (((0.5 * tmpvar_46.yz) / abs(tmpvar_46.x)) + 0.5);
  uv_24 = tmpvar_34;
  highp vec2 coord_47;
  coord_47 = (tmpvar_34 * _DetailScale);
  lowp vec4 tmpvar_48;
  tmpvar_48 = texture2DGradEXT (_midTex, coord_47, tmpvar_33.xy, tmpvar_33.zw);
  tex_23 = tmpvar_48;
  detail_7 = tex_23;
  mediump vec4 tex_49;
  highp vec2 uv_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_52;
  highp float r_53;
  if ((abs(tmpvar_51.z) > (1e-08 * abs(tmpvar_51.x)))) {
    highp float y_over_x_54;
    y_over_x_54 = (tmpvar_51.x / tmpvar_51.z);
    highp float s_55;
    highp float x_56;
    x_56 = (y_over_x_54 * inversesqrt(((y_over_x_54 * y_over_x_54) + 1.0)));
    s_55 = (sign(x_56) * (1.5708 - (sqrt((1.0 - abs(x_56))) * (1.5708 + (abs(x_56) * (-0.214602 + (abs(x_56) * (0.0865667 + (abs(x_56) * -0.0310296)))))))));
    r_53 = s_55;
    if ((tmpvar_51.z < 0.0)) {
      if ((tmpvar_51.x >= 0.0)) {
        r_53 = (s_55 + 3.14159);
      } else {
        r_53 = (r_53 - 3.14159);
      };
    };
  } else {
    r_53 = (sign(tmpvar_51.x) * 1.5708);
  };
  uv_52.x = (0.5 + (0.159155 * r_53));
  uv_52.y = (0.31831 * (1.5708 - (sign(tmpvar_51.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_51.y))) * (1.5708 + (abs(tmpvar_51.y) * (-0.214602 + (abs(tmpvar_51.y) * (0.0865667 + (abs(tmpvar_51.y) * -0.0310296)))))))))));
  uv_50.x = (uv_52.x * (4.0 * _DetailVertScale));
  uv_50.y = (uv_52.y * (2.0 * _DetailVertScale));
  highp vec2 tmpvar_57;
  tmpvar_57 = dFdx(tmpvar_51.xz);
  highp vec2 tmpvar_58;
  tmpvar_58 = dFdy(tmpvar_51.xz);
  highp vec4 tmpvar_59;
  tmpvar_59.x = (0.159155 * sqrt(dot (tmpvar_57, tmpvar_57)));
  tmpvar_59.y = dFdx(uv_50.y);
  tmpvar_59.z = (0.31831 * sqrt(dot (tmpvar_58, tmpvar_58)));
  tmpvar_59.w = dFdy(uv_50.y);
  highp vec2 tmpvar_60;
  mediump float s_61;
  mediump float nylerp_62;
  mediump float zxlerp_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = abs(tmpvar_51);
  highp float tmpvar_65;
  tmpvar_65 = float((tmpvar_64.z >= tmpvar_64.x));
  zxlerp_63 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = float((mix (tmpvar_64.x, tmpvar_64.z, zxlerp_63) >= tmpvar_64.y));
  nylerp_62 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = mix (tmpvar_51.x, tmpvar_51.z, zxlerp_63);
  s_61 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = sign(mix (-(tmpvar_51.y), s_61, nylerp_62));
  s_61 = tmpvar_68;
  mediump vec3 tmpvar_69;
  tmpvar_69.xz = vec2(1.0, 1.0);
  tmpvar_69.y = -(s_61);
  mediump vec3 tmpvar_70;
  tmpvar_70.xz = vec2(1.0, 1.0);
  tmpvar_70.y = s_61;
  mediump vec3 tmpvar_71;
  tmpvar_71.xy = vec2(1.0, 1.0);
  tmpvar_71.z = -(s_61);
  highp vec3 tmpvar_72;
  tmpvar_72 = mix ((tmpvar_71 * tmpvar_51.yzx), mix ((tmpvar_69 * tmpvar_51.xzy), (tmpvar_70 * tmpvar_51.zxy), vec3(zxlerp_63)), vec3(nylerp_62));
  tmpvar_60 = (((0.5 * tmpvar_72.yz) / abs(tmpvar_72.x)) + 0.5);
  uv_50 = tmpvar_60;
  highp vec2 coord_73;
  coord_73 = (tmpvar_60 * _DetailVertScale);
  lowp vec4 tmpvar_74;
  tmpvar_74 = texture2DGradEXT (_steepTex, coord_73, tmpvar_59.xy, tmpvar_59.zw);
  tex_49 = tmpvar_74;
  detail_7 = mix (tex_49, tex_23, vec4(vertLerp_8));
  mediump vec4 tex_75;
  highp vec3 tmpvar_76;
  tmpvar_76 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_77;
  highp float r_78;
  if ((abs(tmpvar_76.z) > (1e-08 * abs(tmpvar_76.x)))) {
    highp float y_over_x_79;
    y_over_x_79 = (tmpvar_76.x / tmpvar_76.z);
    highp float s_80;
    highp float x_81;
    x_81 = (y_over_x_79 * inversesqrt(((y_over_x_79 * y_over_x_79) + 1.0)));
    s_80 = (sign(x_81) * (1.5708 - (sqrt((1.0 - abs(x_81))) * (1.5708 + (abs(x_81) * (-0.214602 + (abs(x_81) * (0.0865667 + (abs(x_81) * -0.0310296)))))))));
    r_78 = s_80;
    if ((tmpvar_76.z < 0.0)) {
      if ((tmpvar_76.x >= 0.0)) {
        r_78 = (s_80 + 3.14159);
      } else {
        r_78 = (r_78 - 3.14159);
      };
    };
  } else {
    r_78 = (sign(tmpvar_76.x) * 1.5708);
  };
  uv_77.x = (0.5 + (0.159155 * r_78));
  uv_77.y = (0.31831 * (1.5708 - (sign(tmpvar_76.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_76.y))) * (1.5708 + (abs(tmpvar_76.y) * (-0.214602 + (abs(tmpvar_76.y) * (0.0865667 + (abs(tmpvar_76.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_82;
  tmpvar_82 = dFdx(tmpvar_76.xz);
  highp vec2 tmpvar_83;
  tmpvar_83 = dFdy(tmpvar_76.xz);
  highp vec4 tmpvar_84;
  tmpvar_84.x = (0.159155 * sqrt(dot (tmpvar_82, tmpvar_82)));
  tmpvar_84.y = dFdx(uv_77.y);
  tmpvar_84.z = (0.31831 * sqrt(dot (tmpvar_83, tmpvar_83)));
  tmpvar_84.w = dFdy(uv_77.y);
  lowp vec4 tmpvar_85;
  tmpvar_85 = texture2DGradEXT (_BumpMap, uv_77, tmpvar_84.xy, tmpvar_84.zw);
  tex_75 = tmpvar_85;
  mediump vec2 tmpvar_86;
  tmpvar_86 = tex_75.wy;
  localCoords_6 = tmpvar_86;
  highp vec2 tmpvar_87;
  tmpvar_87 = (localCoords_6 - vec2(0.5, 0.5));
  localCoords_6.y = tmpvar_87.y;
  localCoords_6.x = (tmpvar_87.x * 0.5);
  highp float r_88;
  if ((abs(tmpvar_21.z) > (1e-08 * abs(tmpvar_21.x)))) {
    highp float y_over_x_89;
    y_over_x_89 = (tmpvar_21.x / tmpvar_21.z);
    float s_90;
    highp float x_91;
    x_91 = (y_over_x_89 * inversesqrt(((y_over_x_89 * y_over_x_89) + 1.0)));
    s_90 = (sign(x_91) * (1.5708 - (sqrt((1.0 - abs(x_91))) * (1.5708 + (abs(x_91) * (-0.214602 + (abs(x_91) * (0.0865667 + (abs(x_91) * -0.0310296)))))))));
    r_88 = s_90;
    if ((tmpvar_21.z < 0.0)) {
      if ((tmpvar_21.x >= 0.0)) {
        r_88 = (s_90 + 3.14159);
      } else {
        r_88 = (r_88 - 3.14159);
      };
    };
  } else {
    r_88 = (sign(tmpvar_21.x) * 1.5708);
  };
  uv_5.x = (0.5 + (0.159155 * r_88));
  uv_5.y = (0.31831 * (1.5708 - (sign(tmpvar_21.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_21.y))) * (1.5708 + (abs(tmpvar_21.y) * (-0.214602 + (abs(tmpvar_21.y) * (0.0865667 + (abs(tmpvar_21.y) * -0.0310296)))))))))));
  uv_5.x = (uv_5.x - 0.5);
  highp vec2 tmpvar_92;
  tmpvar_92 = (uv_5 + localCoords_6);
  uv_5 = tmpvar_92;
  highp float tmpvar_93;
  tmpvar_93 = cos((6.28319 * tmpvar_92.x));
  norm_4.z = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = sin((6.28319 * tmpvar_92.x));
  norm_4.x = tmpvar_94;
  highp float tmpvar_95;
  tmpvar_95 = cos((3.14159 * tmpvar_92.y));
  norm_4.y = tmpvar_95;
  norm_4 = -(norm_4);
  highp float tmpvar_96;
  tmpvar_96 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1.w), 0.0, 1.0);
  detailLevel_3 = tmpvar_96;
  mediump vec4 tmpvar_97;
  tmpvar_97 = mix ((detail_7 - 0.5), vec4(0.0, 0.0, 0.0, 0.0), vec4(detailLevel_3));
  highp vec4 tmpvar_98;
  tmpvar_98 = (xlv_TEXCOORD0 + (0.75 * tmpvar_97));
  color_9 = tmpvar_98;
  highp float tmpvar_99;
  tmpvar_99 = clamp (pow (_PlanetOpacity, 2.0), 0.0, 1.0);
  handoff_2 = tmpvar_99;
  color_9.xyz = (mix (color_9, tex_10, vec4(handoff_2)) * _Color).xyz;
  highp vec3 tmpvar_100;
  tmpvar_100 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_101;
  lightDir_101 = tmpvar_100;
  mediump vec3 viewDir_102;
  viewDir_102 = xlv_TEXCOORD8;
  mediump vec3 normal_103;
  normal_103 = xlv_TEXCOORD4;
  lightDir_101 = normalize(lightDir_101);
  viewDir_102 = normalize(viewDir_102);
  normal_103 = normalize(normal_103);
  color_9.w = 1.0;
  tmpvar_1 = xlv_TEXCOORD0;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec3 _SunDir;
uniform highp vec3 _PlanetOrigin;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump float NdotL_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  tmpvar_3.w = sqrt(dot (p_6, p_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = tmpvar_1;
  highp vec4 tmpvar_8;
  tmpvar_8.x = _glesMultiTexCoord0.x;
  tmpvar_8.y = _glesMultiTexCoord0.y;
  tmpvar_8.z = _glesMultiTexCoord1.x;
  tmpvar_8.w = _glesMultiTexCoord1.y;
  highp vec3 tmpvar_9;
  tmpvar_9 = -(tmpvar_8.xyz);
  tmpvar_3.xyz = tmpvar_1;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(_SunDir);
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_10);
  NdotL_2 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = mix (1.0, clamp (floor((1.01 + NdotL_2)), 0.0, 1.0), clamp ((10.0 * -(NdotL_2)), 0.0, 1.0));
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_7).xyz);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = (_PlanetOrigin - _WorldSpaceCameraPos);
  xlv_TEXCOORD8 = normalize((tmpvar_5 - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _midTex;
uniform sampler2D _steepTex;
uniform highp float _DetailScale;
uniform highp float _DetailVertScale;
uniform highp float _DetailDist;
uniform highp float _PlanetOpacity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float handoff_2;
  mediump float detailLevel_3;
  mediump vec3 norm_4;
  highp vec2 uv_5;
  highp vec2 localCoords_6;
  mediump vec4 detail_7;
  mediump float vertLerp_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.31831 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD5);
  highp float tmpvar_22;
  tmpvar_22 = clamp (((32.0 * (clamp (dot (xlv_TEXCOORD1.xyz, -(tmpvar_21)), 0.0, 1.0) - 0.95)) + 0.5), 0.0, 1.0);
  vertLerp_8 = tmpvar_22;
  mediump vec4 tex_23;
  highp vec2 uv_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  uv_24.x = (uv_26.x * (4.0 * _DetailScale));
  uv_24.y = (uv_26.y * (2.0 * _DetailScale));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_24.y);
  tmpvar_33.z = (0.31831 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_24.y);
  highp vec2 tmpvar_34;
  mediump float s_35;
  mediump float nylerp_36;
  mediump float zxlerp_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(tmpvar_25);
  highp float tmpvar_39;
  tmpvar_39 = float((tmpvar_38.z >= tmpvar_38.x));
  zxlerp_37 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = float((mix (tmpvar_38.x, tmpvar_38.z, zxlerp_37) >= tmpvar_38.y));
  nylerp_36 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = mix (tmpvar_25.x, tmpvar_25.z, zxlerp_37);
  s_35 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = sign(mix (-(tmpvar_25.y), s_35, nylerp_36));
  s_35 = tmpvar_42;
  mediump vec3 tmpvar_43;
  tmpvar_43.xz = vec2(1.0, 1.0);
  tmpvar_43.y = -(s_35);
  mediump vec3 tmpvar_44;
  tmpvar_44.xz = vec2(1.0, 1.0);
  tmpvar_44.y = s_35;
  mediump vec3 tmpvar_45;
  tmpvar_45.xy = vec2(1.0, 1.0);
  tmpvar_45.z = -(s_35);
  highp vec3 tmpvar_46;
  tmpvar_46 = mix ((tmpvar_45 * tmpvar_25.yzx), mix ((tmpvar_43 * tmpvar_25.xzy), (tmpvar_44 * tmpvar_25.zxy), vec3(zxlerp_37)), vec3(nylerp_36));
  tmpvar_34 = (((0.5 * tmpvar_46.yz) / abs(tmpvar_46.x)) + 0.5);
  uv_24 = tmpvar_34;
  highp vec2 coord_47;
  coord_47 = (tmpvar_34 * _DetailScale);
  lowp vec4 tmpvar_48;
  tmpvar_48 = texture2DGradEXT (_midTex, coord_47, tmpvar_33.xy, tmpvar_33.zw);
  tex_23 = tmpvar_48;
  detail_7 = tex_23;
  mediump vec4 tex_49;
  highp vec2 uv_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_52;
  highp float r_53;
  if ((abs(tmpvar_51.z) > (1e-08 * abs(tmpvar_51.x)))) {
    highp float y_over_x_54;
    y_over_x_54 = (tmpvar_51.x / tmpvar_51.z);
    highp float s_55;
    highp float x_56;
    x_56 = (y_over_x_54 * inversesqrt(((y_over_x_54 * y_over_x_54) + 1.0)));
    s_55 = (sign(x_56) * (1.5708 - (sqrt((1.0 - abs(x_56))) * (1.5708 + (abs(x_56) * (-0.214602 + (abs(x_56) * (0.0865667 + (abs(x_56) * -0.0310296)))))))));
    r_53 = s_55;
    if ((tmpvar_51.z < 0.0)) {
      if ((tmpvar_51.x >= 0.0)) {
        r_53 = (s_55 + 3.14159);
      } else {
        r_53 = (r_53 - 3.14159);
      };
    };
  } else {
    r_53 = (sign(tmpvar_51.x) * 1.5708);
  };
  uv_52.x = (0.5 + (0.159155 * r_53));
  uv_52.y = (0.31831 * (1.5708 - (sign(tmpvar_51.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_51.y))) * (1.5708 + (abs(tmpvar_51.y) * (-0.214602 + (abs(tmpvar_51.y) * (0.0865667 + (abs(tmpvar_51.y) * -0.0310296)))))))))));
  uv_50.x = (uv_52.x * (4.0 * _DetailVertScale));
  uv_50.y = (uv_52.y * (2.0 * _DetailVertScale));
  highp vec2 tmpvar_57;
  tmpvar_57 = dFdx(tmpvar_51.xz);
  highp vec2 tmpvar_58;
  tmpvar_58 = dFdy(tmpvar_51.xz);
  highp vec4 tmpvar_59;
  tmpvar_59.x = (0.159155 * sqrt(dot (tmpvar_57, tmpvar_57)));
  tmpvar_59.y = dFdx(uv_50.y);
  tmpvar_59.z = (0.31831 * sqrt(dot (tmpvar_58, tmpvar_58)));
  tmpvar_59.w = dFdy(uv_50.y);
  highp vec2 tmpvar_60;
  mediump float s_61;
  mediump float nylerp_62;
  mediump float zxlerp_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = abs(tmpvar_51);
  highp float tmpvar_65;
  tmpvar_65 = float((tmpvar_64.z >= tmpvar_64.x));
  zxlerp_63 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = float((mix (tmpvar_64.x, tmpvar_64.z, zxlerp_63) >= tmpvar_64.y));
  nylerp_62 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = mix (tmpvar_51.x, tmpvar_51.z, zxlerp_63);
  s_61 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = sign(mix (-(tmpvar_51.y), s_61, nylerp_62));
  s_61 = tmpvar_68;
  mediump vec3 tmpvar_69;
  tmpvar_69.xz = vec2(1.0, 1.0);
  tmpvar_69.y = -(s_61);
  mediump vec3 tmpvar_70;
  tmpvar_70.xz = vec2(1.0, 1.0);
  tmpvar_70.y = s_61;
  mediump vec3 tmpvar_71;
  tmpvar_71.xy = vec2(1.0, 1.0);
  tmpvar_71.z = -(s_61);
  highp vec3 tmpvar_72;
  tmpvar_72 = mix ((tmpvar_71 * tmpvar_51.yzx), mix ((tmpvar_69 * tmpvar_51.xzy), (tmpvar_70 * tmpvar_51.zxy), vec3(zxlerp_63)), vec3(nylerp_62));
  tmpvar_60 = (((0.5 * tmpvar_72.yz) / abs(tmpvar_72.x)) + 0.5);
  uv_50 = tmpvar_60;
  highp vec2 coord_73;
  coord_73 = (tmpvar_60 * _DetailVertScale);
  lowp vec4 tmpvar_74;
  tmpvar_74 = texture2DGradEXT (_steepTex, coord_73, tmpvar_59.xy, tmpvar_59.zw);
  tex_49 = tmpvar_74;
  detail_7 = mix (tex_49, tex_23, vec4(vertLerp_8));
  mediump vec4 tex_75;
  highp vec3 tmpvar_76;
  tmpvar_76 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_77;
  highp float r_78;
  if ((abs(tmpvar_76.z) > (1e-08 * abs(tmpvar_76.x)))) {
    highp float y_over_x_79;
    y_over_x_79 = (tmpvar_76.x / tmpvar_76.z);
    highp float s_80;
    highp float x_81;
    x_81 = (y_over_x_79 * inversesqrt(((y_over_x_79 * y_over_x_79) + 1.0)));
    s_80 = (sign(x_81) * (1.5708 - (sqrt((1.0 - abs(x_81))) * (1.5708 + (abs(x_81) * (-0.214602 + (abs(x_81) * (0.0865667 + (abs(x_81) * -0.0310296)))))))));
    r_78 = s_80;
    if ((tmpvar_76.z < 0.0)) {
      if ((tmpvar_76.x >= 0.0)) {
        r_78 = (s_80 + 3.14159);
      } else {
        r_78 = (r_78 - 3.14159);
      };
    };
  } else {
    r_78 = (sign(tmpvar_76.x) * 1.5708);
  };
  uv_77.x = (0.5 + (0.159155 * r_78));
  uv_77.y = (0.31831 * (1.5708 - (sign(tmpvar_76.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_76.y))) * (1.5708 + (abs(tmpvar_76.y) * (-0.214602 + (abs(tmpvar_76.y) * (0.0865667 + (abs(tmpvar_76.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_82;
  tmpvar_82 = dFdx(tmpvar_76.xz);
  highp vec2 tmpvar_83;
  tmpvar_83 = dFdy(tmpvar_76.xz);
  highp vec4 tmpvar_84;
  tmpvar_84.x = (0.159155 * sqrt(dot (tmpvar_82, tmpvar_82)));
  tmpvar_84.y = dFdx(uv_77.y);
  tmpvar_84.z = (0.31831 * sqrt(dot (tmpvar_83, tmpvar_83)));
  tmpvar_84.w = dFdy(uv_77.y);
  lowp vec4 tmpvar_85;
  tmpvar_85 = texture2DGradEXT (_BumpMap, uv_77, tmpvar_84.xy, tmpvar_84.zw);
  tex_75 = tmpvar_85;
  mediump vec2 tmpvar_86;
  tmpvar_86 = tex_75.wy;
  localCoords_6 = tmpvar_86;
  highp vec2 tmpvar_87;
  tmpvar_87 = (localCoords_6 - vec2(0.5, 0.5));
  localCoords_6.y = tmpvar_87.y;
  localCoords_6.x = (tmpvar_87.x * 0.5);
  highp float r_88;
  if ((abs(tmpvar_21.z) > (1e-08 * abs(tmpvar_21.x)))) {
    highp float y_over_x_89;
    y_over_x_89 = (tmpvar_21.x / tmpvar_21.z);
    float s_90;
    highp float x_91;
    x_91 = (y_over_x_89 * inversesqrt(((y_over_x_89 * y_over_x_89) + 1.0)));
    s_90 = (sign(x_91) * (1.5708 - (sqrt((1.0 - abs(x_91))) * (1.5708 + (abs(x_91) * (-0.214602 + (abs(x_91) * (0.0865667 + (abs(x_91) * -0.0310296)))))))));
    r_88 = s_90;
    if ((tmpvar_21.z < 0.0)) {
      if ((tmpvar_21.x >= 0.0)) {
        r_88 = (s_90 + 3.14159);
      } else {
        r_88 = (r_88 - 3.14159);
      };
    };
  } else {
    r_88 = (sign(tmpvar_21.x) * 1.5708);
  };
  uv_5.x = (0.5 + (0.159155 * r_88));
  uv_5.y = (0.31831 * (1.5708 - (sign(tmpvar_21.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_21.y))) * (1.5708 + (abs(tmpvar_21.y) * (-0.214602 + (abs(tmpvar_21.y) * (0.0865667 + (abs(tmpvar_21.y) * -0.0310296)))))))))));
  uv_5.x = (uv_5.x - 0.5);
  highp vec2 tmpvar_92;
  tmpvar_92 = (uv_5 + localCoords_6);
  uv_5 = tmpvar_92;
  highp float tmpvar_93;
  tmpvar_93 = cos((6.28319 * tmpvar_92.x));
  norm_4.z = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = sin((6.28319 * tmpvar_92.x));
  norm_4.x = tmpvar_94;
  highp float tmpvar_95;
  tmpvar_95 = cos((3.14159 * tmpvar_92.y));
  norm_4.y = tmpvar_95;
  norm_4 = -(norm_4);
  highp float tmpvar_96;
  tmpvar_96 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1.w), 0.0, 1.0);
  detailLevel_3 = tmpvar_96;
  mediump vec4 tmpvar_97;
  tmpvar_97 = mix ((detail_7 - 0.5), vec4(0.0, 0.0, 0.0, 0.0), vec4(detailLevel_3));
  highp vec4 tmpvar_98;
  tmpvar_98 = (xlv_TEXCOORD0 + (0.75 * tmpvar_97));
  color_9 = tmpvar_98;
  highp float tmpvar_99;
  tmpvar_99 = clamp (pow (_PlanetOpacity, 2.0), 0.0, 1.0);
  handoff_2 = tmpvar_99;
  color_9.xyz = (mix (color_9, tex_10, vec4(handoff_2)) * _Color).xyz;
  highp vec3 tmpvar_100;
  tmpvar_100 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_101;
  lightDir_101 = tmpvar_100;
  mediump vec3 viewDir_102;
  viewDir_102 = xlv_TEXCOORD8;
  mediump vec3 normal_103;
  normal_103 = xlv_TEXCOORD4;
  lightDir_101 = normalize(lightDir_101);
  viewDir_102 = normalize(viewDir_102);
  normal_103 = normalize(normal_103);
  color_9.w = 1.0;
  tmpvar_1 = xlv_TEXCOORD0;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec3 _SunDir;
uniform highp vec3 _PlanetOrigin;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp float xlv_TEXCOORD6;
out highp vec3 xlv_TEXCOORD7;
out highp vec3 xlv_TEXCOORD8;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump float NdotL_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_Object2World * _glesVertex).xyz;
  highp vec3 p_6;
  p_6 = (tmpvar_5 - _WorldSpaceCameraPos);
  tmpvar_3.w = sqrt(dot (p_6, p_6));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = tmpvar_1;
  highp vec4 tmpvar_8;
  tmpvar_8.x = _glesMultiTexCoord0.x;
  tmpvar_8.y = _glesMultiTexCoord0.y;
  tmpvar_8.z = _glesMultiTexCoord1.x;
  tmpvar_8.w = _glesMultiTexCoord1.y;
  highp vec3 tmpvar_9;
  tmpvar_9 = -(tmpvar_8.xyz);
  tmpvar_3.xyz = tmpvar_1;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(_SunDir);
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_10);
  NdotL_2 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = mix (1.0, clamp (floor((1.01 + NdotL_2)), 0.0, 1.0), clamp ((10.0 * -(NdotL_2)), 0.0, 1.0));
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD4 = normalize((_Object2World * tmpvar_7).xyz);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = (_PlanetOrigin - _WorldSpaceCameraPos);
  xlv_TEXCOORD8 = normalize((tmpvar_5 - _WorldSpaceCameraPos));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _midTex;
uniform sampler2D _steepTex;
uniform highp float _DetailScale;
uniform highp float _DetailVertScale;
uniform highp float _DetailDist;
uniform highp float _PlanetOpacity;
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD8;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float handoff_2;
  mediump float detailLevel_3;
  mediump vec3 norm_4;
  highp vec2 uv_5;
  highp vec2 localCoords_6;
  mediump vec4 detail_7;
  mediump float vertLerp_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.31831 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = textureGrad (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD5);
  highp float tmpvar_22;
  tmpvar_22 = clamp (((32.0 * (clamp (dot (xlv_TEXCOORD1.xyz, -(tmpvar_21)), 0.0, 1.0) - 0.95)) + 0.5), 0.0, 1.0);
  vertLerp_8 = tmpvar_22;
  mediump vec4 tex_23;
  highp vec2 uv_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  uv_24.x = (uv_26.x * (4.0 * _DetailScale));
  uv_24.y = (uv_26.y * (2.0 * _DetailScale));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_24.y);
  tmpvar_33.z = (0.31831 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_24.y);
  highp vec2 tmpvar_34;
  mediump float s_35;
  mediump float nylerp_36;
  mediump float zxlerp_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = abs(tmpvar_25);
  highp float tmpvar_39;
  tmpvar_39 = float((tmpvar_38.z >= tmpvar_38.x));
  zxlerp_37 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = float((mix (tmpvar_38.x, tmpvar_38.z, zxlerp_37) >= tmpvar_38.y));
  nylerp_36 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = mix (tmpvar_25.x, tmpvar_25.z, zxlerp_37);
  s_35 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = sign(mix (-(tmpvar_25.y), s_35, nylerp_36));
  s_35 = tmpvar_42;
  mediump vec3 tmpvar_43;
  tmpvar_43.xz = vec2(1.0, 1.0);
  tmpvar_43.y = -(s_35);
  mediump vec3 tmpvar_44;
  tmpvar_44.xz = vec2(1.0, 1.0);
  tmpvar_44.y = s_35;
  mediump vec3 tmpvar_45;
  tmpvar_45.xy = vec2(1.0, 1.0);
  tmpvar_45.z = -(s_35);
  highp vec3 tmpvar_46;
  tmpvar_46 = mix ((tmpvar_45 * tmpvar_25.yzx), mix ((tmpvar_43 * tmpvar_25.xzy), (tmpvar_44 * tmpvar_25.zxy), vec3(zxlerp_37)), vec3(nylerp_36));
  tmpvar_34 = (((0.5 * tmpvar_46.yz) / abs(tmpvar_46.x)) + 0.5);
  uv_24 = tmpvar_34;
  highp vec2 coord_47;
  coord_47 = (tmpvar_34 * _DetailScale);
  lowp vec4 tmpvar_48;
  tmpvar_48 = textureGrad (_midTex, coord_47, tmpvar_33.xy, tmpvar_33.zw);
  tex_23 = tmpvar_48;
  detail_7 = tex_23;
  mediump vec4 tex_49;
  highp vec2 uv_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_52;
  highp float r_53;
  if ((abs(tmpvar_51.z) > (1e-08 * abs(tmpvar_51.x)))) {
    highp float y_over_x_54;
    y_over_x_54 = (tmpvar_51.x / tmpvar_51.z);
    highp float s_55;
    highp float x_56;
    x_56 = (y_over_x_54 * inversesqrt(((y_over_x_54 * y_over_x_54) + 1.0)));
    s_55 = (sign(x_56) * (1.5708 - (sqrt((1.0 - abs(x_56))) * (1.5708 + (abs(x_56) * (-0.214602 + (abs(x_56) * (0.0865667 + (abs(x_56) * -0.0310296)))))))));
    r_53 = s_55;
    if ((tmpvar_51.z < 0.0)) {
      if ((tmpvar_51.x >= 0.0)) {
        r_53 = (s_55 + 3.14159);
      } else {
        r_53 = (r_53 - 3.14159);
      };
    };
  } else {
    r_53 = (sign(tmpvar_51.x) * 1.5708);
  };
  uv_52.x = (0.5 + (0.159155 * r_53));
  uv_52.y = (0.31831 * (1.5708 - (sign(tmpvar_51.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_51.y))) * (1.5708 + (abs(tmpvar_51.y) * (-0.214602 + (abs(tmpvar_51.y) * (0.0865667 + (abs(tmpvar_51.y) * -0.0310296)))))))))));
  uv_50.x = (uv_52.x * (4.0 * _DetailVertScale));
  uv_50.y = (uv_52.y * (2.0 * _DetailVertScale));
  highp vec2 tmpvar_57;
  tmpvar_57 = dFdx(tmpvar_51.xz);
  highp vec2 tmpvar_58;
  tmpvar_58 = dFdy(tmpvar_51.xz);
  highp vec4 tmpvar_59;
  tmpvar_59.x = (0.159155 * sqrt(dot (tmpvar_57, tmpvar_57)));
  tmpvar_59.y = dFdx(uv_50.y);
  tmpvar_59.z = (0.31831 * sqrt(dot (tmpvar_58, tmpvar_58)));
  tmpvar_59.w = dFdy(uv_50.y);
  highp vec2 tmpvar_60;
  mediump float s_61;
  mediump float nylerp_62;
  mediump float zxlerp_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = abs(tmpvar_51);
  highp float tmpvar_65;
  tmpvar_65 = float((tmpvar_64.z >= tmpvar_64.x));
  zxlerp_63 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = float((mix (tmpvar_64.x, tmpvar_64.z, zxlerp_63) >= tmpvar_64.y));
  nylerp_62 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = mix (tmpvar_51.x, tmpvar_51.z, zxlerp_63);
  s_61 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = sign(mix (-(tmpvar_51.y), s_61, nylerp_62));
  s_61 = tmpvar_68;
  mediump vec3 tmpvar_69;
  tmpvar_69.xz = vec2(1.0, 1.0);
  tmpvar_69.y = -(s_61);
  mediump vec3 tmpvar_70;
  tmpvar_70.xz = vec2(1.0, 1.0);
  tmpvar_70.y = s_61;
  mediump vec3 tmpvar_71;
  tmpvar_71.xy = vec2(1.0, 1.0);
  tmpvar_71.z = -(s_61);
  highp vec3 tmpvar_72;
  tmpvar_72 = mix ((tmpvar_71 * tmpvar_51.yzx), mix ((tmpvar_69 * tmpvar_51.xzy), (tmpvar_70 * tmpvar_51.zxy), vec3(zxlerp_63)), vec3(nylerp_62));
  tmpvar_60 = (((0.5 * tmpvar_72.yz) / abs(tmpvar_72.x)) + 0.5);
  uv_50 = tmpvar_60;
  highp vec2 coord_73;
  coord_73 = (tmpvar_60 * _DetailVertScale);
  lowp vec4 tmpvar_74;
  tmpvar_74 = textureGrad (_steepTex, coord_73, tmpvar_59.xy, tmpvar_59.zw);
  tex_49 = tmpvar_74;
  detail_7 = mix (tex_49, tex_23, vec4(vertLerp_8));
  mediump vec4 tex_75;
  highp vec3 tmpvar_76;
  tmpvar_76 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_77;
  highp float r_78;
  if ((abs(tmpvar_76.z) > (1e-08 * abs(tmpvar_76.x)))) {
    highp float y_over_x_79;
    y_over_x_79 = (tmpvar_76.x / tmpvar_76.z);
    highp float s_80;
    highp float x_81;
    x_81 = (y_over_x_79 * inversesqrt(((y_over_x_79 * y_over_x_79) + 1.0)));
    s_80 = (sign(x_81) * (1.5708 - (sqrt((1.0 - abs(x_81))) * (1.5708 + (abs(x_81) * (-0.214602 + (abs(x_81) * (0.0865667 + (abs(x_81) * -0.0310296)))))))));
    r_78 = s_80;
    if ((tmpvar_76.z < 0.0)) {
      if ((tmpvar_76.x >= 0.0)) {
        r_78 = (s_80 + 3.14159);
      } else {
        r_78 = (r_78 - 3.14159);
      };
    };
  } else {
    r_78 = (sign(tmpvar_76.x) * 1.5708);
  };
  uv_77.x = (0.5 + (0.159155 * r_78));
  uv_77.y = (0.31831 * (1.5708 - (sign(tmpvar_76.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_76.y))) * (1.5708 + (abs(tmpvar_76.y) * (-0.214602 + (abs(tmpvar_76.y) * (0.0865667 + (abs(tmpvar_76.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_82;
  tmpvar_82 = dFdx(tmpvar_76.xz);
  highp vec2 tmpvar_83;
  tmpvar_83 = dFdy(tmpvar_76.xz);
  highp vec4 tmpvar_84;
  tmpvar_84.x = (0.159155 * sqrt(dot (tmpvar_82, tmpvar_82)));
  tmpvar_84.y = dFdx(uv_77.y);
  tmpvar_84.z = (0.31831 * sqrt(dot (tmpvar_83, tmpvar_83)));
  tmpvar_84.w = dFdy(uv_77.y);
  lowp vec4 tmpvar_85;
  tmpvar_85 = textureGrad (_BumpMap, uv_77, tmpvar_84.xy, tmpvar_84.zw);
  tex_75 = tmpvar_85;
  mediump vec2 tmpvar_86;
  tmpvar_86 = tex_75.wy;
  localCoords_6 = tmpvar_86;
  highp vec2 tmpvar_87;
  tmpvar_87 = (localCoords_6 - vec2(0.5, 0.5));
  localCoords_6.y = tmpvar_87.y;
  localCoords_6.x = (tmpvar_87.x * 0.5);
  highp float r_88;
  if ((abs(tmpvar_21.z) > (1e-08 * abs(tmpvar_21.x)))) {
    highp float y_over_x_89;
    y_over_x_89 = (tmpvar_21.x / tmpvar_21.z);
    float s_90;
    highp float x_91;
    x_91 = (y_over_x_89 * inversesqrt(((y_over_x_89 * y_over_x_89) + 1.0)));
    s_90 = (sign(x_91) * (1.5708 - (sqrt((1.0 - abs(x_91))) * (1.5708 + (abs(x_91) * (-0.214602 + (abs(x_91) * (0.0865667 + (abs(x_91) * -0.0310296)))))))));
    r_88 = s_90;
    if ((tmpvar_21.z < 0.0)) {
      if ((tmpvar_21.x >= 0.0)) {
        r_88 = (s_90 + 3.14159);
      } else {
        r_88 = (r_88 - 3.14159);
      };
    };
  } else {
    r_88 = (sign(tmpvar_21.x) * 1.5708);
  };
  uv_5.x = (0.5 + (0.159155 * r_88));
  uv_5.y = (0.31831 * (1.5708 - (sign(tmpvar_21.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_21.y))) * (1.5708 + (abs(tmpvar_21.y) * (-0.214602 + (abs(tmpvar_21.y) * (0.0865667 + (abs(tmpvar_21.y) * -0.0310296)))))))))));
  uv_5.x = (uv_5.x - 0.5);
  highp vec2 tmpvar_92;
  tmpvar_92 = (uv_5 + localCoords_6);
  uv_5 = tmpvar_92;
  highp float tmpvar_93;
  tmpvar_93 = cos((6.28319 * tmpvar_92.x));
  norm_4.z = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = sin((6.28319 * tmpvar_92.x));
  norm_4.x = tmpvar_94;
  highp float tmpvar_95;
  tmpvar_95 = cos((3.14159 * tmpvar_92.y));
  norm_4.y = tmpvar_95;
  norm_4 = -(norm_4);
  highp float tmpvar_96;
  tmpvar_96 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD1.w), 0.0, 1.0);
  detailLevel_3 = tmpvar_96;
  mediump vec4 tmpvar_97;
  tmpvar_97 = mix ((detail_7 - 0.5), vec4(0.0, 0.0, 0.0, 0.0), vec4(detailLevel_3));
  highp vec4 tmpvar_98;
  tmpvar_98 = (xlv_TEXCOORD0 + (0.75 * tmpvar_97));
  color_9 = tmpvar_98;
  highp float tmpvar_99;
  tmpvar_99 = clamp (pow (_PlanetOpacity, 2.0), 0.0, 1.0);
  handoff_2 = tmpvar_99;
  color_9.xyz = (mix (color_9, tex_10, vec4(handoff_2)) * _Color).xyz;
  highp vec3 tmpvar_100;
  tmpvar_100 = _WorldSpaceLightPos0.xyz;
  mediump vec3 lightDir_101;
  lightDir_101 = tmpvar_100;
  mediump vec3 viewDir_102;
  viewDir_102 = xlv_TEXCOORD8;
  mediump vec3 normal_103;
  normal_103 = xlv_TEXCOORD4;
  lightDir_101 = normalize(lightDir_101);
  viewDir_102 = normalize(viewDir_102);
  normal_103 = normalize(normal_103);
  color_9.w = 1.0;
  tmpvar_1 = xlv_TEXCOORD0;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 1 math
"ps_3_0
dcl_texcoord0 v0
mov_pp oC0, v0
"
}
SubProgram "d3d11 " {
"ps_4_0
eefiecedkahegikhcmkojaaekfifmlifjdikcpaaabaaaaaaiiabaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaadaaaaaaaiaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaaaaaaneaaaaaaaiaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdiaaaaaaeaaaaaaaaoaaaaaagcbaaaadpcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegbobaaa
abaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "glesdesktop " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
}
Fallback "VertexLit"
}