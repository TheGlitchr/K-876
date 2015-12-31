// Compiled shader for all platforms, uncompressed size: 30.6KB

Shader "Proland/Atmo/SkyExtinction" {
SubShader { 
 Tags { "QUEUE"="Geometry+1" "IgnoreProjector"="True" }


 // Stats for Vertex shader:
 //       d3d11 : 10 math
 //        d3d9 : 14 math
 // Stats for Fragment shader:
 //       d3d11 : 73 math, 2 branch
 //        d3d9 : 105 math, 2 texture, 1 branch
 Pass {
  Tags { "QUEUE"="Geometry+1" "IgnoreProjector"="True" }
  ZTest False
  ZWrite Off
  Cull Front
  Blend DstColor Zero
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX
uniform mat4 _Globals_CameraToWorld;
uniform mat4 _Globals_ScreenToCamera;
uniform mat4 _Sun_WorldToLocal;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = (_Globals_ScreenToCamera * gl_Vertex).xyz;
  vec3 tmpvar_2;
  tmpvar_2 = (_Globals_CameraToWorld * tmpvar_1).xyz;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Sun_WorldToLocal[0].xyz;
  tmpvar_3[1] = _Sun_WorldToLocal[1].xyz;
  tmpvar_3[2] = _Sun_WorldToLocal[2].xyz;
  vec4 tmpvar_4;
  tmpvar_4.zw = vec2(1.0, 1.0);
  tmpvar_4.xy = gl_Vertex.xy;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_3 * tmpvar_2);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform float Rg;
uniform float Rt;
uniform sampler2D _Sky_Transmittance;
uniform float _viewdirOffset;
uniform float _experimentalAtmoScale;
uniform vec3 _Globals_WorldCameraPos;
uniform vec3 _Globals_Origin;
uniform float _Globals_ApparentDistance;
uniform float _Extinction_Tint;
uniform float extinctionMultiplier;
uniform float extinctionRimFade;
uniform float _rimQuickFixMultiplier;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 tmpvar_1;
  float mu_2;
  float r_3;
  vec3 viewdir_4;
  vec3 extinction_5;
  extinction_5 = vec3(1.0, 1.0, 1.0);
  float tmpvar_6;
  tmpvar_6 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  viewdir_4.yz = tmpvar_7.yz;
  viewdir_4.x = (tmpvar_7.x + _viewdirOffset);
  vec3 tmpvar_8;
  tmpvar_8 = normalize(viewdir_4);
  viewdir_4 = tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_9, tmpvar_9));
  r_3 = tmpvar_10;
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_8);
  mu_2 = (tmpvar_11 / tmpvar_10);
  float tmpvar_12;
  tmpvar_12 = max ((-(tmpvar_11) - sqrt((((tmpvar_11 * tmpvar_11) - (tmpvar_10 * tmpvar_10)) + (tmpvar_6 * tmpvar_6)))), 0.0);
  if ((tmpvar_12 > 0.0)) {
    mu_2 = ((tmpvar_11 + tmpvar_12) / tmpvar_6);
    r_3 = tmpvar_6;
  };
  if ((r_3 > tmpvar_6)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    float y_over_x_13;
    y_over_x_13 = (((mu_2 + 0.15) / 1.15) * 14.1014);
    float x_14;
    x_14 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    vec2 tmpvar_15;
    tmpvar_15.x = ((sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296))))))))) / 1.5);
    tmpvar_15.y = sqrt(((r_3 - Rg) / (tmpvar_6 - Rg)));
    vec4 tmpvar_16;
    tmpvar_16 = texture2DLod (_Sky_Transmittance, tmpvar_15, 0.0);
    float tmpvar_17;
    tmpvar_17 = (((tmpvar_16.x + tmpvar_16.y) + tmpvar_16.z) / 3.0);
    vec3 tmpvar_18;
    tmpvar_18.x = ((_Extinction_Tint * tmpvar_16.x) + ((1.0 - _Extinction_Tint) * tmpvar_17));
    tmpvar_18.y = ((_Extinction_Tint * tmpvar_16.y) + ((1.0 - _Extinction_Tint) * tmpvar_17));
    tmpvar_18.z = ((_Extinction_Tint * tmpvar_16.z) + ((1.0 - _Extinction_Tint) * tmpvar_17));
    extinction_5 = tmpvar_18;
    vec3 p1_19;
    p1_19 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
    float r_20;
    r_20 = (Rg * _rimQuickFixMultiplier);
    float tmpvar_21;
    vec3 tmpvar_22;
    tmpvar_22 = (((_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance)) + tmpvar_8) - p1_19);
    float tmpvar_23;
    tmpvar_23 = dot (tmpvar_22, tmpvar_22);
    float tmpvar_24;
    tmpvar_24 = (2.0 * dot (tmpvar_22, (p1_19 - _Globals_Origin)));
    float tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * tmpvar_24) - ((4.0 * tmpvar_23) * (((dot (_Globals_Origin, _Globals_Origin) + dot (p1_19, p1_19)) - (2.0 * dot (_Globals_Origin, p1_19))) - (r_20 * r_20))));
    if ((tmpvar_25 < 0.0)) {
      tmpvar_21 = -1.0;
    } else {
      tmpvar_21 = ((-(tmpvar_24) - sqrt(tmpvar_25)) / (2.0 * tmpvar_23));
    };
    bool tmpvar_26;
    tmpvar_26 = (tmpvar_21 > 0.0);
    if (!(tmpvar_26)) {
      extinction_5 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_18));
    };
    vec4 tmpvar_27;
    tmpvar_27.w = 1.0;
    tmpvar_27.xyz = (extinctionMultiplier * extinction_5);
    tmpvar_1 = tmpvar_27;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 14 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [_Globals_CameraToWorld]
Matrix 4 [_Globals_ScreenToCamera]
Matrix 8 [_Sun_WorldToLocal]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c12, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mov r1.w, c12.x
dp4 r1.z, v0, c6
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mov o2.xyz, r0
dp3 o3.z, r0, c10
dp3 o3.y, r0, c9
dp3 o3.x, r0, c8
mov o0.xy, v0
mov o0.zw, c12.y
mov o1.xy, v1
"
}
SubProgram "d3d11 " {
// Stats: 10 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 416
Matrix 160 [_Globals_CameraToWorld]
Matrix 224 [_Globals_ScreenToCamera]
Matrix 352 [_Sun_WorldToLocal]
BindCB  "$Globals" 0
"vs_4_0
eefiecedmefkmbdfnnfeenpnjlgncfbhgnngkofpabaaaaaaheadaaaaadaaaaaa
cmaaaaaakaaaaaaaciabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefceeacaaaaeaaaabaajbaaaaaafjaaaaaeegiocaaa
aaaaaaaabjaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadgaaaaaf
dccabaaaaaaaaaaaegbabaaaaaaaaaaadgaaaaaimccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpdgaaaaafdccabaaaabaaaaaaegbabaaa
acaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaa
apaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
baaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaabbaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaaaaaaaaaakaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabhaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaaaaaaaaabgaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaabiaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Sun_WorldToLocal;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = (_Globals_ScreenToCamera * _glesVertex).xyz;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Globals_CameraToWorld * tmpvar_1).xyz;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Sun_WorldToLocal[0].xyz;
  tmpvar_3[1] = _Sun_WorldToLocal[1].xyz;
  tmpvar_3[2] = _Sun_WorldToLocal[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(1.0, 1.0);
  tmpvar_4.xy = _glesVertex.xy;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_3 * tmpvar_2);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform highp float Rg;
uniform highp float Rt;
uniform sampler2D _Sky_Transmittance;
uniform highp float _viewdirOffset;
uniform highp float _experimentalAtmoScale;
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec3 _Globals_Origin;
uniform highp float _Globals_ApparentDistance;
uniform highp float _Extinction_Tint;
uniform highp float extinctionMultiplier;
uniform highp float extinctionRimFade;
uniform highp float _rimQuickFixMultiplier;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp float mu_2;
  highp float r_3;
  highp vec3 viewdir_4;
  highp vec3 extinction_5;
  extinction_5 = vec3(1.0, 1.0, 1.0);
  highp float tmpvar_6;
  tmpvar_6 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  viewdir_4.yz = tmpvar_7.yz;
  viewdir_4.x = (tmpvar_7.x + _viewdirOffset);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(viewdir_4);
  viewdir_4 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_9, tmpvar_9));
  r_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_8);
  mu_2 = (tmpvar_11 / tmpvar_10);
  highp float tmpvar_12;
  tmpvar_12 = max ((-(tmpvar_11) - sqrt((((tmpvar_11 * tmpvar_11) - (tmpvar_10 * tmpvar_10)) + (tmpvar_6 * tmpvar_6)))), 0.0);
  if ((tmpvar_12 > 0.0)) {
    mu_2 = ((tmpvar_11 + tmpvar_12) / tmpvar_6);
    r_3 = tmpvar_6;
  };
  if ((r_3 > tmpvar_6)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp vec3 tmpvar_13;
    highp float y_over_x_14;
    y_over_x_14 = (((mu_2 + 0.15) / 1.15) * 14.1014);
    highp float x_15;
    x_15 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    highp vec2 tmpvar_16;
    tmpvar_16.x = ((sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296))))))))) / 1.5);
    tmpvar_16.y = sqrt(((r_3 - Rg) / (tmpvar_6 - Rg)));
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2DLodEXT (_Sky_Transmittance, tmpvar_16, 0.0);
    tmpvar_13 = tmpvar_17.xyz;
    highp float tmpvar_18;
    tmpvar_18 = (((tmpvar_13.x + tmpvar_13.y) + tmpvar_13.z) / 3.0);
    highp vec3 tmpvar_19;
    tmpvar_19.x = ((_Extinction_Tint * tmpvar_13.x) + ((1.0 - _Extinction_Tint) * tmpvar_18));
    tmpvar_19.y = ((_Extinction_Tint * tmpvar_13.y) + ((1.0 - _Extinction_Tint) * tmpvar_18));
    tmpvar_19.z = ((_Extinction_Tint * tmpvar_13.z) + ((1.0 - _Extinction_Tint) * tmpvar_18));
    extinction_5 = tmpvar_19;
    highp vec3 p1_20;
    p1_20 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
    highp float r_21;
    r_21 = (Rg * _rimQuickFixMultiplier);
    highp float tmpvar_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = (((_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance)) + tmpvar_8) - p1_20);
    highp float tmpvar_24;
    tmpvar_24 = dot (tmpvar_23, tmpvar_23);
    highp float tmpvar_25;
    tmpvar_25 = (2.0 * dot (tmpvar_23, (p1_20 - _Globals_Origin)));
    highp float tmpvar_26;
    tmpvar_26 = ((tmpvar_25 * tmpvar_25) - ((4.0 * tmpvar_24) * (((dot (_Globals_Origin, _Globals_Origin) + dot (p1_20, p1_20)) - (2.0 * dot (_Globals_Origin, p1_20))) - (r_21 * r_21))));
    if ((tmpvar_26 < 0.0)) {
      tmpvar_22 = -1.0;
    } else {
      tmpvar_22 = ((-(tmpvar_25) - sqrt(tmpvar_26)) / (2.0 * tmpvar_24));
    };
    bool tmpvar_27;
    tmpvar_27 = (tmpvar_22 > 0.0);
    if (!(tmpvar_27)) {
      extinction_5 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_19));
    };
    highp vec4 tmpvar_28;
    tmpvar_28.w = 1.0;
    tmpvar_28.xyz = (extinctionMultiplier * extinction_5);
    tmpvar_1 = tmpvar_28;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Sun_WorldToLocal;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = (_Globals_ScreenToCamera * _glesVertex).xyz;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Globals_CameraToWorld * tmpvar_1).xyz;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Sun_WorldToLocal[0].xyz;
  tmpvar_3[1] = _Sun_WorldToLocal[1].xyz;
  tmpvar_3[2] = _Sun_WorldToLocal[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(1.0, 1.0);
  tmpvar_4.xy = _glesVertex.xy;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_3 * tmpvar_2);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform highp float Rg;
uniform highp float Rt;
uniform sampler2D _Sky_Transmittance;
uniform highp float _viewdirOffset;
uniform highp float _experimentalAtmoScale;
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec3 _Globals_Origin;
uniform highp float _Globals_ApparentDistance;
uniform highp float _Extinction_Tint;
uniform highp float extinctionMultiplier;
uniform highp float extinctionRimFade;
uniform highp float _rimQuickFixMultiplier;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp float mu_2;
  highp float r_3;
  highp vec3 viewdir_4;
  highp vec3 extinction_5;
  extinction_5 = vec3(1.0, 1.0, 1.0);
  highp float tmpvar_6;
  tmpvar_6 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  viewdir_4.yz = tmpvar_7.yz;
  viewdir_4.x = (tmpvar_7.x + _viewdirOffset);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(viewdir_4);
  viewdir_4 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_9, tmpvar_9));
  r_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_8);
  mu_2 = (tmpvar_11 / tmpvar_10);
  highp float tmpvar_12;
  tmpvar_12 = max ((-(tmpvar_11) - sqrt((((tmpvar_11 * tmpvar_11) - (tmpvar_10 * tmpvar_10)) + (tmpvar_6 * tmpvar_6)))), 0.0);
  if ((tmpvar_12 > 0.0)) {
    mu_2 = ((tmpvar_11 + tmpvar_12) / tmpvar_6);
    r_3 = tmpvar_6;
  };
  if ((r_3 > tmpvar_6)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp vec3 tmpvar_13;
    highp float y_over_x_14;
    y_over_x_14 = (((mu_2 + 0.15) / 1.15) * 14.1014);
    highp float x_15;
    x_15 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    highp vec2 tmpvar_16;
    tmpvar_16.x = ((sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296))))))))) / 1.5);
    tmpvar_16.y = sqrt(((r_3 - Rg) / (tmpvar_6 - Rg)));
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2DLodEXT (_Sky_Transmittance, tmpvar_16, 0.0);
    tmpvar_13 = tmpvar_17.xyz;
    highp float tmpvar_18;
    tmpvar_18 = (((tmpvar_13.x + tmpvar_13.y) + tmpvar_13.z) / 3.0);
    highp vec3 tmpvar_19;
    tmpvar_19.x = ((_Extinction_Tint * tmpvar_13.x) + ((1.0 - _Extinction_Tint) * tmpvar_18));
    tmpvar_19.y = ((_Extinction_Tint * tmpvar_13.y) + ((1.0 - _Extinction_Tint) * tmpvar_18));
    tmpvar_19.z = ((_Extinction_Tint * tmpvar_13.z) + ((1.0 - _Extinction_Tint) * tmpvar_18));
    extinction_5 = tmpvar_19;
    highp vec3 p1_20;
    p1_20 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
    highp float r_21;
    r_21 = (Rg * _rimQuickFixMultiplier);
    highp float tmpvar_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = (((_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance)) + tmpvar_8) - p1_20);
    highp float tmpvar_24;
    tmpvar_24 = dot (tmpvar_23, tmpvar_23);
    highp float tmpvar_25;
    tmpvar_25 = (2.0 * dot (tmpvar_23, (p1_20 - _Globals_Origin)));
    highp float tmpvar_26;
    tmpvar_26 = ((tmpvar_25 * tmpvar_25) - ((4.0 * tmpvar_24) * (((dot (_Globals_Origin, _Globals_Origin) + dot (p1_20, p1_20)) - (2.0 * dot (_Globals_Origin, p1_20))) - (r_21 * r_21))));
    if ((tmpvar_26 < 0.0)) {
      tmpvar_22 = -1.0;
    } else {
      tmpvar_22 = ((-(tmpvar_25) - sqrt(tmpvar_26)) / (2.0 * tmpvar_24));
    };
    bool tmpvar_27;
    tmpvar_27 = (tmpvar_22 > 0.0);
    if (!(tmpvar_27)) {
      extinction_5 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_19));
    };
    highp vec4 tmpvar_28;
    tmpvar_28.w = 1.0;
    tmpvar_28.xyz = (extinctionMultiplier * extinction_5);
    tmpvar_1 = tmpvar_28;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Sun_WorldToLocal;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = (_Globals_ScreenToCamera * _glesVertex).xyz;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Globals_CameraToWorld * tmpvar_1).xyz;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Sun_WorldToLocal[0].xyz;
  tmpvar_3[1] = _Sun_WorldToLocal[1].xyz;
  tmpvar_3[2] = _Sun_WorldToLocal[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(1.0, 1.0);
  tmpvar_4.xy = _glesVertex.xy;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_3 * tmpvar_2);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp float Rg;
uniform highp float Rt;
uniform sampler2D _Sky_Transmittance;
uniform highp float _viewdirOffset;
uniform highp float _experimentalAtmoScale;
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec3 _Globals_Origin;
uniform highp float _Globals_ApparentDistance;
uniform highp float _Extinction_Tint;
uniform highp float extinctionMultiplier;
uniform highp float extinctionRimFade;
uniform highp float _rimQuickFixMultiplier;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp float mu_2;
  highp float r_3;
  highp vec3 viewdir_4;
  highp vec3 extinction_5;
  extinction_5 = vec3(1.0, 1.0, 1.0);
  highp float tmpvar_6;
  tmpvar_6 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  viewdir_4.yz = tmpvar_7.yz;
  viewdir_4.x = (tmpvar_7.x + _viewdirOffset);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(viewdir_4);
  viewdir_4 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_9, tmpvar_9));
  r_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_8);
  mu_2 = (tmpvar_11 / tmpvar_10);
  highp float tmpvar_12;
  tmpvar_12 = max ((-(tmpvar_11) - sqrt((((tmpvar_11 * tmpvar_11) - (tmpvar_10 * tmpvar_10)) + (tmpvar_6 * tmpvar_6)))), 0.0);
  if ((tmpvar_12 > 0.0)) {
    mu_2 = ((tmpvar_11 + tmpvar_12) / tmpvar_6);
    r_3 = tmpvar_6;
  };
  if ((r_3 > tmpvar_6)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp vec3 tmpvar_13;
    highp float y_over_x_14;
    y_over_x_14 = (((mu_2 + 0.15) / 1.15) * 14.1014);
    highp float x_15;
    x_15 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    highp vec2 tmpvar_16;
    tmpvar_16.x = ((sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296))))))))) / 1.5);
    tmpvar_16.y = sqrt(((r_3 - Rg) / (tmpvar_6 - Rg)));
    lowp vec4 tmpvar_17;
    tmpvar_17 = textureLod (_Sky_Transmittance, tmpvar_16, 0.0);
    tmpvar_13 = tmpvar_17.xyz;
    highp float tmpvar_18;
    tmpvar_18 = (((tmpvar_13.x + tmpvar_13.y) + tmpvar_13.z) / 3.0);
    highp vec3 tmpvar_19;
    tmpvar_19.x = ((_Extinction_Tint * tmpvar_13.x) + ((1.0 - _Extinction_Tint) * tmpvar_18));
    tmpvar_19.y = ((_Extinction_Tint * tmpvar_13.y) + ((1.0 - _Extinction_Tint) * tmpvar_18));
    tmpvar_19.z = ((_Extinction_Tint * tmpvar_13.z) + ((1.0 - _Extinction_Tint) * tmpvar_18));
    extinction_5 = tmpvar_19;
    highp vec3 p1_20;
    p1_20 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
    highp float r_21;
    r_21 = (Rg * _rimQuickFixMultiplier);
    highp float tmpvar_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = (((_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance)) + tmpvar_8) - p1_20);
    highp float tmpvar_24;
    tmpvar_24 = dot (tmpvar_23, tmpvar_23);
    highp float tmpvar_25;
    tmpvar_25 = (2.0 * dot (tmpvar_23, (p1_20 - _Globals_Origin)));
    highp float tmpvar_26;
    tmpvar_26 = ((tmpvar_25 * tmpvar_25) - ((4.0 * tmpvar_24) * (((dot (_Globals_Origin, _Globals_Origin) + dot (p1_20, p1_20)) - (2.0 * dot (_Globals_Origin, p1_20))) - (r_21 * r_21))));
    if ((tmpvar_26 < 0.0)) {
      tmpvar_22 = -1.0;
    } else {
      tmpvar_22 = ((-(tmpvar_25) - sqrt(tmpvar_26)) / (2.0 * tmpvar_24));
    };
    bool tmpvar_27;
    tmpvar_27 = (tmpvar_22 > 0.0);
    if (!(tmpvar_27)) {
      extinction_5 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_19));
    };
    highp vec4 tmpvar_28;
    tmpvar_28.w = 1.0;
    tmpvar_28.xyz = (extinctionMultiplier * extinction_5);
    tmpvar_1 = tmpvar_28;
  };
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
// Stats: 105 math, 2 textures, 1 branches
Float 0 [Rg]
Float 1 [Rt]
Float 2 [_viewdirOffset]
Float 3 [_experimentalAtmoScale]
Vector 4 [_Globals_WorldCameraPos]
Vector 5 [_Globals_Origin]
Float 6 [_Globals_ApparentDistance]
Float 7 [_Extinction_Tint]
Float 8 [extinctionMultiplier]
Float 9 [extinctionRimFade]
Float 10 [_rimQuickFixMultiplier]
SetTexture 0 [_Sky_Transmittance] 2D 0
"ps_3_0
dcl_2d s0
def c11, 1000000015047466200000000000000.00000000, 0.00000000, 1.00000000, 2.00000000
def c12, 4.00000000, -1.00000000, 0.15000001, 12.26193905
def c13, -0.01348047, 0.05747731, -0.12123910, 0.19563590
def c14, -0.33299461, 0.99999559, 1.57079601, 0.66666669
def c15, 0.33333334, 0, 0, 0
dcl_texcoord1 v0.xyz
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul r0.xyz, r0.x, v0
add r0.x, r0, c2
dp3 r2.w, r0, r0
rsq r2.w, r2.w
mov r2.xyz, c5
mul r2.xyz, c6.x, -r2
add r2.xyz, r2, c4
mul r0.xyz, r2.w, r0
dp3 r2.w, r2, r2
dp3 r2.x, r0, r2
rsq r2.y, r2.w
rcp r2.z, r2.y
mul r3.x, r2.z, r2.z
mov r2.w, c1.x
add r2.w, -c0.x, r2
mul r2.w, r2, c3.x
add r2.w, r2, c0.x
mad r3.x, r2, r2, -r3
mad r3.x, r2.w, r2.w, r3
rsq r3.y, r3.x
rcp r3.y, r3.y
cmp r3.x, r3, r3.y, c11
add r3.x, -r2, -r3
max r3.y, r3.x, c11
add r3.z, r3.y, r2.x
cmp r3.x, -r3.y, r2.z, r2.w
add r2.z, -r2.w, r3.x
rcp r3.w, r2.w
mul r2.x, r2.y, r2
mul r3.z, r3, r3.w
cmp r3.y, -r3, r2.x, r3.z
cmp_pp r2.x, -r2.z, c11.z, c11.y
cmp oC0, -r2.z, r1, c11.z
if_gt r2.x, c11.y
mov r1.xyz, c5
mul r1.xyz, c6.x, -r1
add r1.xyz, r1, c4
add r0.xyz, r1, r0
add r0.xyz, r0, -r1
add r2.xyz, r1, -c5
dp3 r1.w, r0, r2
dp3 r0.x, r0, r0
dp3 r0.z, r1, r1
dp3 r0.y, c5, c5
add r0.z, r0.y, r0
dp3 r0.y, r1, c5
mad r0.z, -r0.y, c11.w, r0
mov r0.y, c0.x
mul r0.y, c10.x, r0
mad r0.z, -r0.y, r0.y, r0
add r1.x, r3.y, c12.z
mul r0.y, r1.x, c12.w
mul r1.x, r0, r0.z
abs r0.z, r0.y
max r1.y, r0.z, c11.z
mul r0.x, r0, c11.w
mul r1.w, r1, c11
mul r1.x, r1, c12
mad r2.x, r1.w, r1.w, -r1
min r1.x, r0.z, c11.z
rcp r1.y, r1.y
mul r1.y, r1.x, r1
mul r1.z, r1.y, r1.y
mad r2.y, r1.z, c13.x, c13
mad r2.y, r2, r1.z, c13.z
cmp_pp r1.x, r2, c11.z, c11.y
cmp r0.w, r2.x, r0, c12.y
rsq r2.x, r2.x
rcp r2.x, r2.x
add r1.w, -r1, -r2.x
mad r2.y, r2, r1.z, c13.w
mad r2.x, r2.y, r1.z, c14
mad r1.z, r2.x, r1, c14.y
mul r1.z, r1, r1.y
rcp r0.x, r0.x
mul r1.y, r1.w, r0.x
cmp r0.w, -r1.x, r0, r1.y
add r0.x, r0.z, c12.y
add r1.w, -r1.z, c14.z
cmp r0.x, -r0, r1.z, r1.w
cmp r0.x, r0.y, r0, -r0
add r0.z, r2.w, -c0.x
cmp r0.w, -r0, c11.y, c11.z
rcp r0.z, r0.z
add r0.y, r3.x, -c0.x
mul r0.y, r0, r0.z
rsq r0.y, r0.y
mul r0.x, r0, c14.w
mov r0.z, c11.y
rcp r0.y, r0.y
texldl r0.xyz, r0.xyzz, s0
add r1.x, r0, r0.y
add r1.y, r0.z, r1.x
mov r1.x, c7
add r1.x, c11.z, -r1
mul r1.y, r1, c15.x
mul r1.y, r1.x, r1
mov r1.x, c9
mad r0.xyz, r0, c7.x, r1.y
add r1.x, c11.z, -r1
mad r1.xyz, r1.x, r0, c9.x
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, r1, r0
mul oC0.xyz, r0, c8.x
mov oC0.w, c11.z
endif
"
}
SubProgram "d3d11 " {
// Stats: 73 math, 2 branches
SetTexture 0 [_Sky_Transmittance] 2D 0
ConstBuffer "$Globals" 416
Float 24 [Rg]
Float 28 [Rt]
Float 132 [_viewdirOffset]
Float 136 [_experimentalAtmoScale]
Vector 288 [_Globals_WorldCameraPos] 3
Vector 304 [_Globals_Origin] 3
Float 316 [_Globals_ApparentDistance]
Float 320 [_Extinction_Tint]
Float 324 [extinctionMultiplier]
Float 328 [extinctionRimFade]
Float 332 [_rimQuickFixMultiplier]
BindCB  "$Globals" 0
"ps_4_0
eefiecedclcilllmemkofihmkngnkhffljmobihkabaaaaaafaalaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgaakaaaaeaaaaaaajiacaaaafjaaaaaeegiocaaa
aaaaaaaabfaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
afaaaaaaaaaaaaakbcaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaabaaaaaa
dkiacaaaaaaaaaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaiaaaaaadcaaaaalbcaabaaaabaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahmcaabaaaacaaaaaaagaabaaaaaaaaaaafgbjbaaa
acaaaaaadcaaaaakbcaabaaaacaaaaaaakbabaaaacaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaabaaaaaahbcaabaaaaaaaaaaaigadbaaaacaaaaaa
igadbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
ncaabaaaaaaaaaaaagaabaaaaaaaaaaaagaobaaaacaaaaaadcaaaaanhcaabaaa
acaaaaaaegiccaiaebaaaaaaaaaaaaaabdaaaaaapgipcaaaaaaaaaaabdaaaaaa
egiccaaaaaaaaaaabcaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaafbcaabaaaadaaaaaackaabaaaabaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaacaaaaaaigadbaaaaaaaaaaaaoaaaaahccaabaaa
adaaaaaadkaabaaaabaaaaaaakaabaaaadaaaaaadcaaaaakicaabaaaacaaaaaa
dkaabaaaabaaaaaadkaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaadcaaaaaj
icaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaa
elaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaajicaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaadkaabaiaebaaaaaaacaaaaaadeaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaaadbaaaaahecaabaaaadaaaaaa
abeaaaaaaaaaaaaadkaabaaaacaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaacaaaaaaaoaaaaahccaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaabaaaaaadhaaaaajkcaabaaaabaaaaaakgakbaaaadaaaaaaagaebaaa
abaaaaaaagaebaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaabpaaaeadakaabaaaabaaaaaadgaaaaaipccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaabbfaaaaabaaaaaaaj
bcaabaaaabaaaaaabkaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaabaaaaaa
aoaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaaaaaaaaaelaaaaaf
ccaabaaaabaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaadkaabaaa
abaaaaaaabeaaaaajkjjbjdodiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaajfdbeeebddaaaaaiicaabaaaabaaaaaabkaabaiaibaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaaiicaabaaaacaaaaaabkaabaiaibaaaaaaaaaaaaaa
abeaaaaaaaaaiadpaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaabaaaaaa
dkaabaaaabaaaaaadcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaadaaaaaadkaabaaaacaaaaaa
akaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaadaaaaaadkaabaaa
acaaaaaaakaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaacaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaa
adaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaadbaaaaaiccaabaaaadaaaaaa
abeaaaaaaaaaiadpbkaabaiaibaaaaaaaaaaaaaadcaaaaajbcaabaaaadaaaaaa
akaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahbcaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaddaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadhaaaaakccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaa
adaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
aaaaaaahccaabaaaaaaaaaaackaabaaaadaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaklkkkkdoaaaaaaamdcaabaaa
abaaaaaaigiacaiaebaaaaaaaaaaaaaabeaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaakhcaabaaaadaaaaaaagiacaaaaaaaaaaabeaaaaaaegacbaaa
adaaaaaafgafbaaaaaaaaaaadiaaaaajccaabaaaaaaaaaaackiacaaaaaaaaaaa
abaaaaaadkiacaaaaaaaaaaabeaaaaaabaaaaaahbcaabaaaabaaaaaaigadbaaa
aaaaaaaaigadbaaaaaaaaaaaaaaaaaajhcaabaaaaeaaaaaaegacbaaaacaaaaaa
egiccaiaebaaaaaaaaaaaaaabdaaaaaabaaaaaahbcaabaaaaaaaaaaaigadbaaa
aaaaaaaaegacbaaaaeaaaaaaaaaaaaahecaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaaaaaaaaabdaaaaaa
egiccaaaaaaaaaaabdaaaaaaaaaaaaahicaabaaaaaaaaaaackaabaaaabaaaaaa
dkaabaaaaaaaaaaabaaaaaaiecaabaaaabaaaaaaegiccaaaaaaaaaaabdaaaaaa
egacbaaaacaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaaaeadkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaabaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiaeadcaaaaakccaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabnaaaaahecaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaaeabkaabaiaebaaaaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaaaoaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabnaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaappppppppdcaaaaakocaabaaaaaaaaaaafgafbaaaabaaaaaa
agajbaaaadaaaaaakgikcaaaaaaaaaaabeaaaaaadhaaaaajhcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaaihccabaaa
aaaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaabeaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
}