// Compiled shader for all platforms, uncompressed size: 60.9KB

Shader "Proland/Atmo/Sky" {
SubShader { 
 Tags { "QUEUE"="Geometry+1" "IgnoreProjector"="True" }


 // Stats for Vertex shader:
 //       d3d11 : 10 math
 //        d3d9 : 14 math
 // Stats for Fragment shader:
 //       d3d11 : 189 math, 1 texture
 //        d3d9 : 281 math, 11 texture
 Pass {
  Tags { "QUEUE"="Geometry+1" "IgnoreProjector"="True" }
  ZTest False
  ZWrite Off
  Cull Front
  Blend One One
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
uniform float _Exposure;
uniform float Rg;
uniform float Rt;
uniform vec3 betaR;
uniform float mieG;
uniform float RES_R;
uniform float RES_MU;
uniform float RES_MU_S;
uniform float RES_NU;
uniform float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Inscatter;
uniform float _viewdirOffset;
uniform float _experimentalAtmoScale;
uniform float _sunglareScale;
uniform float _Alpha_Global;
uniform vec3 _Globals_WorldCameraPos;
uniform vec3 _Globals_Origin;
uniform float _Globals_ApparentDistance;
uniform float _RimExposure;
uniform float _rimQuickFixMultiplier;
uniform sampler2D _Sun_Glare;
uniform vec3 _Sun_WorldSunDir;
float xlat_mutable_Exposure;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_Exposure = _Exposure;
  vec3 sunColor_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  vec3 p1_3;
  p1_3 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  float r_4;
  r_4 = (Rg * _rimQuickFixMultiplier);
  float tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = (((_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance)) + tmpvar_2) - p1_3);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, tmpvar_6);
  float tmpvar_8;
  tmpvar_8 = (2.0 * dot (tmpvar_6, (p1_3 - _Globals_Origin)));
  float tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_8) - ((4.0 * tmpvar_7) * (((dot (_Globals_Origin, _Globals_Origin) + dot (p1_3, p1_3)) - (2.0 * dot (_Globals_Origin, p1_3))) - (r_4 * r_4))));
  if ((tmpvar_9 < 0.0)) {
    tmpvar_5 = -1.0;
  } else {
    tmpvar_5 = ((-(tmpvar_8) - sqrt(tmpvar_9)) / (2.0 * tmpvar_7));
  };
  bool tmpvar_10;
  tmpvar_10 = (tmpvar_5 > 0.0);
  if (!(tmpvar_10)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  vec3 tmpvar_11;
  if ((xlv_TEXCOORD2.z > 0.0)) {
    tmpvar_11 = texture2D (_Sun_Glare, (vec2(0.5, 0.5) + ((xlv_TEXCOORD2.xy * 4.0) / _sunglareScale))).xyz;
  } else {
    tmpvar_11 = vec3(0.0, 0.0, 0.0);
  };
  sunColor_1 = (pow (max (vec3(0.0, 0.0, 0.0), tmpvar_11), vec3(2.2, 2.2, 2.2)) * _Sun_Intensity);
  vec3 camera_12;
  camera_12 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  vec3 viewdir_13;
  viewdir_13.yz = tmpvar_2.yz;
  vec3 extinction_14;
  float mu_15;
  float rMu_16;
  float r_17;
  vec3 result_18;
  extinction_14 = vec3(1.0, 1.0, 1.0);
  result_18 = vec3(0.0, 0.0, 0.0);
  float tmpvar_19;
  tmpvar_19 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_13.x = (tmpvar_2.x + _viewdirOffset);
  vec3 tmpvar_20;
  tmpvar_20 = normalize(viewdir_13);
  viewdir_13 = tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = sqrt(dot (camera_12, camera_12));
  r_17 = tmpvar_21;
  float tmpvar_22;
  tmpvar_22 = dot (camera_12, tmpvar_20);
  rMu_16 = tmpvar_22;
  mu_15 = (tmpvar_22 / tmpvar_21);
  float tmpvar_23;
  tmpvar_23 = max ((-(tmpvar_22) - sqrt((((tmpvar_22 * tmpvar_22) - (tmpvar_21 * tmpvar_21)) + (tmpvar_19 * tmpvar_19)))), 0.0);
  if ((tmpvar_23 > 0.0)) {
    camera_12 = (camera_12 + (tmpvar_23 * tmpvar_20));
    float tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_23);
    rMu_16 = tmpvar_24;
    mu_15 = (tmpvar_24 / tmpvar_19);
    r_17 = tmpvar_19;
  };
  float tmpvar_25;
  tmpvar_25 = dot (tmpvar_20, _Sun_WorldSunDir);
  float tmpvar_26;
  tmpvar_26 = (dot (camera_12, _Sun_WorldSunDir) / r_17);
  vec4 tmpvar_27;
  float uMu_28;
  float uR_29;
  float tmpvar_30;
  tmpvar_30 = sqrt(((tmpvar_19 * tmpvar_19) - (Rg * Rg)));
  float tmpvar_31;
  tmpvar_31 = sqrt(((r_17 * r_17) - (Rg * Rg)));
  float tmpvar_32;
  tmpvar_32 = (r_17 * (rMu_16 / r_17));
  float tmpvar_33;
  tmpvar_33 = (((tmpvar_32 * tmpvar_32) - (r_17 * r_17)) + (Rg * Rg));
  vec4 tmpvar_34;
  if (((tmpvar_32 < 0.0) && (tmpvar_33 > 0.0))) {
    vec4 tmpvar_35;
    tmpvar_35.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_35.w = (0.5 - (0.5 / RES_MU));
    tmpvar_34 = tmpvar_35;
  } else {
    vec4 tmpvar_36;
    tmpvar_36.x = -1.0;
    tmpvar_36.y = (tmpvar_30 * tmpvar_30);
    tmpvar_36.z = tmpvar_30;
    tmpvar_36.w = (0.5 + (0.5 / RES_MU));
    tmpvar_34 = tmpvar_36;
  };
  uR_29 = ((0.5 / RES_R) + ((tmpvar_31 / tmpvar_30) * (1.0 - (1.0/(RES_R)))));
  uMu_28 = (tmpvar_34.w + ((((tmpvar_32 * tmpvar_34.x) + sqrt((tmpvar_33 + tmpvar_34.y))) / (tmpvar_31 + tmpvar_34.z)) * (0.5 - (1.0/(RES_MU)))));
  float y_over_x_37;
  y_over_x_37 = (max (tmpvar_26, -0.1975) * 5.34962);
  float x_38;
  x_38 = (y_over_x_37 * inversesqrt(((y_over_x_37 * y_over_x_37) + 1.0)));
  float tmpvar_39;
  tmpvar_39 = ((0.5 / RES_MU_S) + (((((sign(x_38) * (1.5708 - (sqrt((1.0 - abs(x_38))) * (1.5708 + (abs(x_38) * (-0.214602 + (abs(x_38) * (0.0865667 + (abs(x_38) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  float tmpvar_40;
  tmpvar_40 = (((tmpvar_25 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_41;
  tmpvar_41 = floor(tmpvar_40);
  float tmpvar_42;
  tmpvar_42 = (tmpvar_40 - tmpvar_41);
  float tmpvar_43;
  tmpvar_43 = (floor(((uR_29 * RES_R) - 1.0)) / RES_R);
  float tmpvar_44;
  tmpvar_44 = (floor((uR_29 * RES_R)) / RES_R);
  float tmpvar_45;
  tmpvar_45 = fract((uR_29 * RES_R));
  vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.x = ((tmpvar_41 + tmpvar_39) / RES_NU);
  tmpvar_46.y = ((uMu_28 / RES_R) + tmpvar_43);
  vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 0.0);
  tmpvar_47.x = (((tmpvar_41 + tmpvar_39) + 1.0) / RES_NU);
  tmpvar_47.y = ((uMu_28 / RES_R) + tmpvar_43);
  vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.x = ((tmpvar_41 + tmpvar_39) / RES_NU);
  tmpvar_48.y = ((uMu_28 / RES_R) + tmpvar_44);
  vec4 tmpvar_49;
  tmpvar_49.zw = vec2(0.0, 0.0);
  tmpvar_49.x = (((tmpvar_41 + tmpvar_39) + 1.0) / RES_NU);
  tmpvar_49.y = ((uMu_28 / RES_R) + tmpvar_44);
  tmpvar_27 = ((((texture2DLod (_Sky_Inscatter, tmpvar_46.xy, 0.0) * (1.0 - tmpvar_42)) + (texture2DLod (_Sky_Inscatter, tmpvar_47.xy, 0.0) * tmpvar_42)) * (1.0 - tmpvar_45)) + (((texture2DLod (_Sky_Inscatter, tmpvar_48.xy, 0.0) * (1.0 - tmpvar_42)) + (texture2DLod (_Sky_Inscatter, tmpvar_49.xy, 0.0) * tmpvar_42)) * tmpvar_45));
  float y_over_x_50;
  y_over_x_50 = (((mu_15 + 0.15) / 1.15) * 14.1014);
  float x_51;
  x_51 = (y_over_x_50 * inversesqrt(((y_over_x_50 * y_over_x_50) + 1.0)));
  vec2 tmpvar_52;
  tmpvar_52.x = ((sign(x_51) * (1.5708 - (sqrt((1.0 - abs(x_51))) * (1.5708 + (abs(x_51) * (-0.214602 + (abs(x_51) * (0.0865667 + (abs(x_51) * -0.0310296))))))))) / 1.5);
  tmpvar_52.y = sqrt(((r_17 - Rg) / (tmpvar_19 - Rg)));
  extinction_14 = texture2DLod (_Sky_Transmittance, tmpvar_52, 0.0).xyz;
  if ((r_17 <= tmpvar_19)) {
    result_18 = ((tmpvar_27.xyz * (0.0596831 * (1.0 + (tmpvar_25 * tmpvar_25)))) + ((((tmpvar_27.xyz * tmpvar_27.w) / max (tmpvar_27.x, 0.0001)) * (betaR.x / betaR)) * ((((0.119366 * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_25)), -1.5)) * (1.0 + (tmpvar_25 * tmpvar_25))) / (2.0 + (mieG * mieG)))));
  } else {
    result_18 = vec3(0.0, 0.0, 0.0);
    extinction_14 = vec3(1.0, 1.0, 1.0);
  };
  vec3 L_53;
  vec3 tmpvar_54;
  tmpvar_54 = (((sunColor_1 * extinction_14) + (result_18 * _Sun_Intensity)) * xlat_mutable_Exposure);
  L_53 = tmpvar_54;
  float tmpvar_55;
  if ((tmpvar_54.x < 1.413)) {
    tmpvar_55 = pow ((tmpvar_54.x * 0.38317), 0.454545);
  } else {
    tmpvar_55 = (1.0 - exp(-(tmpvar_54.x)));
  };
  L_53.x = tmpvar_55;
  float tmpvar_56;
  if ((tmpvar_54.y < 1.413)) {
    tmpvar_56 = pow ((tmpvar_54.y * 0.38317), 0.454545);
  } else {
    tmpvar_56 = (1.0 - exp(-(tmpvar_54.y)));
  };
  L_53.y = tmpvar_56;
  float tmpvar_57;
  if ((tmpvar_54.z < 1.413)) {
    tmpvar_57 = pow ((tmpvar_54.z * 0.38317), 0.454545);
  } else {
    tmpvar_57 = (1.0 - exp(-(tmpvar_54.z)));
  };
  L_53.z = tmpvar_57;
  vec4 tmpvar_58;
  tmpvar_58.w = 1.0;
  tmpvar_58.xyz = (_Alpha_Global * L_53);
  gl_FragData[0] = tmpvar_58;
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
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Inscatter;
uniform highp float _viewdirOffset;
uniform highp float _experimentalAtmoScale;
uniform highp float _sunglareScale;
uniform highp float _Alpha_Global;
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec3 _Globals_Origin;
uniform highp float _Globals_ApparentDistance;
uniform highp float _RimExposure;
uniform highp float _rimQuickFixMultiplier;
uniform sampler2D _Sun_Glare;
uniform highp vec3 _Sun_WorldSunDir;
highp float xlat_mutable_Exposure;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_Exposure = _Exposure;
  highp vec3 sunColor_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  highp vec3 p1_3;
  p1_3 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp float r_4;
  r_4 = (Rg * _rimQuickFixMultiplier);
  highp float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (((_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance)) + tmpvar_2) - p1_3);
  highp float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (2.0 * dot (tmpvar_6, (p1_3 - _Globals_Origin)));
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_8) - ((4.0 * tmpvar_7) * (((dot (_Globals_Origin, _Globals_Origin) + dot (p1_3, p1_3)) - (2.0 * dot (_Globals_Origin, p1_3))) - (r_4 * r_4))));
  if ((tmpvar_9 < 0.0)) {
    tmpvar_5 = -1.0;
  } else {
    tmpvar_5 = ((-(tmpvar_8) - sqrt(tmpvar_9)) / (2.0 * tmpvar_7));
  };
  bool tmpvar_10;
  tmpvar_10 = (tmpvar_5 > 0.0);
  if (!(tmpvar_10)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  highp vec3 data_11;
  lowp vec3 tmpvar_12;
  if ((xlv_TEXCOORD2.z > 0.0)) {
    highp vec2 P_13;
    P_13 = (vec2(0.5, 0.5) + ((xlv_TEXCOORD2.xy * 4.0) / _sunglareScale));
    tmpvar_12 = texture2D (_Sun_Glare, P_13).xyz;
  } else {
    tmpvar_12 = vec3(0.0, 0.0, 0.0);
  };
  data_11 = tmpvar_12;
  sunColor_1 = (pow (max (vec3(0.0, 0.0, 0.0), data_11), vec3(2.2, 2.2, 2.2)) * _Sun_Intensity);
  highp vec3 camera_14;
  camera_14 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp vec3 viewdir_15;
  viewdir_15.yz = tmpvar_2.yz;
  highp vec3 extinction_16;
  highp float mu_17;
  highp float rMu_18;
  highp float r_19;
  highp vec3 result_20;
  extinction_16 = vec3(1.0, 1.0, 1.0);
  result_20 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_21;
  tmpvar_21 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_15.x = (tmpvar_2.x + _viewdirOffset);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(viewdir_15);
  viewdir_15 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(dot (camera_14, camera_14));
  r_19 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (camera_14, tmpvar_22);
  rMu_18 = tmpvar_24;
  mu_17 = (tmpvar_24 / tmpvar_23);
  highp float tmpvar_25;
  tmpvar_25 = max ((-(tmpvar_24) - sqrt((((tmpvar_24 * tmpvar_24) - (tmpvar_23 * tmpvar_23)) + (tmpvar_21 * tmpvar_21)))), 0.0);
  if ((tmpvar_25 > 0.0)) {
    camera_14 = (camera_14 + (tmpvar_25 * tmpvar_22));
    highp float tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_25);
    rMu_18 = tmpvar_26;
    mu_17 = (tmpvar_26 / tmpvar_21);
    r_19 = tmpvar_21;
  };
  highp float tmpvar_27;
  tmpvar_27 = dot (tmpvar_22, _Sun_WorldSunDir);
  highp float tmpvar_28;
  tmpvar_28 = (dot (camera_14, _Sun_WorldSunDir) / r_19);
  highp vec4 tmpvar_29;
  highp float uMu_30;
  highp float uR_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(((tmpvar_21 * tmpvar_21) - (Rg * Rg)));
  highp float tmpvar_33;
  tmpvar_33 = sqrt(((r_19 * r_19) - (Rg * Rg)));
  highp float tmpvar_34;
  tmpvar_34 = (r_19 * (rMu_18 / r_19));
  highp float tmpvar_35;
  tmpvar_35 = (((tmpvar_34 * tmpvar_34) - (r_19 * r_19)) + (Rg * Rg));
  highp vec4 tmpvar_36;
  if (((tmpvar_34 < 0.0) && (tmpvar_35 > 0.0))) {
    highp vec4 tmpvar_37;
    tmpvar_37.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_37.w = (0.5 - (0.5 / RES_MU));
    tmpvar_36 = tmpvar_37;
  } else {
    highp vec4 tmpvar_38;
    tmpvar_38.x = -1.0;
    tmpvar_38.y = (tmpvar_32 * tmpvar_32);
    tmpvar_38.z = tmpvar_32;
    tmpvar_38.w = (0.5 + (0.5 / RES_MU));
    tmpvar_36 = tmpvar_38;
  };
  uR_31 = ((0.5 / RES_R) + ((tmpvar_33 / tmpvar_32) * (1.0 - (1.0/(RES_R)))));
  uMu_30 = (tmpvar_36.w + ((((tmpvar_34 * tmpvar_36.x) + sqrt((tmpvar_35 + tmpvar_36.y))) / (tmpvar_33 + tmpvar_36.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_39;
  y_over_x_39 = (max (tmpvar_28, -0.1975) * 5.34962);
  highp float x_40;
  x_40 = (y_over_x_39 * inversesqrt(((y_over_x_39 * y_over_x_39) + 1.0)));
  highp float tmpvar_41;
  tmpvar_41 = ((0.5 / RES_MU_S) + (((((sign(x_40) * (1.5708 - (sqrt((1.0 - abs(x_40))) * (1.5708 + (abs(x_40) * (-0.214602 + (abs(x_40) * (0.0865667 + (abs(x_40) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_42;
  tmpvar_42 = (((tmpvar_27 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_43;
  tmpvar_43 = floor(tmpvar_42);
  highp float tmpvar_44;
  tmpvar_44 = (tmpvar_42 - tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (floor(((uR_31 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_46;
  tmpvar_46 = (floor((uR_31 * RES_R)) / RES_R);
  highp float tmpvar_47;
  tmpvar_47 = fract((uR_31 * RES_R));
  highp vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.x = ((tmpvar_43 + tmpvar_41) / RES_NU);
  tmpvar_48.y = ((uMu_30 / RES_R) + tmpvar_45);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2DLodEXT (_Sky_Inscatter, tmpvar_48.xy, 0.0);
  highp vec4 tmpvar_50;
  tmpvar_50.zw = vec2(0.0, 0.0);
  tmpvar_50.x = (((tmpvar_43 + tmpvar_41) + 1.0) / RES_NU);
  tmpvar_50.y = ((uMu_30 / RES_R) + tmpvar_45);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLodEXT (_Sky_Inscatter, tmpvar_50.xy, 0.0);
  highp vec4 tmpvar_52;
  tmpvar_52.zw = vec2(0.0, 0.0);
  tmpvar_52.x = ((tmpvar_43 + tmpvar_41) / RES_NU);
  tmpvar_52.y = ((uMu_30 / RES_R) + tmpvar_46);
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2DLodEXT (_Sky_Inscatter, tmpvar_52.xy, 0.0);
  highp vec4 tmpvar_54;
  tmpvar_54.zw = vec2(0.0, 0.0);
  tmpvar_54.x = (((tmpvar_43 + tmpvar_41) + 1.0) / RES_NU);
  tmpvar_54.y = ((uMu_30 / RES_R) + tmpvar_46);
  lowp vec4 tmpvar_55;
  tmpvar_55 = texture2DLodEXT (_Sky_Inscatter, tmpvar_54.xy, 0.0);
  tmpvar_29 = ((((tmpvar_49 * (1.0 - tmpvar_44)) + (tmpvar_51 * tmpvar_44)) * (1.0 - tmpvar_47)) + (((tmpvar_53 * (1.0 - tmpvar_44)) + (tmpvar_55 * tmpvar_44)) * tmpvar_47));
  highp vec3 tmpvar_56;
  highp float y_over_x_57;
  y_over_x_57 = (((mu_17 + 0.15) / 1.15) * 14.1014);
  highp float x_58;
  x_58 = (y_over_x_57 * inversesqrt(((y_over_x_57 * y_over_x_57) + 1.0)));
  highp vec2 tmpvar_59;
  tmpvar_59.x = ((sign(x_58) * (1.5708 - (sqrt((1.0 - abs(x_58))) * (1.5708 + (abs(x_58) * (-0.214602 + (abs(x_58) * (0.0865667 + (abs(x_58) * -0.0310296))))))))) / 1.5);
  tmpvar_59.y = sqrt(((r_19 - Rg) / (tmpvar_21 - Rg)));
  lowp vec4 tmpvar_60;
  tmpvar_60 = texture2DLodEXT (_Sky_Transmittance, tmpvar_59, 0.0);
  tmpvar_56 = tmpvar_60.xyz;
  extinction_16 = tmpvar_56;
  if ((r_19 <= tmpvar_21)) {
    result_20 = ((tmpvar_29.xyz * (0.0596831 * (1.0 + (tmpvar_27 * tmpvar_27)))) + ((((tmpvar_29.xyz * tmpvar_29.w) / max (tmpvar_29.x, 0.0001)) * (betaR.x / betaR)) * ((((0.119366 * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_27)), -1.5)) * (1.0 + (tmpvar_27 * tmpvar_27))) / (2.0 + (mieG * mieG)))));
  } else {
    result_20 = vec3(0.0, 0.0, 0.0);
    extinction_16 = vec3(1.0, 1.0, 1.0);
  };
  highp vec3 L_61;
  highp vec3 tmpvar_62;
  tmpvar_62 = (((sunColor_1 * extinction_16) + (result_20 * _Sun_Intensity)) * xlat_mutable_Exposure);
  L_61 = tmpvar_62;
  highp float tmpvar_63;
  if ((tmpvar_62.x < 1.413)) {
    tmpvar_63 = pow ((tmpvar_62.x * 0.38317), 0.454545);
  } else {
    tmpvar_63 = (1.0 - exp(-(tmpvar_62.x)));
  };
  L_61.x = tmpvar_63;
  highp float tmpvar_64;
  if ((tmpvar_62.y < 1.413)) {
    tmpvar_64 = pow ((tmpvar_62.y * 0.38317), 0.454545);
  } else {
    tmpvar_64 = (1.0 - exp(-(tmpvar_62.y)));
  };
  L_61.y = tmpvar_64;
  highp float tmpvar_65;
  if ((tmpvar_62.z < 1.413)) {
    tmpvar_65 = pow ((tmpvar_62.z * 0.38317), 0.454545);
  } else {
    tmpvar_65 = (1.0 - exp(-(tmpvar_62.z)));
  };
  L_61.z = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66.w = 1.0;
  tmpvar_66.xyz = (_Alpha_Global * L_61);
  gl_FragData[0] = tmpvar_66;
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
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Inscatter;
uniform highp float _viewdirOffset;
uniform highp float _experimentalAtmoScale;
uniform highp float _sunglareScale;
uniform highp float _Alpha_Global;
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec3 _Globals_Origin;
uniform highp float _Globals_ApparentDistance;
uniform highp float _RimExposure;
uniform highp float _rimQuickFixMultiplier;
uniform sampler2D _Sun_Glare;
uniform highp vec3 _Sun_WorldSunDir;
highp float xlat_mutable_Exposure;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_Exposure = _Exposure;
  highp vec3 sunColor_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  highp vec3 p1_3;
  p1_3 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp float r_4;
  r_4 = (Rg * _rimQuickFixMultiplier);
  highp float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (((_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance)) + tmpvar_2) - p1_3);
  highp float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (2.0 * dot (tmpvar_6, (p1_3 - _Globals_Origin)));
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_8) - ((4.0 * tmpvar_7) * (((dot (_Globals_Origin, _Globals_Origin) + dot (p1_3, p1_3)) - (2.0 * dot (_Globals_Origin, p1_3))) - (r_4 * r_4))));
  if ((tmpvar_9 < 0.0)) {
    tmpvar_5 = -1.0;
  } else {
    tmpvar_5 = ((-(tmpvar_8) - sqrt(tmpvar_9)) / (2.0 * tmpvar_7));
  };
  bool tmpvar_10;
  tmpvar_10 = (tmpvar_5 > 0.0);
  if (!(tmpvar_10)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  highp vec3 data_11;
  lowp vec3 tmpvar_12;
  if ((xlv_TEXCOORD2.z > 0.0)) {
    highp vec2 P_13;
    P_13 = (vec2(0.5, 0.5) + ((xlv_TEXCOORD2.xy * 4.0) / _sunglareScale));
    tmpvar_12 = texture2D (_Sun_Glare, P_13).xyz;
  } else {
    tmpvar_12 = vec3(0.0, 0.0, 0.0);
  };
  data_11 = tmpvar_12;
  sunColor_1 = (pow (max (vec3(0.0, 0.0, 0.0), data_11), vec3(2.2, 2.2, 2.2)) * _Sun_Intensity);
  highp vec3 camera_14;
  camera_14 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp vec3 viewdir_15;
  viewdir_15.yz = tmpvar_2.yz;
  highp vec3 extinction_16;
  highp float mu_17;
  highp float rMu_18;
  highp float r_19;
  highp vec3 result_20;
  extinction_16 = vec3(1.0, 1.0, 1.0);
  result_20 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_21;
  tmpvar_21 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_15.x = (tmpvar_2.x + _viewdirOffset);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(viewdir_15);
  viewdir_15 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(dot (camera_14, camera_14));
  r_19 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (camera_14, tmpvar_22);
  rMu_18 = tmpvar_24;
  mu_17 = (tmpvar_24 / tmpvar_23);
  highp float tmpvar_25;
  tmpvar_25 = max ((-(tmpvar_24) - sqrt((((tmpvar_24 * tmpvar_24) - (tmpvar_23 * tmpvar_23)) + (tmpvar_21 * tmpvar_21)))), 0.0);
  if ((tmpvar_25 > 0.0)) {
    camera_14 = (camera_14 + (tmpvar_25 * tmpvar_22));
    highp float tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_25);
    rMu_18 = tmpvar_26;
    mu_17 = (tmpvar_26 / tmpvar_21);
    r_19 = tmpvar_21;
  };
  highp float tmpvar_27;
  tmpvar_27 = dot (tmpvar_22, _Sun_WorldSunDir);
  highp float tmpvar_28;
  tmpvar_28 = (dot (camera_14, _Sun_WorldSunDir) / r_19);
  highp vec4 tmpvar_29;
  highp float uMu_30;
  highp float uR_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(((tmpvar_21 * tmpvar_21) - (Rg * Rg)));
  highp float tmpvar_33;
  tmpvar_33 = sqrt(((r_19 * r_19) - (Rg * Rg)));
  highp float tmpvar_34;
  tmpvar_34 = (r_19 * (rMu_18 / r_19));
  highp float tmpvar_35;
  tmpvar_35 = (((tmpvar_34 * tmpvar_34) - (r_19 * r_19)) + (Rg * Rg));
  highp vec4 tmpvar_36;
  if (((tmpvar_34 < 0.0) && (tmpvar_35 > 0.0))) {
    highp vec4 tmpvar_37;
    tmpvar_37.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_37.w = (0.5 - (0.5 / RES_MU));
    tmpvar_36 = tmpvar_37;
  } else {
    highp vec4 tmpvar_38;
    tmpvar_38.x = -1.0;
    tmpvar_38.y = (tmpvar_32 * tmpvar_32);
    tmpvar_38.z = tmpvar_32;
    tmpvar_38.w = (0.5 + (0.5 / RES_MU));
    tmpvar_36 = tmpvar_38;
  };
  uR_31 = ((0.5 / RES_R) + ((tmpvar_33 / tmpvar_32) * (1.0 - (1.0/(RES_R)))));
  uMu_30 = (tmpvar_36.w + ((((tmpvar_34 * tmpvar_36.x) + sqrt((tmpvar_35 + tmpvar_36.y))) / (tmpvar_33 + tmpvar_36.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_39;
  y_over_x_39 = (max (tmpvar_28, -0.1975) * 5.34962);
  highp float x_40;
  x_40 = (y_over_x_39 * inversesqrt(((y_over_x_39 * y_over_x_39) + 1.0)));
  highp float tmpvar_41;
  tmpvar_41 = ((0.5 / RES_MU_S) + (((((sign(x_40) * (1.5708 - (sqrt((1.0 - abs(x_40))) * (1.5708 + (abs(x_40) * (-0.214602 + (abs(x_40) * (0.0865667 + (abs(x_40) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_42;
  tmpvar_42 = (((tmpvar_27 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_43;
  tmpvar_43 = floor(tmpvar_42);
  highp float tmpvar_44;
  tmpvar_44 = (tmpvar_42 - tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (floor(((uR_31 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_46;
  tmpvar_46 = (floor((uR_31 * RES_R)) / RES_R);
  highp float tmpvar_47;
  tmpvar_47 = fract((uR_31 * RES_R));
  highp vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.x = ((tmpvar_43 + tmpvar_41) / RES_NU);
  tmpvar_48.y = ((uMu_30 / RES_R) + tmpvar_45);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2DLodEXT (_Sky_Inscatter, tmpvar_48.xy, 0.0);
  highp vec4 tmpvar_50;
  tmpvar_50.zw = vec2(0.0, 0.0);
  tmpvar_50.x = (((tmpvar_43 + tmpvar_41) + 1.0) / RES_NU);
  tmpvar_50.y = ((uMu_30 / RES_R) + tmpvar_45);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2DLodEXT (_Sky_Inscatter, tmpvar_50.xy, 0.0);
  highp vec4 tmpvar_52;
  tmpvar_52.zw = vec2(0.0, 0.0);
  tmpvar_52.x = ((tmpvar_43 + tmpvar_41) / RES_NU);
  tmpvar_52.y = ((uMu_30 / RES_R) + tmpvar_46);
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2DLodEXT (_Sky_Inscatter, tmpvar_52.xy, 0.0);
  highp vec4 tmpvar_54;
  tmpvar_54.zw = vec2(0.0, 0.0);
  tmpvar_54.x = (((tmpvar_43 + tmpvar_41) + 1.0) / RES_NU);
  tmpvar_54.y = ((uMu_30 / RES_R) + tmpvar_46);
  lowp vec4 tmpvar_55;
  tmpvar_55 = texture2DLodEXT (_Sky_Inscatter, tmpvar_54.xy, 0.0);
  tmpvar_29 = ((((tmpvar_49 * (1.0 - tmpvar_44)) + (tmpvar_51 * tmpvar_44)) * (1.0 - tmpvar_47)) + (((tmpvar_53 * (1.0 - tmpvar_44)) + (tmpvar_55 * tmpvar_44)) * tmpvar_47));
  highp vec3 tmpvar_56;
  highp float y_over_x_57;
  y_over_x_57 = (((mu_17 + 0.15) / 1.15) * 14.1014);
  highp float x_58;
  x_58 = (y_over_x_57 * inversesqrt(((y_over_x_57 * y_over_x_57) + 1.0)));
  highp vec2 tmpvar_59;
  tmpvar_59.x = ((sign(x_58) * (1.5708 - (sqrt((1.0 - abs(x_58))) * (1.5708 + (abs(x_58) * (-0.214602 + (abs(x_58) * (0.0865667 + (abs(x_58) * -0.0310296))))))))) / 1.5);
  tmpvar_59.y = sqrt(((r_19 - Rg) / (tmpvar_21 - Rg)));
  lowp vec4 tmpvar_60;
  tmpvar_60 = texture2DLodEXT (_Sky_Transmittance, tmpvar_59, 0.0);
  tmpvar_56 = tmpvar_60.xyz;
  extinction_16 = tmpvar_56;
  if ((r_19 <= tmpvar_21)) {
    result_20 = ((tmpvar_29.xyz * (0.0596831 * (1.0 + (tmpvar_27 * tmpvar_27)))) + ((((tmpvar_29.xyz * tmpvar_29.w) / max (tmpvar_29.x, 0.0001)) * (betaR.x / betaR)) * ((((0.119366 * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_27)), -1.5)) * (1.0 + (tmpvar_27 * tmpvar_27))) / (2.0 + (mieG * mieG)))));
  } else {
    result_20 = vec3(0.0, 0.0, 0.0);
    extinction_16 = vec3(1.0, 1.0, 1.0);
  };
  highp vec3 L_61;
  highp vec3 tmpvar_62;
  tmpvar_62 = (((sunColor_1 * extinction_16) + (result_20 * _Sun_Intensity)) * xlat_mutable_Exposure);
  L_61 = tmpvar_62;
  highp float tmpvar_63;
  if ((tmpvar_62.x < 1.413)) {
    tmpvar_63 = pow ((tmpvar_62.x * 0.38317), 0.454545);
  } else {
    tmpvar_63 = (1.0 - exp(-(tmpvar_62.x)));
  };
  L_61.x = tmpvar_63;
  highp float tmpvar_64;
  if ((tmpvar_62.y < 1.413)) {
    tmpvar_64 = pow ((tmpvar_62.y * 0.38317), 0.454545);
  } else {
    tmpvar_64 = (1.0 - exp(-(tmpvar_62.y)));
  };
  L_61.y = tmpvar_64;
  highp float tmpvar_65;
  if ((tmpvar_62.z < 1.413)) {
    tmpvar_65 = pow ((tmpvar_62.z * 0.38317), 0.454545);
  } else {
    tmpvar_65 = (1.0 - exp(-(tmpvar_62.z)));
  };
  L_61.z = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66.w = 1.0;
  tmpvar_66.xyz = (_Alpha_Global * L_61);
  gl_FragData[0] = tmpvar_66;
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
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Inscatter;
uniform highp float _viewdirOffset;
uniform highp float _experimentalAtmoScale;
uniform highp float _sunglareScale;
uniform highp float _Alpha_Global;
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec3 _Globals_Origin;
uniform highp float _Globals_ApparentDistance;
uniform highp float _RimExposure;
uniform highp float _rimQuickFixMultiplier;
uniform sampler2D _Sun_Glare;
uniform highp vec3 _Sun_WorldSunDir;
highp float xlat_mutable_Exposure;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_Exposure = _Exposure;
  highp vec3 sunColor_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD1);
  highp vec3 p1_3;
  p1_3 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp float r_4;
  r_4 = (Rg * _rimQuickFixMultiplier);
  highp float tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (((_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance)) + tmpvar_2) - p1_3);
  highp float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (2.0 * dot (tmpvar_6, (p1_3 - _Globals_Origin)));
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_8) - ((4.0 * tmpvar_7) * (((dot (_Globals_Origin, _Globals_Origin) + dot (p1_3, p1_3)) - (2.0 * dot (_Globals_Origin, p1_3))) - (r_4 * r_4))));
  if ((tmpvar_9 < 0.0)) {
    tmpvar_5 = -1.0;
  } else {
    tmpvar_5 = ((-(tmpvar_8) - sqrt(tmpvar_9)) / (2.0 * tmpvar_7));
  };
  bool tmpvar_10;
  tmpvar_10 = (tmpvar_5 > 0.0);
  if (!(tmpvar_10)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  highp vec3 data_11;
  lowp vec3 tmpvar_12;
  if ((xlv_TEXCOORD2.z > 0.0)) {
    highp vec2 P_13;
    P_13 = (vec2(0.5, 0.5) + ((xlv_TEXCOORD2.xy * 4.0) / _sunglareScale));
    tmpvar_12 = texture (_Sun_Glare, P_13).xyz;
  } else {
    tmpvar_12 = vec3(0.0, 0.0, 0.0);
  };
  data_11 = tmpvar_12;
  sunColor_1 = (pow (max (vec3(0.0, 0.0, 0.0), data_11), vec3(2.2, 2.2, 2.2)) * _Sun_Intensity);
  highp vec3 camera_14;
  camera_14 = (_Globals_WorldCameraPos - (_Globals_Origin * _Globals_ApparentDistance));
  highp vec3 viewdir_15;
  viewdir_15.yz = tmpvar_2.yz;
  highp vec3 extinction_16;
  highp float mu_17;
  highp float rMu_18;
  highp float r_19;
  highp vec3 result_20;
  extinction_16 = vec3(1.0, 1.0, 1.0);
  result_20 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_21;
  tmpvar_21 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_15.x = (tmpvar_2.x + _viewdirOffset);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(viewdir_15);
  viewdir_15 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(dot (camera_14, camera_14));
  r_19 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (camera_14, tmpvar_22);
  rMu_18 = tmpvar_24;
  mu_17 = (tmpvar_24 / tmpvar_23);
  highp float tmpvar_25;
  tmpvar_25 = max ((-(tmpvar_24) - sqrt((((tmpvar_24 * tmpvar_24) - (tmpvar_23 * tmpvar_23)) + (tmpvar_21 * tmpvar_21)))), 0.0);
  if ((tmpvar_25 > 0.0)) {
    camera_14 = (camera_14 + (tmpvar_25 * tmpvar_22));
    highp float tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_25);
    rMu_18 = tmpvar_26;
    mu_17 = (tmpvar_26 / tmpvar_21);
    r_19 = tmpvar_21;
  };
  highp float tmpvar_27;
  tmpvar_27 = dot (tmpvar_22, _Sun_WorldSunDir);
  highp float tmpvar_28;
  tmpvar_28 = (dot (camera_14, _Sun_WorldSunDir) / r_19);
  highp vec4 tmpvar_29;
  highp float uMu_30;
  highp float uR_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(((tmpvar_21 * tmpvar_21) - (Rg * Rg)));
  highp float tmpvar_33;
  tmpvar_33 = sqrt(((r_19 * r_19) - (Rg * Rg)));
  highp float tmpvar_34;
  tmpvar_34 = (r_19 * (rMu_18 / r_19));
  highp float tmpvar_35;
  tmpvar_35 = (((tmpvar_34 * tmpvar_34) - (r_19 * r_19)) + (Rg * Rg));
  highp vec4 tmpvar_36;
  if (((tmpvar_34 < 0.0) && (tmpvar_35 > 0.0))) {
    highp vec4 tmpvar_37;
    tmpvar_37.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_37.w = (0.5 - (0.5 / RES_MU));
    tmpvar_36 = tmpvar_37;
  } else {
    highp vec4 tmpvar_38;
    tmpvar_38.x = -1.0;
    tmpvar_38.y = (tmpvar_32 * tmpvar_32);
    tmpvar_38.z = tmpvar_32;
    tmpvar_38.w = (0.5 + (0.5 / RES_MU));
    tmpvar_36 = tmpvar_38;
  };
  uR_31 = ((0.5 / RES_R) + ((tmpvar_33 / tmpvar_32) * (1.0 - (1.0/(RES_R)))));
  uMu_30 = (tmpvar_36.w + ((((tmpvar_34 * tmpvar_36.x) + sqrt((tmpvar_35 + tmpvar_36.y))) / (tmpvar_33 + tmpvar_36.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_39;
  y_over_x_39 = (max (tmpvar_28, -0.1975) * 5.34962);
  highp float x_40;
  x_40 = (y_over_x_39 * inversesqrt(((y_over_x_39 * y_over_x_39) + 1.0)));
  highp float tmpvar_41;
  tmpvar_41 = ((0.5 / RES_MU_S) + (((((sign(x_40) * (1.5708 - (sqrt((1.0 - abs(x_40))) * (1.5708 + (abs(x_40) * (-0.214602 + (abs(x_40) * (0.0865667 + (abs(x_40) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_42;
  tmpvar_42 = (((tmpvar_27 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_43;
  tmpvar_43 = floor(tmpvar_42);
  highp float tmpvar_44;
  tmpvar_44 = (tmpvar_42 - tmpvar_43);
  highp float tmpvar_45;
  tmpvar_45 = (floor(((uR_31 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_46;
  tmpvar_46 = (floor((uR_31 * RES_R)) / RES_R);
  highp float tmpvar_47;
  tmpvar_47 = fract((uR_31 * RES_R));
  highp vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.x = ((tmpvar_43 + tmpvar_41) / RES_NU);
  tmpvar_48.y = ((uMu_30 / RES_R) + tmpvar_45);
  lowp vec4 tmpvar_49;
  tmpvar_49 = textureLod (_Sky_Inscatter, tmpvar_48.xy, 0.0);
  highp vec4 tmpvar_50;
  tmpvar_50.zw = vec2(0.0, 0.0);
  tmpvar_50.x = (((tmpvar_43 + tmpvar_41) + 1.0) / RES_NU);
  tmpvar_50.y = ((uMu_30 / RES_R) + tmpvar_45);
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureLod (_Sky_Inscatter, tmpvar_50.xy, 0.0);
  highp vec4 tmpvar_52;
  tmpvar_52.zw = vec2(0.0, 0.0);
  tmpvar_52.x = ((tmpvar_43 + tmpvar_41) / RES_NU);
  tmpvar_52.y = ((uMu_30 / RES_R) + tmpvar_46);
  lowp vec4 tmpvar_53;
  tmpvar_53 = textureLod (_Sky_Inscatter, tmpvar_52.xy, 0.0);
  highp vec4 tmpvar_54;
  tmpvar_54.zw = vec2(0.0, 0.0);
  tmpvar_54.x = (((tmpvar_43 + tmpvar_41) + 1.0) / RES_NU);
  tmpvar_54.y = ((uMu_30 / RES_R) + tmpvar_46);
  lowp vec4 tmpvar_55;
  tmpvar_55 = textureLod (_Sky_Inscatter, tmpvar_54.xy, 0.0);
  tmpvar_29 = ((((tmpvar_49 * (1.0 - tmpvar_44)) + (tmpvar_51 * tmpvar_44)) * (1.0 - tmpvar_47)) + (((tmpvar_53 * (1.0 - tmpvar_44)) + (tmpvar_55 * tmpvar_44)) * tmpvar_47));
  highp vec3 tmpvar_56;
  highp float y_over_x_57;
  y_over_x_57 = (((mu_17 + 0.15) / 1.15) * 14.1014);
  highp float x_58;
  x_58 = (y_over_x_57 * inversesqrt(((y_over_x_57 * y_over_x_57) + 1.0)));
  highp vec2 tmpvar_59;
  tmpvar_59.x = ((sign(x_58) * (1.5708 - (sqrt((1.0 - abs(x_58))) * (1.5708 + (abs(x_58) * (-0.214602 + (abs(x_58) * (0.0865667 + (abs(x_58) * -0.0310296))))))))) / 1.5);
  tmpvar_59.y = sqrt(((r_19 - Rg) / (tmpvar_21 - Rg)));
  lowp vec4 tmpvar_60;
  tmpvar_60 = textureLod (_Sky_Transmittance, tmpvar_59, 0.0);
  tmpvar_56 = tmpvar_60.xyz;
  extinction_16 = tmpvar_56;
  if ((r_19 <= tmpvar_21)) {
    result_20 = ((tmpvar_29.xyz * (0.0596831 * (1.0 + (tmpvar_27 * tmpvar_27)))) + ((((tmpvar_29.xyz * tmpvar_29.w) / max (tmpvar_29.x, 0.0001)) * (betaR.x / betaR)) * ((((0.119366 * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_27)), -1.5)) * (1.0 + (tmpvar_27 * tmpvar_27))) / (2.0 + (mieG * mieG)))));
  } else {
    result_20 = vec3(0.0, 0.0, 0.0);
    extinction_16 = vec3(1.0, 1.0, 1.0);
  };
  highp vec3 L_61;
  highp vec3 tmpvar_62;
  tmpvar_62 = (((sunColor_1 * extinction_16) + (result_20 * _Sun_Intensity)) * xlat_mutable_Exposure);
  L_61 = tmpvar_62;
  highp float tmpvar_63;
  if ((tmpvar_62.x < 1.413)) {
    tmpvar_63 = pow ((tmpvar_62.x * 0.38317), 0.454545);
  } else {
    tmpvar_63 = (1.0 - exp(-(tmpvar_62.x)));
  };
  L_61.x = tmpvar_63;
  highp float tmpvar_64;
  if ((tmpvar_62.y < 1.413)) {
    tmpvar_64 = pow ((tmpvar_62.y * 0.38317), 0.454545);
  } else {
    tmpvar_64 = (1.0 - exp(-(tmpvar_62.y)));
  };
  L_61.y = tmpvar_64;
  highp float tmpvar_65;
  if ((tmpvar_62.z < 1.413)) {
    tmpvar_65 = pow ((tmpvar_62.z * 0.38317), 0.454545);
  } else {
    tmpvar_65 = (1.0 - exp(-(tmpvar_62.z)));
  };
  L_61.z = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66.w = 1.0;
  tmpvar_66.xyz = (_Alpha_Global * L_61);
  _glesFragData[0] = tmpvar_66;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 281 math, 11 textures
Float 0 [_Exposure]
Float 1 [Rg]
Float 2 [Rt]
Vector 3 [betaR]
Float 4 [mieG]
Float 5 [RES_R]
Float 6 [RES_MU]
Float 7 [RES_MU_S]
Float 8 [RES_NU]
Float 9 [_Sun_Intensity]
Float 10 [_viewdirOffset]
Float 11 [_experimentalAtmoScale]
Float 12 [_sunglareScale]
Float 13 [_Alpha_Global]
Vector 14 [_Globals_WorldCameraPos]
Vector 15 [_Globals_Origin]
Float 16 [_Globals_ApparentDistance]
Float 17 [_RimExposure]
Float 18 [_rimQuickFixMultiplier]
Vector 19 [_Sun_WorldSunDir]
SetTexture 0 [_Sun_Glare] 2D 0
SetTexture 1 [_Sky_Inscatter] 2D 1
SetTexture 2 [_Sky_Transmittance] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c20, 0.00000000, 4.00000000, 0.50000000, 2.20000005
def c21, 1000000015047466200000000000000.00000000, 1.00000000, 0.00000000, 0.15000001
def c22, 12.26193905, -1.00000000, -0.01348047, 0.05747731
def c23, -0.12123910, 0.19563590, -0.33299461, 0.99999559
def c24, 1.57079601, 0.66666669, -0.19750001, 5.34960032
def c25, 0.90909088, 0.74000001, 0.05968311, 2.00000000
def c26, -1.50000000, 0.00010000, 0.11936623, -1.41299999
def c27, 2.71828198, 0.38317001, 0.45454544, 0
dcl_texcoord1 v0.xyz
dcl_texcoord2 v1.xyz
rcp r5.z, c6.x
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul r4.xyz, r0.x, v0
mov r1.xyz, c15
mul r1.xyz, c16.x, -r1
add r3.xyz, r1, c14
dp3 r7.x, r3, r3
rsq r7.y, r7.x
rcp r1.w, r7.y
mov r0.yz, r4
add r0.x, r4, c10
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov r0.w, c2.x
add r0.w, -c1.x, r0
mul r5.w, r0, c11.x
dp3 r4.w, r3, r0
mul r1.x, r1.w, r1.w
dp3 r8.y, r0, c19
add r6.w, r5, c1.x
mad r0.w, r4, r4, -r1.x
mad r0.w, r6, r6, r0
rsq r1.x, r0.w
rcp r1.x, r1.x
cmp r0.w, r0, r1.x, c21.x
add r0.w, -r4, -r0
max r7.z, r0.w, c20.x
mad r1.xyz, r7.z, r0, r3
cmp r1.xyz, -r7.z, r3, r1
cmp r7.w, -r7.z, r1, r6
dp3 r0.w, r1, c19
rcp r1.w, r7.w
mul r0.w, r0, r1
max r0.w, r0, c24.z
mul r0.w, r0, c24
abs r1.x, r0.w
max r1.y, r1.x, c21
rcp r1.z, r1.y
min r1.y, r1.x, c21
mul r1.y, r1, r1.z
mul r1.z, r1.y, r1.y
mad r1.w, r1.z, c22.z, c22
mad r1.w, r1, r1.z, c23.x
mad r1.w, r1, r1.z, c23.y
mad r1.w, r1, r1.z, c23.z
mad r1.z, r1.w, r1, c23.w
mul r1.y, r1.z, r1
add r1.z, -r1.y, c24.x
add r1.x, r1, c22.y
cmp r1.x, -r1, r1.y, r1.z
cmp r0.w, r0, r1.x, -r1.x
mov r1.x, c8
mul r5.y, c1.x, c1.x
mad r2.w, r5.z, c20.z, c20.z
add r0.y, c22, r1.x
add r0.x, r8.y, c21.y
mul r0.y, r0.x, r0
mad r0.x, r0.w, c25, c25.y
mul r0.w, r0.y, c20.z
frc r8.w, r0
rcp r0.y, c7.x
add r0.z, -r0.y, c21.y
mad r0.x, r0, r0.z, r0.y
mad r0.z, r6.w, r6.w, -r5.y
add r0.w, r0, -r8
mad r1.w, r0.x, c20.z, r0
add r0.x, r7.z, r4.w
cmp r8.x, -r7.z, r4.w, r0
rsq r1.y, r0.z
rcp r0.w, r1.y
add r0.y, r1.w, c21
rcp r5.x, c8.x
mul r1.x, r5, r0.y
mul r0.y, r7.w, r7.w
mad r0.y, r8.x, r8.x, -r0
mad r1.z, c1.x, c1.x, r0.y
mul r5.x, r1.w, r5
cmp r0.y, -r1.z, c21.z, c21
cmp r0.x, r8, c21.z, c21.y
mul_pp r6.x, r0, r0.y
mul r2.y, r0.w, r0.w
mov r2.z, r0.w
mov r2.x, c22.y
mad r0.w, -r5.z, c20.z, c20.z
mov r0.xyz, c21.yzzw
cmp r0, -r6.x, r2, r0
add r0.y, r0, r1.z
rcp r2.x, c5.x
mad r1.z, r7.w, r7.w, -r5.y
rsq r0.y, r0.y
rsq r1.z, r1.z
rcp r1.z, r1.z
add r0.z, r0, r1
rcp r0.y, r0.y
add r2.y, -r2.x, c21
mul r1.y, r1, r1.z
mul r1.y, r1, r2
mad r1.y, r2.x, c20.z, r1
mad r0.y, r8.x, r0.x, r0
mul r0.x, r1.y, c5
add r1.y, r0.x, c22
frc r1.z, r1.y
add r1.y, r1, -r1.z
rcp r0.z, r0.z
mul r0.y, r0, r0.z
add r0.z, -r5, c20
mul r1.z, r1.y, r2.x
mad r1.y, r0, r0.z, r0.w
mad r6.y, r1, r2.x, r1.z
frc r8.z, r0.x
add r1.z, r0.x, -r8
mul r2.y, r2.x, r1.z
mad r1.y, r1, r2.x, r2
mov r1.z, c20.x
texldl r2, r1.xyzz, s1
mov r5.y, r1
mov r6.x, r1
mov r6.z, c20.x
mov r5.z, c20.x
texldl r1, r5.xyzz, s1
texldl r0, r6.xyzz, s1
mul r2, r8.w, r2
add r5.y, -r8.w, c21
mad r1, r5.y, r1, r2
mul r2, r8.w, r0
mul r1, r8.z, r1
mov r0.x, r5
mov r0.z, c20.x
mov r0.y, r6
texldl r0, r0.xyzz, s1
mad r0, r0, r5.y, r2
add r2.x, -r8.z, c21.y
mad r0, r0, r2.x, r1
mul r1.xyz, r0, r0.w
max r1.w, r0.x, c26.y
rcp r2.x, r1.w
mul r2.xyz, r1, r2.x
rcp r0.w, r6.w
mul r1.w, r8.x, r0
mul r0.w, r7.y, r4
cmp r0.w, -r7.z, r0, r1
add r0.w, r0, c21
mul r0.w, r0, c22.x
abs r2.w, r0
rcp r1.x, c3.x
rcp r1.z, c3.z
rcp r1.y, c3.y
mul r1.xyz, r1, c3.x
mul r2.xyz, r2, r1
mul r1.y, r8, c4.x
mul r1.z, r1.y, c25.w
max r1.y, r2.w, c21
mad r1.z, c4.x, c4.x, -r1
min r1.x, r2.w, c21.y
rcp r1.y, r1.y
mul r4.w, r1.x, r1.y
add r5.x, r1.z, c21.y
pow r1, r5.x, c26.x
mul r1.y, -c4.x, c4.x
mov r1.z, r1.x
mad r5.x, r8.y, r8.y, c21.y
add r1.x, r1.y, c21.y
add r1.w, -r1.y, c25
mul r1.x, r1, r1.z
rcp r1.y, r1.w
mul r1.x, r5, r1
mul r1.x, r1, r1.y
mul r1.xyz, r1.x, r2
mul r1.w, r4, r4
mad r2.x, r1.w, c22.z, c22.w
mul r1.xyz, r1, c26.z
mul r0.xyz, r5.x, r0
mad r0.xyz, r0, c25.z, r1
mad r2.x, r2, r1.w, c23
mad r1.y, r2.x, r1.w, c23
add r2.xyz, r3, r4
mad r1.y, r1, r1.w, c23.z
mad r1.y, r1, r1.w, c23.w
mul r1.y, r1, r4.w
add r1.x, -r7.w, r6.w
cmp r1.x, r1, c21.y, c21.z
abs_pp r1.w, r1.x
cmp r0.xyz, -r1.w, c20.x, r0
add r1.x, r2.w, c22.y
add r1.z, -r1.y, c24.x
cmp r1.x, -r1, r1.y, r1.z
cmp r0.w, r0, r1.x, -r1.x
dp3 r2.w, c15, c15
add r4.y, r7.x, r2.w
dp3 r4.x, r3, c15
add r2.xyz, -r3, r2
mul r1.x, r0.w, c24.y
mov r2.w, c1.x
dp3 r0.w, r2, r2
add r3.xyz, r3, -c15
dp3 r2.x, r2, r3
mul r2.x, r2, c25.w
rcp r1.z, r5.w
add r1.y, r7.w, -c1.x
mul r1.y, r1, r1.z
rsq r1.y, r1.y
mad r4.x, -r4, c25.w, r4.y
mul r2.w, c18.x, r2
mad r2.w, -r2, r2, r4.x
mul r2.w, r0, r2
mul r2.y, r2.w, c20
mul r0.w, r0, c25
mad r2.y, r2.x, r2.x, -r2
mul r0.xyz, r0, c9.x
rcp r1.y, r1.y
mov r1.z, c20.x
texldl r1.xyz, r1.xyzz, s2
cmp r3.xyz, -r1.w, c21.y, r1
rsq r1.x, r2.y
cmp_pp r1.w, r2.y, c21.y, c21.z
rcp r1.x, r1.x
add r1.z, -r2.x, -r1.x
rcp r1.x, c12.x
mul r1.xy, v1, r1.x
rcp r0.w, r0.w
cmp r2.y, r2, r3.w, c22
mul r0.w, r1.z, r0
cmp r0.w, -r1, r2.y, r0
mad r1.xy, r1, c20.y, c20.z
texld r1.xyz, r1, s0
cmp r1.xyz, -v1.z, c20.x, r1
max r2.xyz, r1, c20.x
pow r1, r2.x, c20.w
mov r1.y, c0.x
pow r4, r2.y, c20.w
cmp r0.w, -r0, c21.z, c21.y
abs_pp r0.w, r0
cmp r0.w, -r0, c17.x, r1.y
mov r2.x, r1
pow r1, r2.z, c20.w
mov r2.z, r1
mov r2.y, r4
mul r1.xyz, r2, c9.x
mad r0.xyz, r1, r3, r0
mul r2.xyz, r0, r0.w
mul r3.x, r2.z, c27.y
pow r0, r3.x, c27.z
pow r1, c27.x, -r2.z
mov r0.y, r1.x
mov r0.z, r0.x
pow r1, c27.x, -r2.x
add r2.w, r2.z, c26
add r0.x, -r0.y, c21.y
cmp r2.z, r2.w, r0.x, r0
mul r3.x, r2, c27.y
pow r0, r3.x, c27.z
add r2.w, r2.x, c26
mov r0.y, r1.x
mov r0.z, r0.x
add r0.x, -r0.y, c21.y
cmp r2.x, r2.w, r0, r0.z
pow r0, c27.x, -r2.y
mul r3.x, r2.y, c27.y
pow r1, r3.x, c27.z
add r2.w, r2.y, c26
mov r0.y, r1.x
add r0.x, -r0, c21.y
cmp r2.y, r2.w, r0.x, r0
mul oC0.xyz, r2, c13.x
mov oC0.w, c21.y
"
}
SubProgram "d3d11 " {
// Stats: 189 math, 1 textures
SetTexture 0 [_Sun_Glare] 2D 2
SetTexture 1 [_Sky_Inscatter] 2D 1
SetTexture 2 [_Sky_Transmittance] 2D 0
ConstBuffer "$Globals" 416
Float 16 [_Exposure]
Float 24 [Rg]
Float 28 [Rt]
Vector 48 [betaR] 3
Float 92 [mieG]
Float 112 [RES_R]
Float 116 [RES_MU]
Float 120 [RES_MU_S]
Float 124 [RES_NU]
Float 128 [_Sun_Intensity]
Float 132 [_viewdirOffset]
Float 136 [_experimentalAtmoScale]
Float 140 [_sunglareScale]
Float 144 [_Alpha_Global]
Vector 288 [_Globals_WorldCameraPos] 3
Vector 304 [_Globals_Origin] 3
Float 316 [_Globals_ApparentDistance]
Float 320 [_RimExposure]
Float 324 [_rimQuickFixMultiplier]
Vector 336 [_Sun_WorldSunDir] 3
BindCB  "$Globals" 0
"ps_4_0
eefiecedfimjmjamokebfgohhnfcdjfdobejhiojabaaaaaahablaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefciabkaaaaeaaaaaaakaagaaaafjaaaaaeegiocaaa
aaaaaaaabgaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacajaaaaaadgaaaaaihcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaialpbaaaaaah
bcaabaaaacaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadcaaaaakbcaabaaaadaaaaaaakbabaaaacaaaaaa
akaabaaaacaaaaaabkiacaaaaaaaaaaaaiaaaaaadiaaaaahocaabaaaadaaaaaa
agaabaaaacaaaaaaagbjbaaaacaaaaaabaaaaaahbcaabaaaacaaaaaaigadbaaa
adaaaaaaigadbaaaadaaaaaaeeaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaacaaaaaaigadbaaaadaaaaaadcaaaaan
hcaabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaabdaaaaaapgipcaaaaaaaaaaa
bdaaaaaaegiccaaaaaaaaaaabcaaaaaabaaaaaahccaabaaaafaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaaeaaaaaa
egacbaaaaeaaaaaadcaaaaakbcaabaaaadaaaaaabkaabaaaafaaaaaabkaabaaa
afaaaaaadkaabaiaebaaaaaaacaaaaaaaaaaaaakicaabaaaaeaaaaaackiacaia
ebaaaaaaaaaaaaaaabaaaaaadkiacaaaaaaaaaaaabaaaaaadcaaaaalbcaabaaa
agaaaaaadkaabaaaaeaaaaaackiacaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaa
abaaaaaadiaaaaaiicaabaaaaeaaaaaadkaabaaaaeaaaaaackiacaaaaaaaaaaa
aiaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaaagaaaaaaakaabaaaagaaaaaa
akaabaaaadaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaaj
bcaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaabkaabaiaebaaaaaaafaaaaaa
deaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ccaabaaaagaaaaaaakaabaaaadaaaaaabkaabaaaafaaaaaaaoaaaaahecaabaaa
agaaaaaabkaabaaaagaaaaaaakaabaaaagaaaaaadbaaaaahicaabaaaafaaaaaa
abeaaaaaaaaaaaaaakaabaaaadaaaaaadcaaaaajhcaabaaaahaaaaaaagaabaaa
adaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaabaaaaaaibcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaaaaaaaaabfaaaaaadhaaaaajhcaabaaaahaaaaaa
pgapbaaaafaaaaaaegacbaaaahaaaaaaegacbaaaaeaaaaaabaaaaaaiccaabaaa
acaaaaaaegacbaaaahaaaaaaegiccaaaaaaaaaaabfaaaaaaelaaaaafbcaabaaa
afaaaaaadkaabaaaacaaaaaaaoaaaaahecaabaaaafaaaaaabkaabaaaafaaaaaa
akaabaaaafaaaaaadhaaaaajhcaabaaaafaaaaaapgapbaaaafaaaaaaegacbaaa
agaaaaaaegacbaaaafaaaaaadiaaaaahecaabaaaacaaaaaaakaabaaaafaaaaaa
akaabaaaafaaaaaadcaaaaakecaabaaaacaaaaaabkaabaaaafaaaaaabkaabaaa
afaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalecaabaaaacaaaaaackiacaaa
aaaaaaaaabaaaaaackiacaaaaaaaaaaaabaaaaaackaabaaaacaaaaaadbaaaaah
bcaabaaaadaaaaaaabeaaaaaaaaaaaaackaabaaaacaaaaaadbaaaaahicaabaaa
afaaaaaabkaabaaaafaaaaaaabeaaaaaaaaaaaaaabaaaaahbcaabaaaadaaaaaa
akaabaaaadaaaaaadkaabaaaafaaaaaadiaaaaajicaabaaaafaaaaaackiacaaa
aaaaaaaaabaaaaaackiacaaaaaaaaaaaabaaaaaadcaaaaakccaabaaaagaaaaaa
akaabaaaagaaaaaaakaabaaaagaaaaaadkaabaiaebaaaaaaafaaaaaabnaaaaah
bcaabaaaagaaaaaaakaabaaaagaaaaaaakaabaaaafaaaaaadcaaaaakicaabaaa
afaaaaaaakaabaaaafaaaaaaakaabaaaafaaaaaadkaabaiaebaaaaaaafaaaaaa
elaaaaaficaabaaaafaaaaaadkaabaaaafaaaaaaelaaaaafecaabaaaabaaaaaa
bkaabaaaagaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaaaoaaaaalocaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaadpfgiicaaaaaaaaaaaahaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaia
ebaaaaaaagaaaaaaabeaaaaaaaaaaadpaaaaaaahicaabaaaabaaaaaabkaabaaa
agaaaaaaabeaaaaaaaaaaadpdhaaaaajpcaabaaaaaaaaaaaagaabaaaadaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaaaoaaaaahbcaabaaaabaaaaaadkaabaaa
afaaaaaackaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaafaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
acaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaafaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaalocaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpagijcaaaaaaaaaaa
ahaaaaaaaaaaaaalocaabaaaabaaaaaafgaobaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaiadpaaaaaadpaaaaiadpdcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaagaaaaaadcaaaaakecaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaaabeaaaaaaaaaialp
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
ebaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaaifcaabaaaaaaaaaaa
agacbaaaaaaaaaaaagiacaaaaaaaaaaaahaaaaaaaaaaaaahecaabaaaahaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaaaoaaaaahecaabaaaaaaaaaaabkaabaaa
acaaaaaaakaabaaaafaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaahbdneklodiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
bodakleadeaaaaaiicaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
aaaaiadpaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaaaaaaaaaddaaaaaibcaabaaaabaaaaaackaabaiaibaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaafpkokkdm
abeaaaaadgfkkolndcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaochgdidodcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaajbcaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaadiphhpdpdiaaaaahccaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaiecaabaaaabaaaaaa
abeaaaaaaaaaiadpckaabaiaibaaaaaaaaaaaaaaddaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaadhaaaaakecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaacolkgidpabeaaaaakehadndpdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaagaaaaaaaaaaaaah
icaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpaaaaaaaibcaabaaaabaaaaaa
dkiacaaaaaaaaaaaahaaaaaaabeaaaaaaaaaialpdiaaaaahccaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaebaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpaoaaaaaiccaabaaaahaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaa
ahaaaaaaaoaaaaaibcaabaaaahaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
ahaaaaaaeiaaaaalpcaabaaaabaaaaaaigaabaaaahaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaaiaaaaaajgafbaaa
ahaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaaiecaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajpcaabaaa
abaaaaaaegaobaaaaiaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaaebaaaaaf
ccaabaaaacaaaaaabkaabaaaaaaaaaaabkaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaoaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaa
ahaaaaaaaaaaaaahicaabaaaahaaaaaaakaabaaaaaaaaaaabkaabaaaacaaaaaa
eiaaaaalpcaabaaaaiaaaaaamgaabaaaahaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaahaaaaaangafbaaaahaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaa
aiaaaaaapgapbaaaaaaaaaaaegaobaaaaiaaaaaadcaaaaajpcaabaaaahaaaaaa
egaobaaaahaaaaaakgakbaaaaaaaaaaaegaobaaaaiaaaaaadiaaaaahpcaabaaa
ahaaaaaafgafbaaaaaaaaaaaegaobaaaahaaaaaaaaaaaaaibcaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajpcaabaaaaaaaaaaa
egaobaaaabaaaaaaagaabaaaaaaaaaaaegaobaaaahaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaabhlhnbdiaoaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaaoaaaaajocaabaaaagaaaaaaagiacaaaaaaaaaaa
adaaaaaaagijcaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaajgahbaaaagaaaaaaapaaaaaiicaabaaaaaaaaaaaagaabaaaacaaaaaa
pgipcaaaaaaaaaaaafaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaodcaabaaaacaaaaaapgipcaaa
aaaaaaaaafaaaaaapgipcaaaaaaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaaaea
aaaaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
akaabaaaacaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaamalpbjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaambcaabaaaacaaaaaadkiacaiaebaaaaaa
aaaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaeihgpedndiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaeihghednaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkaabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaabaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaa
agaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
aiaaaaaadiaaaaakdcaabaaaabaaaaaaegbabaaaadaaaaaaaceaaaaaaaaaiaea
aaaaiaeaaaaaaaaaaaaaaaaaaoaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaa
pgipcaaaaaaaaaaaaiaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadbaaaaahicaabaaa
aaaaaaaaabeaaaaaaaaaaaaackbabaaaadaaaaaaabaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaadeaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafhcaabaaa
abaaaaaaegacbaaaabaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
aceaaaaamnmmameamnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaaabaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaa
aaaaaaaaaiaaaaaaaaaaaaahicaabaaaaaaaaaaackaabaaaafaaaaaaabeaaaaa
jkjjbjdoaaaaaaajicaabaaaabaaaaaaakaabaaaafaaaaaackiacaiaebaaaaaa
aaaaaaaaabaaaaaaaoaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
aeaaaaaaelaaaaafccaabaaaacaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaajfdbeeebdeaaaaaiicaabaaaabaaaaaa
dkaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaakicaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaabaaaaaaddaaaaai
ecaabaaaacaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaacaaaaaadiaaaaahecaabaaa
acaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajbcaabaaaadaaaaaa
ckaabaaaacaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaa
adaaaaaackaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaochgdidodcaaaaaj
bcaabaaaadaaaaaackaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaaaebnkjlo
dcaaaaajecaabaaaacaaaaaackaabaaaacaaaaaaakaabaaaadaaaaaaabeaaaaa
diphhpdpdiaaaaahbcaabaaaadaaaaaadkaabaaaabaaaaaackaabaaaacaaaaaa
dcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpdbaaaaaiicaabaaaaeaaaaaaabeaaaaaaaaaiadpdkaabaiaibaaaaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
dbaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaadkaabaaaaeaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaacaaaaaaakaabaaaadaaaaaa
dhaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaa
klkkckdpeiaaaaalpcaabaaaafaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadhaaaaamhcaabaaaacaaaaaaagaabaaa
agaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaaiicaabaaaaaaaaaaaegiccaaaaaaaaaaabdaaaaaaegacbaaa
aeaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaaeaaaaaaegiccaiaebaaaaaa
aaaaaaaabdaaaaaabaaaaaahbcaabaaaabaaaaaajgahbaaaadaaaaaaegacbaaa
abaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaadaaaaaajgahbaaaadaaaaaa
baaaaaajecaabaaaabaaaaaaegiccaaaaaaaaaaabdaaaaaaegiccaaaaaaaaaaa
bdaaaaaaaaaaaaahecaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaaea
ckaabaaaabaaaaaadiaaaaajecaabaaaabaaaaaackiacaaaaaaaaaaaabaaaaaa
bkiacaaaaaaaaaaabeaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaa
abaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiaeaaaaaaaahgcaabaaaabaaaaaafgaebaaaabaaaaaa
fgaebaaaabaaaaaadcaaaaakicaabaaaaaaaaaaackaabaaaabaaaaaackaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaafecaabaaaabaaaaaadkaabaaa
aaaaaaaabnaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dcaaaaalbcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaaea
ckaabaiaebaaaaaaabaaaaaaaoaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaabnaaaaahbcaabaaaabaaaaaaabeaaaaaaaaaaaaaakaabaaa
abaaaaaadhaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
abeaaaaappppppppdhaaaaalicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaa
aaaaaaaabeaaaaaaakiacaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaakpcaabaaaabaaaaaaagafbaaa
aaaaaaaaaceaaaaanmcomedodlkklilpnmcomedodlkklilpcpaaaaaffcaabaaa
abaaaaaaagacbaaaabaaaaaabjaaaaafkcaabaaaabaaaaaafganbaaaabaaaaaa
aaaaaaalkcaabaaaabaaaaaafganbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaiadpdiaaaaakfcaabaaaabaaaaaaagacbaaaabaaaaaa
aceaaaaacplkoidoaaaaaaaacplkoidoaaaaaaaabjaaaaaffcaabaaaabaaaaaa
agacbaaaabaaaaaadbaaaaaklcaabaaaaaaaaaaaegaibaaaaaaaaaaaaceaaaaa
cpnnledpcpnnledpaaaaaaaacpnnledpdiaaaaakdcaabaaaacaaaaaakgakbaaa
aaaaaaaaaceaaaaanmcomedodlkklilpaaaaaaaaaaaaaaaadhaaaaajdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaigaabaaaabaaaaaangafbaaaabaaaaaacpaaaaaf
bcaabaaaabaaaaaaakaabaaaacaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
acaaaaaaaaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaacplkoido
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadhaaaaajecaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaihccabaaa
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaajaaaaaadgaaaaaficcabaaa
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