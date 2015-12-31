// Compiled shader for all platforms, uncompressed size: 203.5KB

Shader "Proland/Ocean/OceanWhiteCaps" {
SubShader { 
 Tags { "QUEUE"="Geometry+100" "RenderType"="" }


 // Stats for Vertex shader:
 //       d3d11 : 149 math, 2 branch
 //        d3d9 : 286 math, 16 texture, 7 branch
 // Stats for Fragment shader:
 //       d3d11 : 324 math, 9 texture, 4 branch
 //        d3d9 : 458 math, 21 texture, 6 branch
 Pass {
  Tags { "QUEUE"="Geometry+100" "RenderType"="" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX
uniform float _Ocean_Radius;
uniform vec3 _Ocean_Horizon1;
uniform vec3 _Ocean_Horizon2;
uniform float _Ocean_HeightOffset;
uniform vec3 _Ocean_CameraPos;
uniform mat4 _Ocean_OceanToCamera;
uniform mat4 _Ocean_CameraToOcean;
uniform mat4 _Globals_ScreenToCamera;
uniform mat4 _Globals_CameraToScreen;
uniform vec2 _Ocean_MapSize;
uniform vec4 _Ocean_Choppyness;
uniform vec4 _Ocean_GridSizes;
uniform vec2 _Ocean_ScreenGridSize;
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map3;
uniform sampler2D _Ocean_Map4;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 dP_1;
  vec4 vert_2;
  vert_2.zw = gl_Vertex.zw;
  vert_2.xy = (gl_Vertex.xy * 1.25);
  vec2 tmpvar_3;
  float t_4;
  vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 1.0);
  tmpvar_5.x = vert_2.x;
  tmpvar_5.y = min (vert_2.y, ((_Ocean_Horizon1.x + (_Ocean_Horizon1.y * vert_2.x)) - sqrt((_Ocean_Horizon2.x + ((_Ocean_Horizon2.y + (_Ocean_Horizon2.z * vert_2.x)) * vert_2.x)))));
  vec3 tmpvar_6;
  tmpvar_6 = normalize((_Globals_ScreenToCamera * tmpvar_5).xyz);
  vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = tmpvar_6;
  vec3 tmpvar_8;
  tmpvar_8 = (_Ocean_CameraToOcean * tmpvar_7).xyz;
  if ((_Ocean_Radius == 0.0)) {
    t_4 = ((_Ocean_HeightOffset + -(_Ocean_CameraPos.z)) / tmpvar_8.z);
  } else {
    float tmpvar_9;
    tmpvar_9 = (tmpvar_8.z * (_Ocean_CameraPos.z + _Ocean_Radius));
    float tmpvar_10;
    tmpvar_10 = (-(tmpvar_9) - sqrt(max (((tmpvar_9 * tmpvar_9) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
    float tmpvar_11;
    tmpvar_11 = ((-(_Ocean_CameraPos.z) / tmpvar_8.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_8.z * tmpvar_8.z)))));
    float tmpvar_12;
    tmpvar_12 = abs(((tmpvar_11 - tmpvar_10) * tmpvar_8.z));
    float tmpvar_13;
    if ((tmpvar_12 < 1.0)) {
      tmpvar_13 = tmpvar_11;
    } else {
      tmpvar_13 = tmpvar_10;
    };
    t_4 = tmpvar_13;
  };
  tmpvar_3 = (_Ocean_CameraPos.xy + (t_4 * tmpvar_8.xy));
  vec4 tmpvar_14;
  tmpvar_14.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_14.x = _Ocean_ScreenGridSize.x;
  vec4 vert_15;
  vert_15 = (vert_2 + tmpvar_14);
  float t_16;
  vec4 tmpvar_17;
  tmpvar_17.zw = vec2(0.0, 1.0);
  tmpvar_17.x = vert_15.x;
  tmpvar_17.y = min (vert_15.y, ((_Ocean_Horizon1.x + (_Ocean_Horizon1.y * vert_15.x)) - sqrt((_Ocean_Horizon2.x + ((_Ocean_Horizon2.y + (_Ocean_Horizon2.z * vert_15.x)) * vert_15.x)))));
  vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize((_Globals_ScreenToCamera * tmpvar_17).xyz);
  vec3 tmpvar_19;
  tmpvar_19 = (_Ocean_CameraToOcean * tmpvar_18).xyz;
  if ((_Ocean_Radius == 0.0)) {
    t_16 = ((_Ocean_HeightOffset + -(_Ocean_CameraPos.z)) / tmpvar_19.z);
  } else {
    float tmpvar_20;
    tmpvar_20 = (tmpvar_19.z * (_Ocean_CameraPos.z + _Ocean_Radius));
    float tmpvar_21;
    tmpvar_21 = (-(tmpvar_20) - sqrt(max (((tmpvar_20 * tmpvar_20) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
    float tmpvar_22;
    tmpvar_22 = ((-(_Ocean_CameraPos.z) / tmpvar_19.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_19.z * tmpvar_19.z)))));
    float tmpvar_23;
    tmpvar_23 = abs(((tmpvar_22 - tmpvar_21) * tmpvar_19.z));
    float tmpvar_24;
    if ((tmpvar_23 < 1.0)) {
      tmpvar_24 = tmpvar_22;
    } else {
      tmpvar_24 = tmpvar_21;
    };
    t_16 = tmpvar_24;
  };
  vec2 tmpvar_25;
  tmpvar_25 = ((_Ocean_CameraPos.xy + (t_16 * tmpvar_19.xy)) - tmpvar_3);
  vec4 tmpvar_26;
  tmpvar_26.xzw = vec3(0.0, 0.0, 0.0);
  tmpvar_26.y = _Ocean_ScreenGridSize.y;
  vec4 vert_27;
  vert_27 = (vert_2 + tmpvar_26);
  float t_28;
  vec4 tmpvar_29;
  tmpvar_29.zw = vec2(0.0, 1.0);
  tmpvar_29.x = vert_27.x;
  tmpvar_29.y = min (vert_27.y, ((_Ocean_Horizon1.x + (_Ocean_Horizon1.y * vert_27.x)) - sqrt((_Ocean_Horizon2.x + ((_Ocean_Horizon2.y + (_Ocean_Horizon2.z * vert_27.x)) * vert_27.x)))));
  vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = normalize((_Globals_ScreenToCamera * tmpvar_29).xyz);
  vec3 tmpvar_31;
  tmpvar_31 = (_Ocean_CameraToOcean * tmpvar_30).xyz;
  if ((_Ocean_Radius == 0.0)) {
    t_28 = ((_Ocean_HeightOffset + -(_Ocean_CameraPos.z)) / tmpvar_31.z);
  } else {
    float tmpvar_32;
    tmpvar_32 = (tmpvar_31.z * (_Ocean_CameraPos.z + _Ocean_Radius));
    float tmpvar_33;
    tmpvar_33 = (-(tmpvar_32) - sqrt(max (((tmpvar_32 * tmpvar_32) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
    float tmpvar_34;
    tmpvar_34 = ((-(_Ocean_CameraPos.z) / tmpvar_31.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_31.z * tmpvar_31.z)))));
    float tmpvar_35;
    tmpvar_35 = abs(((tmpvar_34 - tmpvar_33) * tmpvar_31.z));
    float tmpvar_36;
    if ((tmpvar_35 < 1.0)) {
      tmpvar_36 = tmpvar_34;
    } else {
      tmpvar_36 = tmpvar_33;
    };
    t_28 = tmpvar_36;
  };
  vec2 tmpvar_37;
  tmpvar_37 = ((_Ocean_CameraPos.xy + (t_28 * tmpvar_31.xy)) - tmpvar_3);
  vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, 0.0);
  tmpvar_38.z = _Ocean_HeightOffset;
  dP_1 = tmpvar_38;
  if (((tmpvar_37.x != 0.0) || (tmpvar_37.y != 0.0))) {
    vec2 tmpvar_39;
    tmpvar_39 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.x));
    vec2 tmpvar_40;
    tmpvar_40 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.x));
    vec4 tmpvar_41;
    tmpvar_41.z = 0.0;
    tmpvar_41.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_41.w = (0.5 * log2(max (dot (tmpvar_39, tmpvar_39), dot (tmpvar_40, tmpvar_40))));
    dP_1.z = (_Ocean_HeightOffset + texture2DLod (_Ocean_Map0, tmpvar_41.xy, tmpvar_41.w).x);
    vec2 tmpvar_42;
    tmpvar_42 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.y));
    vec2 tmpvar_43;
    tmpvar_43 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.y));
    vec4 tmpvar_44;
    tmpvar_44.z = 0.0;
    tmpvar_44.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_44.w = (0.5 * log2(max (dot (tmpvar_42, tmpvar_42), dot (tmpvar_43, tmpvar_43))));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_44.xy, tmpvar_44.w).y);
    vec2 tmpvar_45;
    tmpvar_45 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.z));
    vec2 tmpvar_46;
    tmpvar_46 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.z));
    vec4 tmpvar_47;
    tmpvar_47.z = 0.0;
    tmpvar_47.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_47.w = (0.5 * log2(max (dot (tmpvar_45, tmpvar_45), dot (tmpvar_46, tmpvar_46))));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_47.xy, tmpvar_47.w).z);
    vec2 tmpvar_48;
    tmpvar_48 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.w));
    vec2 tmpvar_49;
    tmpvar_49 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.w));
    vec4 tmpvar_50;
    tmpvar_50.z = 0.0;
    tmpvar_50.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_50.w = (0.5 * log2(max (dot (tmpvar_48, tmpvar_48), dot (tmpvar_49, tmpvar_49))));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_50.xy, tmpvar_50.w).w);
    vec2 tmpvar_51;
    tmpvar_51 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.x));
    vec2 tmpvar_52;
    tmpvar_52 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.x));
    vec4 tmpvar_53;
    tmpvar_53.z = 0.0;
    tmpvar_53.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_53.w = (0.5 * log2(max (dot (tmpvar_51, tmpvar_51), dot (tmpvar_52, tmpvar_52))));
    dP_1.xy = (_Ocean_Choppyness.x * texture2DLod (_Ocean_Map3, tmpvar_53.xy, tmpvar_53.w).xy);
    vec2 tmpvar_54;
    tmpvar_54 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.y));
    vec2 tmpvar_55;
    tmpvar_55 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.y));
    vec4 tmpvar_56;
    tmpvar_56.z = 0.0;
    tmpvar_56.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_56.w = (0.5 * log2(max (dot (tmpvar_54, tmpvar_54), dot (tmpvar_55, tmpvar_55))));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.y * texture2DLod (_Ocean_Map3, tmpvar_56.xy, tmpvar_56.w).zw));
    vec2 tmpvar_57;
    tmpvar_57 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.z));
    vec2 tmpvar_58;
    tmpvar_58 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.z));
    vec4 tmpvar_59;
    tmpvar_59.z = 0.0;
    tmpvar_59.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_59.w = (0.5 * log2(max (dot (tmpvar_57, tmpvar_57), dot (tmpvar_58, tmpvar_58))));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.z * texture2DLod (_Ocean_Map4, tmpvar_59.xy, tmpvar_59.w).xy));
    vec2 tmpvar_60;
    tmpvar_60 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.w));
    vec2 tmpvar_61;
    tmpvar_61 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.w));
    vec4 tmpvar_62;
    tmpvar_62.z = 0.0;
    tmpvar_62.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_62.w = (0.5 * log2(max (dot (tmpvar_60, tmpvar_60), dot (tmpvar_61, tmpvar_61))));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.w * texture2DLod (_Ocean_Map4, tmpvar_62.xy, tmpvar_62.w).zw));
  };
  mat3 tmpvar_63;
  tmpvar_63[0] = _Ocean_OceanToCamera[0].xyz;
  tmpvar_63[1] = _Ocean_OceanToCamera[1].xyz;
  tmpvar_63[2] = _Ocean_OceanToCamera[2].xyz;
  vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = ((t_4 * tmpvar_6) + (tmpvar_63 * dP_1));
  vec3 tmpvar_65;
  tmpvar_65.xy = vec2(0.0, 0.0);
  tmpvar_65.z = _Ocean_CameraPos.z;
  gl_Position = (_Globals_CameraToScreen * tmpvar_64);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (((t_4 * tmpvar_8) + dP_1) + tmpvar_65);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform float _Exposure;
uniform float scale;
uniform float Rg;
uniform float Rt;
uniform float RES_R;
uniform float RES_MU;
uniform float RES_MU_S;
uniform float RES_NU;
uniform float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Irradiance;
uniform sampler2D _Sky_Inscatter;
uniform float _Ocean_Radius;
uniform vec3 _Ocean_CameraPos;
uniform vec3 _Ocean_SunDir;
uniform vec3 _Ocean_Color;
uniform vec4 _Ocean_GridSizes;
uniform float _Ocean_WhiteCapStr;
uniform float farWhiteCapStr;
uniform sampler3D _Ocean_Variance;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
uniform float _OceanAlpha;
uniform float alphaRadius;
uniform float sunReflectionMultiplier;
uniform float skyReflectionMultiplier;
uniform float seaRefractionMultiplier;
uniform vec2 _VarianceMax;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 surfaceColor_1;
  vec3 N_2;
  vec2 slopes_3;
  float outAlpha_4;
  vec3 tmpvar_5;
  tmpvar_5.xy = vec2(0.0, 0.0);
  tmpvar_5.z = (_Ocean_CameraPos.z + _Ocean_Radius);
  vec3 tmpvar_6;
  if ((_Ocean_Radius > 0.0)) {
    vec3 tmpvar_7;
    tmpvar_7.xy = vec2(0.0, 0.0);
    tmpvar_7.z = _Ocean_Radius;
    tmpvar_6 = (normalize((xlv_TEXCOORD1 + tmpvar_7)) * (_Ocean_Radius + 10.0));
  } else {
    tmpvar_6 = xlv_TEXCOORD1;
  };
  vec3 arg0_8;
  arg0_8 = (tmpvar_6 - tmpvar_5);
  float tmpvar_9;
  tmpvar_9 = clamp ((sqrt(dot (arg0_8, arg0_8)) / alphaRadius), 0.0, 1.0);
  outAlpha_4 = mix (_OceanAlpha, 1.0, tmpvar_9);
  float tmpvar_10;
  tmpvar_10 = mix (_Ocean_WhiteCapStr, farWhiteCapStr, tmpvar_9);
  vec3 tmpvar_11;
  tmpvar_11.xy = vec2(0.0, 0.0);
  tmpvar_11.z = _Ocean_CameraPos.z;
  vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 - xlv_TEXCOORD1));
  vec2 tmpvar_13;
  tmpvar_13 = (((texture2D (_Ocean_Map1, (xlv_TEXCOORD0 / _Ocean_GridSizes.x)).xy + texture2D (_Ocean_Map1, (xlv_TEXCOORD0 / _Ocean_GridSizes.y)).zw) + texture2D (_Ocean_Map2, (xlv_TEXCOORD0 / _Ocean_GridSizes.z)).xy) + texture2D (_Ocean_Map2, (xlv_TEXCOORD0 / _Ocean_GridSizes.w)).zw);
  slopes_3 = tmpvar_13;
  if ((_Ocean_Radius > 0.0)) {
    slopes_3 = (tmpvar_13 - (xlv_TEXCOORD1.xy / (_Ocean_Radius + xlv_TEXCOORD1.z)));
  };
  vec3 tmpvar_14;
  tmpvar_14.z = 1.0;
  tmpvar_14.x = -(slopes_3.x);
  tmpvar_14.y = -(slopes_3.y);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_14);
  N_2 = tmpvar_15;
  float tmpvar_16;
  tmpvar_16 = dot (tmpvar_12, tmpvar_15);
  if ((tmpvar_16 < 0.0)) {
    N_2 = (tmpvar_15 - (2.0 * (dot (tmpvar_12, tmpvar_15) * tmpvar_12)));
  };
  float tmpvar_17;
  tmpvar_17 = dFdx(xlv_TEXCOORD0.x);
  float tmpvar_18;
  tmpvar_18 = dFdy(xlv_TEXCOORD0.x);
  float tmpvar_19;
  tmpvar_19 = dFdx(xlv_TEXCOORD0.y);
  float tmpvar_20;
  tmpvar_20 = dFdy(xlv_TEXCOORD0.y);
  float tmpvar_21;
  tmpvar_21 = ((tmpvar_17 * tmpvar_17) + (tmpvar_19 * tmpvar_19));
  float tmpvar_22;
  tmpvar_22 = ((tmpvar_18 * tmpvar_18) + (tmpvar_20 * tmpvar_20));
  vec3 tmpvar_23;
  tmpvar_23.x = pow ((tmpvar_21 / 10.0), 0.25);
  tmpvar_23.y = (0.5 + ((0.5 * ((tmpvar_17 * tmpvar_18) + (tmpvar_19 * tmpvar_20))) / sqrt((tmpvar_21 * tmpvar_22))));
  tmpvar_23.z = pow ((tmpvar_22 / 10.0), 0.25);
  vec2 tmpvar_24;
  tmpvar_24 = max ((texture3D (_Ocean_Variance, tmpvar_23).xy * _VarianceMax), vec2(2e-05, 2e-05));
  vec3 worldP_25;
  float r_26;
  vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_6 * scale);
  worldP_25 = tmpvar_27;
  float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_27, tmpvar_27));
  r_26 = tmpvar_28;
  if ((tmpvar_28 < (0.9 * Rg))) {
    worldP_25.z = (tmpvar_27.z + Rg);
    r_26 = sqrt(dot (worldP_25, worldP_25));
  };
  vec3 tmpvar_29;
  tmpvar_29 = (worldP_25 / r_26);
  float tmpvar_30;
  tmpvar_30 = dot (tmpvar_29, _Ocean_SunDir);
  float tmpvar_31;
  tmpvar_31 = sqrt((1.0 - ((Rg / r_26) * (Rg / r_26))));
  vec3 tmpvar_32;
  if ((tmpvar_30 < -(tmpvar_31))) {
    tmpvar_32 = vec3(0.0, 0.0, 0.0);
  } else {
    float y_over_x_33;
    y_over_x_33 = (((tmpvar_30 + 0.15) / 1.15) * 14.1014);
    float x_34;
    x_34 = (y_over_x_33 * inversesqrt(((y_over_x_33 * y_over_x_33) + 1.0)));
    vec2 tmpvar_35;
    tmpvar_35.x = ((sign(x_34) * (1.5708 - (sqrt((1.0 - abs(x_34))) * (1.5708 + (abs(x_34) * (-0.214602 + (abs(x_34) * (0.0865667 + (abs(x_34) * -0.0310296))))))))) / 1.5);
    tmpvar_35.y = sqrt(((r_26 - Rg) / (Rt - Rg)));
    tmpvar_32 = texture2DLod (_Sky_Transmittance, tmpvar_35, 0.0).xyz;
  };
  vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_32 * _Sun_Intensity);
  vec2 tmpvar_37;
  tmpvar_37.x = ((tmpvar_30 + 0.2) / 1.2);
  tmpvar_37.y = ((r_26 - Rg) / (Rt - Rg));
  vec3 tmpvar_38;
  tmpvar_38 = ((2.0 * (texture2DLod (_Sky_Irradiance, tmpvar_37, 0.0).xyz * _Sun_Intensity)) * ((1.0 + dot (tmpvar_29, N_2)) * 0.5));
  float tmpvar_39;
  tmpvar_39 = sqrt(tmpvar_24.x);
  vec3 tmpvar_40;
  tmpvar_40 = (((pow ((1.0 - dot (tmpvar_12, N_2)), (5.0 * exp((-2.69 * tmpvar_39)))) / (1.0 + (22.7 * pow (tmpvar_39, 1.5)))) * tmpvar_38) / 3.14159);
  vec3 tmpvar_41;
  tmpvar_41 = normalize((_Ocean_SunDir + tmpvar_12));
  float tmpvar_42;
  tmpvar_42 = dot (tmpvar_41, N_2);
  float tmpvar_43;
  tmpvar_43 = (exp(((-2.0 * ((1.0 - (tmpvar_42 * tmpvar_42)) / tmpvar_24.x)) / (1.0 + tmpvar_42))) / (12.5664 * tmpvar_24.x));
  float tmpvar_44;
  tmpvar_44 = (1.0 - dot (tmpvar_12, tmpvar_41));
  float tmpvar_45;
  tmpvar_45 = (tmpvar_44 * tmpvar_44);
  float tmpvar_46;
  tmpvar_46 = (0.02 + (((0.98 * tmpvar_45) * tmpvar_45) * tmpvar_44));
  float tmpvar_47;
  tmpvar_47 = max (dot (_Ocean_SunDir, N_2), 0.01);
  float tmpvar_48;
  tmpvar_48 = max (dot (tmpvar_12, N_2), 0.01);
  float tmpvar_49;
  if ((tmpvar_47 <= 0.0)) {
    tmpvar_49 = 0.0;
  } else {
    tmpvar_49 = max (((tmpvar_46 * tmpvar_43) * sqrt(abs((tmpvar_47 / tmpvar_48)))), 0.0);
  };
  float tmpvar_50;
  tmpvar_50 = sqrt(tmpvar_24.x);
  vec4 tmpvar_51;
  tmpvar_51 = texture2D (_Ocean_Foam0, (xlv_TEXCOORD0 / _Ocean_GridSizes.x));
  vec4 tmpvar_52;
  tmpvar_52 = texture2D (_Ocean_Foam0, (xlv_TEXCOORD0 / _Ocean_GridSizes.y));
  vec4 tmpvar_53;
  tmpvar_53 = texture2D (_Ocean_Foam1, (xlv_TEXCOORD0 / _Ocean_GridSizes.z));
  vec4 tmpvar_54;
  tmpvar_54 = texture2D (_Ocean_Foam1, (xlv_TEXCOORD0 / _Ocean_GridSizes.w));
  vec2 tmpvar_55;
  tmpvar_55 = (((tmpvar_51.xy + tmpvar_52.zw) + tmpvar_53.xy) + tmpvar_54.zw);
  float x_56;
  x_56 = ((0.707107 * (tmpvar_10 - tmpvar_55.x)) * inversesqrt(max ((tmpvar_55.y - ((((tmpvar_51.x * tmpvar_51.x) + (tmpvar_52.z * tmpvar_52.z)) + (tmpvar_53.x * tmpvar_53.x)) + (tmpvar_54.z * tmpvar_54.z))), 0.0)));
  float tmpvar_57;
  tmpvar_57 = (x_56 * x_56);
  float tmpvar_58;
  tmpvar_58 = (0.140012 * tmpvar_57);
  surfaceColor_1 = ((((sunReflectionMultiplier * (tmpvar_49 * tmpvar_36)) + (skyReflectionMultiplier * tmpvar_40)) + (seaRefractionMultiplier * ((((0.98 * (1.0 - (pow ((1.0 - dot (tmpvar_12, N_2)), (5.0 * exp((-2.69 * tmpvar_50)))) / (1.0 + (22.7 * pow (tmpvar_50, 1.5)))))) * _Ocean_Color) * tmpvar_38) / 3.14159))) + ((((0.5 * (sign(x_56) * sqrt((1.0 - exp(((-(tmpvar_57) * (1.27324 + tmpvar_58)) / (1.0 + tmpvar_58))))))) + 0.5) * (((tmpvar_36 * max (dot (N_2, _Ocean_SunDir), 0.0)) + tmpvar_38) / 3.14159)) * 0.4));
  vec3 camera_59;
  vec3 _point_60;
  vec3 extinction_61;
  float mu_62;
  float rMu_63;
  float r_64;
  float d_65;
  vec3 tmpvar_66;
  tmpvar_66 = (tmpvar_5 * scale);
  camera_59 = tmpvar_66;
  vec3 tmpvar_67;
  tmpvar_67 = (tmpvar_6 * scale);
  _point_60 = tmpvar_67;
  vec3 tmpvar_68;
  tmpvar_68 = (tmpvar_67 - tmpvar_66);
  float tmpvar_69;
  tmpvar_69 = sqrt(dot (tmpvar_68, tmpvar_68));
  d_65 = tmpvar_69;
  vec3 tmpvar_70;
  tmpvar_70 = (tmpvar_68 / tmpvar_69);
  float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_66, tmpvar_66));
  r_64 = tmpvar_71;
  if ((tmpvar_71 < (0.9 * Rg))) {
    camera_59.z = (tmpvar_66.z + Rg);
    _point_60.z = (tmpvar_67.z + Rg);
    r_64 = sqrt(dot (camera_59, camera_59));
  };
  float tmpvar_72;
  tmpvar_72 = dot (camera_59, tmpvar_70);
  rMu_63 = tmpvar_72;
  mu_62 = (tmpvar_72 / r_64);
  vec3 tmpvar_73;
  tmpvar_73 = (_point_60 - (tmpvar_70 * clamp (0.0, 0.0, tmpvar_69)));
  _point_60 = tmpvar_73;
  float f_74;
  f_74 = (((tmpvar_72 * tmpvar_72) - (r_64 * r_64)) + (Rt * Rt));
  float tmpvar_75;
  if ((f_74 >= 0.0)) {
    tmpvar_75 = sqrt(f_74);
  } else {
    tmpvar_75 = 1e+30;
  };
  float tmpvar_76;
  tmpvar_76 = max ((-(tmpvar_72) - tmpvar_75), 0.0);
  if (((tmpvar_76 > 0.0) && (tmpvar_76 < tmpvar_69))) {
    camera_59 = (camera_59 + (tmpvar_76 * tmpvar_70));
    float tmpvar_77;
    tmpvar_77 = (tmpvar_72 + tmpvar_76);
    rMu_63 = tmpvar_77;
    mu_62 = (tmpvar_77 / Rt);
    r_64 = Rt;
    d_65 = (tmpvar_69 - tmpvar_76);
  };
  if ((r_64 <= Rt)) {
    float muS1_78;
    float mu1_79;
    float r1_80;
    vec4 inScatter_81;
    float tmpvar_82;
    tmpvar_82 = dot (tmpvar_70, _Ocean_SunDir);
    float tmpvar_83;
    tmpvar_83 = (dot (camera_59, _Ocean_SunDir) / r_64);
    if ((r_64 < (Rg + 2000.0))) {
      float tmpvar_84;
      tmpvar_84 = ((Rg + 2000.0) / r_64);
      r_64 = (r_64 * tmpvar_84);
      rMu_63 = (rMu_63 * tmpvar_84);
      _point_60 = (tmpvar_73 * tmpvar_84);
    };
    float tmpvar_85;
    tmpvar_85 = sqrt(dot (_point_60, _point_60));
    r1_80 = tmpvar_85;
    float tmpvar_86;
    tmpvar_86 = (dot (_point_60, tmpvar_70) / tmpvar_85);
    mu1_79 = tmpvar_86;
    muS1_78 = (dot (_point_60, _Ocean_SunDir) / tmpvar_85);
    if ((mu_62 > 0.0)) {
      float y_over_x_87;
      y_over_x_87 = (((mu_62 + 0.15) / 1.15) * 14.1014);
      float x_88;
      x_88 = (y_over_x_87 * inversesqrt(((y_over_x_87 * y_over_x_87) + 1.0)));
      vec2 tmpvar_89;
      tmpvar_89.x = ((sign(x_88) * (1.5708 - (sqrt((1.0 - abs(x_88))) * (1.5708 + (abs(x_88) * (-0.214602 + (abs(x_88) * (0.0865667 + (abs(x_88) * -0.0310296))))))))) / 1.5);
      tmpvar_89.y = sqrt(((r_64 - Rg) / (Rt - Rg)));
      float y_over_x_90;
      y_over_x_90 = (((tmpvar_86 + 0.15) / 1.15) * 14.1014);
      float x_91;
      x_91 = (y_over_x_90 * inversesqrt(((y_over_x_90 * y_over_x_90) + 1.0)));
      vec2 tmpvar_92;
      tmpvar_92.x = ((sign(x_91) * (1.5708 - (sqrt((1.0 - abs(x_91))) * (1.5708 + (abs(x_91) * (-0.214602 + (abs(x_91) * (0.0865667 + (abs(x_91) * -0.0310296))))))))) / 1.5);
      tmpvar_92.y = sqrt(((tmpvar_85 - Rg) / (Rt - Rg)));
      extinction_61 = min ((texture2DLod (_Sky_Transmittance, tmpvar_89, 0.0).xyz / texture2DLod (_Sky_Transmittance, tmpvar_92, 0.0).xyz), vec3(1.0, 1.0, 1.0));
    } else {
      float y_over_x_93;
      y_over_x_93 = (((-(tmpvar_86) + 0.15) / 1.15) * 14.1014);
      float x_94;
      x_94 = (y_over_x_93 * inversesqrt(((y_over_x_93 * y_over_x_93) + 1.0)));
      vec2 tmpvar_95;
      tmpvar_95.x = ((sign(x_94) * (1.5708 - (sqrt((1.0 - abs(x_94))) * (1.5708 + (abs(x_94) * (-0.214602 + (abs(x_94) * (0.0865667 + (abs(x_94) * -0.0310296))))))))) / 1.5);
      tmpvar_95.y = sqrt(((tmpvar_85 - Rg) / (Rt - Rg)));
      float y_over_x_96;
      y_over_x_96 = (((-(mu_62) + 0.15) / 1.15) * 14.1014);
      float x_97;
      x_97 = (y_over_x_96 * inversesqrt(((y_over_x_96 * y_over_x_96) + 1.0)));
      vec2 tmpvar_98;
      tmpvar_98.x = ((sign(x_97) * (1.5708 - (sqrt((1.0 - abs(x_97))) * (1.5708 + (abs(x_97) * (-0.214602 + (abs(x_97) * (0.0865667 + (abs(x_97) * -0.0310296))))))))) / 1.5);
      tmpvar_98.y = sqrt(((r_64 - Rg) / (Rt - Rg)));
      extinction_61 = min ((texture2DLod (_Sky_Transmittance, tmpvar_95, 0.0).xyz / texture2DLod (_Sky_Transmittance, tmpvar_98, 0.0).xyz), vec3(1.0, 1.0, 1.0));
    };
    float tmpvar_99;
    tmpvar_99 = -(sqrt((1.0 - ((Rg / r_64) * (Rg / r_64)))));
    float tmpvar_100;
    tmpvar_100 = abs((mu_62 - tmpvar_99));
    if ((tmpvar_100 < 0.004)) {
      vec4 inScatterA_101;
      vec4 inScatter0_102;
      float a_103;
      a_103 = (((mu_62 - tmpvar_99) + 0.004) / 0.008);
      float tmpvar_104;
      tmpvar_104 = (tmpvar_99 - 0.004);
      mu_62 = tmpvar_104;
      float tmpvar_105;
      tmpvar_105 = sqrt((((r_64 * r_64) + (d_65 * d_65)) + (((2.0 * r_64) * d_65) * tmpvar_104)));
      r1_80 = tmpvar_105;
      mu1_79 = (((r_64 * tmpvar_104) + d_65) / tmpvar_105);
      float uMu_106;
      float uR_107;
      float tmpvar_108;
      tmpvar_108 = sqrt(((Rt * Rt) - (Rg * Rg)));
      float tmpvar_109;
      tmpvar_109 = sqrt(((r_64 * r_64) - (Rg * Rg)));
      float tmpvar_110;
      tmpvar_110 = (r_64 * tmpvar_104);
      float tmpvar_111;
      tmpvar_111 = (((tmpvar_110 * tmpvar_110) - (r_64 * r_64)) + (Rg * Rg));
      vec4 tmpvar_112;
      if (((tmpvar_110 < 0.0) && (tmpvar_111 > 0.0))) {
        vec4 tmpvar_113;
        tmpvar_113.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_113.w = (0.5 - (0.5 / RES_MU));
        tmpvar_112 = tmpvar_113;
      } else {
        vec4 tmpvar_114;
        tmpvar_114.x = -1.0;
        tmpvar_114.y = (tmpvar_108 * tmpvar_108);
        tmpvar_114.z = tmpvar_108;
        tmpvar_114.w = (0.5 + (0.5 / RES_MU));
        tmpvar_112 = tmpvar_114;
      };
      uR_107 = ((0.5 / RES_R) + ((tmpvar_109 / tmpvar_108) * (1.0 - (1.0/(RES_R)))));
      uMu_106 = (tmpvar_112.w + ((((tmpvar_110 * tmpvar_112.x) + sqrt((tmpvar_111 + tmpvar_112.y))) / (tmpvar_109 + tmpvar_112.z)) * (0.5 - (1.0/(RES_MU)))));
      float y_over_x_115;
      y_over_x_115 = (max (tmpvar_83, -0.1975) * 5.34962);
      float x_116;
      x_116 = (y_over_x_115 * inversesqrt(((y_over_x_115 * y_over_x_115) + 1.0)));
      float tmpvar_117;
      tmpvar_117 = ((0.5 / RES_MU_S) + (((((sign(x_116) * (1.5708 - (sqrt((1.0 - abs(x_116))) * (1.5708 + (abs(x_116) * (-0.214602 + (abs(x_116) * (0.0865667 + (abs(x_116) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
      float tmpvar_118;
      tmpvar_118 = (((tmpvar_82 + 1.0) / 2.0) * (RES_NU - 1.0));
      float tmpvar_119;
      tmpvar_119 = floor(tmpvar_118);
      float tmpvar_120;
      tmpvar_120 = (tmpvar_118 - tmpvar_119);
      float tmpvar_121;
      tmpvar_121 = (floor(((uR_107 * RES_R) - 1.0)) / RES_R);
      float tmpvar_122;
      tmpvar_122 = (floor((uR_107 * RES_R)) / RES_R);
      float tmpvar_123;
      tmpvar_123 = fract((uR_107 * RES_R));
      vec4 tmpvar_124;
      tmpvar_124.zw = vec2(0.0, 0.0);
      tmpvar_124.x = ((tmpvar_119 + tmpvar_117) / RES_NU);
      tmpvar_124.y = ((uMu_106 / RES_R) + tmpvar_121);
      vec4 tmpvar_125;
      tmpvar_125.zw = vec2(0.0, 0.0);
      tmpvar_125.x = (((tmpvar_119 + tmpvar_117) + 1.0) / RES_NU);
      tmpvar_125.y = ((uMu_106 / RES_R) + tmpvar_121);
      vec4 tmpvar_126;
      tmpvar_126.zw = vec2(0.0, 0.0);
      tmpvar_126.x = ((tmpvar_119 + tmpvar_117) / RES_NU);
      tmpvar_126.y = ((uMu_106 / RES_R) + tmpvar_122);
      vec4 tmpvar_127;
      tmpvar_127.zw = vec2(0.0, 0.0);
      tmpvar_127.x = (((tmpvar_119 + tmpvar_117) + 1.0) / RES_NU);
      tmpvar_127.y = ((uMu_106 / RES_R) + tmpvar_122);
      inScatter0_102 = ((((texture2DLod (_Sky_Inscatter, tmpvar_124.xy, 0.0) * (1.0 - tmpvar_120)) + (texture2DLod (_Sky_Inscatter, tmpvar_125.xy, 0.0) * tmpvar_120)) * (1.0 - tmpvar_123)) + (((texture2DLod (_Sky_Inscatter, tmpvar_126.xy, 0.0) * (1.0 - tmpvar_120)) + (texture2DLod (_Sky_Inscatter, tmpvar_127.xy, 0.0) * tmpvar_120)) * tmpvar_123));
      float uMu_128;
      float uR_129;
      float tmpvar_130;
      tmpvar_130 = sqrt(((Rt * Rt) - (Rg * Rg)));
      float tmpvar_131;
      tmpvar_131 = sqrt(((tmpvar_105 * tmpvar_105) - (Rg * Rg)));
      float tmpvar_132;
      tmpvar_132 = (tmpvar_105 * mu1_79);
      float tmpvar_133;
      tmpvar_133 = (((tmpvar_132 * tmpvar_132) - (tmpvar_105 * tmpvar_105)) + (Rg * Rg));
      vec4 tmpvar_134;
      if (((tmpvar_132 < 0.0) && (tmpvar_133 > 0.0))) {
        vec4 tmpvar_135;
        tmpvar_135.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_135.w = (0.5 - (0.5 / RES_MU));
        tmpvar_134 = tmpvar_135;
      } else {
        vec4 tmpvar_136;
        tmpvar_136.x = -1.0;
        tmpvar_136.y = (tmpvar_130 * tmpvar_130);
        tmpvar_136.z = tmpvar_130;
        tmpvar_136.w = (0.5 + (0.5 / RES_MU));
        tmpvar_134 = tmpvar_136;
      };
      uR_129 = ((0.5 / RES_R) + ((tmpvar_131 / tmpvar_130) * (1.0 - (1.0/(RES_R)))));
      uMu_128 = (tmpvar_134.w + ((((tmpvar_132 * tmpvar_134.x) + sqrt((tmpvar_133 + tmpvar_134.y))) / (tmpvar_131 + tmpvar_134.z)) * (0.5 - (1.0/(RES_MU)))));
      float y_over_x_137;
      y_over_x_137 = (max (muS1_78, -0.1975) * 5.34962);
      float x_138;
      x_138 = (y_over_x_137 * inversesqrt(((y_over_x_137 * y_over_x_137) + 1.0)));
      float tmpvar_139;
      tmpvar_139 = ((0.5 / RES_MU_S) + (((((sign(x_138) * (1.5708 - (sqrt((1.0 - abs(x_138))) * (1.5708 + (abs(x_138) * (-0.214602 + (abs(x_138) * (0.0865667 + (abs(x_138) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
      float tmpvar_140;
      tmpvar_140 = (((tmpvar_82 + 1.0) / 2.0) * (RES_NU - 1.0));
      float tmpvar_141;
      tmpvar_141 = floor(tmpvar_140);
      float tmpvar_142;
      tmpvar_142 = (tmpvar_140 - tmpvar_141);
      float tmpvar_143;
      tmpvar_143 = (floor(((uR_129 * RES_R) - 1.0)) / RES_R);
      float tmpvar_144;
      tmpvar_144 = (floor((uR_129 * RES_R)) / RES_R);
      float tmpvar_145;
      tmpvar_145 = fract((uR_129 * RES_R));
      vec4 tmpvar_146;
      tmpvar_146.zw = vec2(0.0, 0.0);
      tmpvar_146.x = ((tmpvar_141 + tmpvar_139) / RES_NU);
      tmpvar_146.y = ((uMu_128 / RES_R) + tmpvar_143);
      vec4 tmpvar_147;
      tmpvar_147.zw = vec2(0.0, 0.0);
      tmpvar_147.x = (((tmpvar_141 + tmpvar_139) + 1.0) / RES_NU);
      tmpvar_147.y = ((uMu_128 / RES_R) + tmpvar_143);
      vec4 tmpvar_148;
      tmpvar_148.zw = vec2(0.0, 0.0);
      tmpvar_148.x = ((tmpvar_141 + tmpvar_139) / RES_NU);
      tmpvar_148.y = ((uMu_128 / RES_R) + tmpvar_144);
      vec4 tmpvar_149;
      tmpvar_149.zw = vec2(0.0, 0.0);
      tmpvar_149.x = (((tmpvar_141 + tmpvar_139) + 1.0) / RES_NU);
      tmpvar_149.y = ((uMu_128 / RES_R) + tmpvar_144);
      inScatterA_101 = max ((inScatter0_102 - (((((texture2DLod (_Sky_Inscatter, tmpvar_146.xy, 0.0) * (1.0 - tmpvar_142)) + (texture2DLod (_Sky_Inscatter, tmpvar_147.xy, 0.0) * tmpvar_142)) * (1.0 - tmpvar_145)) + (((texture2DLod (_Sky_Inscatter, tmpvar_148.xy, 0.0) * (1.0 - tmpvar_142)) + (texture2DLod (_Sky_Inscatter, tmpvar_149.xy, 0.0) * tmpvar_142)) * tmpvar_145)) * extinction_61.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      float tmpvar_150;
      tmpvar_150 = (tmpvar_99 + 0.004);
      mu_62 = tmpvar_150;
      float tmpvar_151;
      tmpvar_151 = sqrt((((r_64 * r_64) + (d_65 * d_65)) + (((2.0 * r_64) * d_65) * tmpvar_150)));
      r1_80 = tmpvar_151;
      mu1_79 = (((r_64 * tmpvar_150) + d_65) / tmpvar_151);
      float uMu_152;
      float uR_153;
      float tmpvar_154;
      tmpvar_154 = sqrt(((Rt * Rt) - (Rg * Rg)));
      float tmpvar_155;
      tmpvar_155 = sqrt(((r_64 * r_64) - (Rg * Rg)));
      float tmpvar_156;
      tmpvar_156 = (r_64 * tmpvar_150);
      float tmpvar_157;
      tmpvar_157 = (((tmpvar_156 * tmpvar_156) - (r_64 * r_64)) + (Rg * Rg));
      vec4 tmpvar_158;
      if (((tmpvar_156 < 0.0) && (tmpvar_157 > 0.0))) {
        vec4 tmpvar_159;
        tmpvar_159.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_159.w = (0.5 - (0.5 / RES_MU));
        tmpvar_158 = tmpvar_159;
      } else {
        vec4 tmpvar_160;
        tmpvar_160.x = -1.0;
        tmpvar_160.y = (tmpvar_154 * tmpvar_154);
        tmpvar_160.z = tmpvar_154;
        tmpvar_160.w = (0.5 + (0.5 / RES_MU));
        tmpvar_158 = tmpvar_160;
      };
      uR_153 = ((0.5 / RES_R) + ((tmpvar_155 / tmpvar_154) * (1.0 - (1.0/(RES_R)))));
      uMu_152 = (tmpvar_158.w + ((((tmpvar_156 * tmpvar_158.x) + sqrt((tmpvar_157 + tmpvar_158.y))) / (tmpvar_155 + tmpvar_158.z)) * (0.5 - (1.0/(RES_MU)))));
      float y_over_x_161;
      y_over_x_161 = (max (tmpvar_83, -0.1975) * 5.34962);
      float x_162;
      x_162 = (y_over_x_161 * inversesqrt(((y_over_x_161 * y_over_x_161) + 1.0)));
      float tmpvar_163;
      tmpvar_163 = ((0.5 / RES_MU_S) + (((((sign(x_162) * (1.5708 - (sqrt((1.0 - abs(x_162))) * (1.5708 + (abs(x_162) * (-0.214602 + (abs(x_162) * (0.0865667 + (abs(x_162) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
      float tmpvar_164;
      tmpvar_164 = (((tmpvar_82 + 1.0) / 2.0) * (RES_NU - 1.0));
      float tmpvar_165;
      tmpvar_165 = floor(tmpvar_164);
      float tmpvar_166;
      tmpvar_166 = (tmpvar_164 - tmpvar_165);
      float tmpvar_167;
      tmpvar_167 = (floor(((uR_153 * RES_R) - 1.0)) / RES_R);
      float tmpvar_168;
      tmpvar_168 = (floor((uR_153 * RES_R)) / RES_R);
      float tmpvar_169;
      tmpvar_169 = fract((uR_153 * RES_R));
      vec4 tmpvar_170;
      tmpvar_170.zw = vec2(0.0, 0.0);
      tmpvar_170.x = ((tmpvar_165 + tmpvar_163) / RES_NU);
      tmpvar_170.y = ((uMu_152 / RES_R) + tmpvar_167);
      vec4 tmpvar_171;
      tmpvar_171.zw = vec2(0.0, 0.0);
      tmpvar_171.x = (((tmpvar_165 + tmpvar_163) + 1.0) / RES_NU);
      tmpvar_171.y = ((uMu_152 / RES_R) + tmpvar_167);
      vec4 tmpvar_172;
      tmpvar_172.zw = vec2(0.0, 0.0);
      tmpvar_172.x = ((tmpvar_165 + tmpvar_163) / RES_NU);
      tmpvar_172.y = ((uMu_152 / RES_R) + tmpvar_168);
      vec4 tmpvar_173;
      tmpvar_173.zw = vec2(0.0, 0.0);
      tmpvar_173.x = (((tmpvar_165 + tmpvar_163) + 1.0) / RES_NU);
      tmpvar_173.y = ((uMu_152 / RES_R) + tmpvar_168);
      inScatter0_102 = ((((texture2DLod (_Sky_Inscatter, tmpvar_170.xy, 0.0) * (1.0 - tmpvar_166)) + (texture2DLod (_Sky_Inscatter, tmpvar_171.xy, 0.0) * tmpvar_166)) * (1.0 - tmpvar_169)) + (((texture2DLod (_Sky_Inscatter, tmpvar_172.xy, 0.0) * (1.0 - tmpvar_166)) + (texture2DLod (_Sky_Inscatter, tmpvar_173.xy, 0.0) * tmpvar_166)) * tmpvar_169));
      float uMu_174;
      float uR_175;
      float tmpvar_176;
      tmpvar_176 = sqrt(((Rt * Rt) - (Rg * Rg)));
      float tmpvar_177;
      tmpvar_177 = sqrt(((tmpvar_151 * tmpvar_151) - (Rg * Rg)));
      float tmpvar_178;
      tmpvar_178 = (tmpvar_151 * mu1_79);
      float tmpvar_179;
      tmpvar_179 = (((tmpvar_178 * tmpvar_178) - (tmpvar_151 * tmpvar_151)) + (Rg * Rg));
      vec4 tmpvar_180;
      if (((tmpvar_178 < 0.0) && (tmpvar_179 > 0.0))) {
        vec4 tmpvar_181;
        tmpvar_181.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_181.w = (0.5 - (0.5 / RES_MU));
        tmpvar_180 = tmpvar_181;
      } else {
        vec4 tmpvar_182;
        tmpvar_182.x = -1.0;
        tmpvar_182.y = (tmpvar_176 * tmpvar_176);
        tmpvar_182.z = tmpvar_176;
        tmpvar_182.w = (0.5 + (0.5 / RES_MU));
        tmpvar_180 = tmpvar_182;
      };
      uR_175 = ((0.5 / RES_R) + ((tmpvar_177 / tmpvar_176) * (1.0 - (1.0/(RES_R)))));
      uMu_174 = (tmpvar_180.w + ((((tmpvar_178 * tmpvar_180.x) + sqrt((tmpvar_179 + tmpvar_180.y))) / (tmpvar_177 + tmpvar_180.z)) * (0.5 - (1.0/(RES_MU)))));
      float y_over_x_183;
      y_over_x_183 = (max (muS1_78, -0.1975) * 5.34962);
      float x_184;
      x_184 = (y_over_x_183 * inversesqrt(((y_over_x_183 * y_over_x_183) + 1.0)));
      float tmpvar_185;
      tmpvar_185 = ((0.5 / RES_MU_S) + (((((sign(x_184) * (1.5708 - (sqrt((1.0 - abs(x_184))) * (1.5708 + (abs(x_184) * (-0.214602 + (abs(x_184) * (0.0865667 + (abs(x_184) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
      float tmpvar_186;
      tmpvar_186 = (((tmpvar_82 + 1.0) / 2.0) * (RES_NU - 1.0));
      float tmpvar_187;
      tmpvar_187 = floor(tmpvar_186);
      float tmpvar_188;
      tmpvar_188 = (tmpvar_186 - tmpvar_187);
      float tmpvar_189;
      tmpvar_189 = (floor(((uR_175 * RES_R) - 1.0)) / RES_R);
      float tmpvar_190;
      tmpvar_190 = (floor((uR_175 * RES_R)) / RES_R);
      float tmpvar_191;
      tmpvar_191 = fract((uR_175 * RES_R));
      vec4 tmpvar_192;
      tmpvar_192.zw = vec2(0.0, 0.0);
      tmpvar_192.x = ((tmpvar_187 + tmpvar_185) / RES_NU);
      tmpvar_192.y = ((uMu_174 / RES_R) + tmpvar_189);
      vec4 tmpvar_193;
      tmpvar_193.zw = vec2(0.0, 0.0);
      tmpvar_193.x = (((tmpvar_187 + tmpvar_185) + 1.0) / RES_NU);
      tmpvar_193.y = ((uMu_174 / RES_R) + tmpvar_189);
      vec4 tmpvar_194;
      tmpvar_194.zw = vec2(0.0, 0.0);
      tmpvar_194.x = ((tmpvar_187 + tmpvar_185) / RES_NU);
      tmpvar_194.y = ((uMu_174 / RES_R) + tmpvar_190);
      vec4 tmpvar_195;
      tmpvar_195.zw = vec2(0.0, 0.0);
      tmpvar_195.x = (((tmpvar_187 + tmpvar_185) + 1.0) / RES_NU);
      tmpvar_195.y = ((uMu_174 / RES_R) + tmpvar_190);
      inScatter_81 = mix (inScatterA_101, max ((inScatter0_102 - (((((texture2DLod (_Sky_Inscatter, tmpvar_192.xy, 0.0) * (1.0 - tmpvar_188)) + (texture2DLod (_Sky_Inscatter, tmpvar_193.xy, 0.0) * tmpvar_188)) * (1.0 - tmpvar_191)) + (((texture2DLod (_Sky_Inscatter, tmpvar_194.xy, 0.0) * (1.0 - tmpvar_188)) + (texture2DLod (_Sky_Inscatter, tmpvar_195.xy, 0.0) * tmpvar_188)) * tmpvar_191)) * extinction_61.xyzx)), vec4(0.0, 0.0, 0.0, 0.0)), vec4(a_103));
    } else {
      vec4 inScatter0_1_196;
      float uMu_197;
      float uR_198;
      float tmpvar_199;
      tmpvar_199 = sqrt(((Rt * Rt) - (Rg * Rg)));
      float tmpvar_200;
      tmpvar_200 = sqrt(((r_64 * r_64) - (Rg * Rg)));
      float tmpvar_201;
      tmpvar_201 = (r_64 * mu_62);
      float tmpvar_202;
      tmpvar_202 = (((tmpvar_201 * tmpvar_201) - (r_64 * r_64)) + (Rg * Rg));
      vec4 tmpvar_203;
      if (((tmpvar_201 < 0.0) && (tmpvar_202 > 0.0))) {
        vec4 tmpvar_204;
        tmpvar_204.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_204.w = (0.5 - (0.5 / RES_MU));
        tmpvar_203 = tmpvar_204;
      } else {
        vec4 tmpvar_205;
        tmpvar_205.x = -1.0;
        tmpvar_205.y = (tmpvar_199 * tmpvar_199);
        tmpvar_205.z = tmpvar_199;
        tmpvar_205.w = (0.5 + (0.5 / RES_MU));
        tmpvar_203 = tmpvar_205;
      };
      uR_198 = ((0.5 / RES_R) + ((tmpvar_200 / tmpvar_199) * (1.0 - (1.0/(RES_R)))));
      uMu_197 = (tmpvar_203.w + ((((tmpvar_201 * tmpvar_203.x) + sqrt((tmpvar_202 + tmpvar_203.y))) / (tmpvar_200 + tmpvar_203.z)) * (0.5 - (1.0/(RES_MU)))));
      float y_over_x_206;
      y_over_x_206 = (max (tmpvar_83, -0.1975) * 5.34962);
      float x_207;
      x_207 = (y_over_x_206 * inversesqrt(((y_over_x_206 * y_over_x_206) + 1.0)));
      float tmpvar_208;
      tmpvar_208 = ((0.5 / RES_MU_S) + (((((sign(x_207) * (1.5708 - (sqrt((1.0 - abs(x_207))) * (1.5708 + (abs(x_207) * (-0.214602 + (abs(x_207) * (0.0865667 + (abs(x_207) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
      float tmpvar_209;
      tmpvar_209 = (((tmpvar_82 + 1.0) / 2.0) * (RES_NU - 1.0));
      float tmpvar_210;
      tmpvar_210 = floor(tmpvar_209);
      float tmpvar_211;
      tmpvar_211 = (tmpvar_209 - tmpvar_210);
      float tmpvar_212;
      tmpvar_212 = (floor(((uR_198 * RES_R) - 1.0)) / RES_R);
      float tmpvar_213;
      tmpvar_213 = (floor((uR_198 * RES_R)) / RES_R);
      float tmpvar_214;
      tmpvar_214 = fract((uR_198 * RES_R));
      vec4 tmpvar_215;
      tmpvar_215.zw = vec2(0.0, 0.0);
      tmpvar_215.x = ((tmpvar_210 + tmpvar_208) / RES_NU);
      tmpvar_215.y = ((uMu_197 / RES_R) + tmpvar_212);
      vec4 tmpvar_216;
      tmpvar_216.zw = vec2(0.0, 0.0);
      tmpvar_216.x = (((tmpvar_210 + tmpvar_208) + 1.0) / RES_NU);
      tmpvar_216.y = ((uMu_197 / RES_R) + tmpvar_212);
      vec4 tmpvar_217;
      tmpvar_217.zw = vec2(0.0, 0.0);
      tmpvar_217.x = ((tmpvar_210 + tmpvar_208) / RES_NU);
      tmpvar_217.y = ((uMu_197 / RES_R) + tmpvar_213);
      vec4 tmpvar_218;
      tmpvar_218.zw = vec2(0.0, 0.0);
      tmpvar_218.x = (((tmpvar_210 + tmpvar_208) + 1.0) / RES_NU);
      tmpvar_218.y = ((uMu_197 / RES_R) + tmpvar_213);
      inScatter0_1_196 = ((((texture2DLod (_Sky_Inscatter, tmpvar_215.xy, 0.0) * (1.0 - tmpvar_211)) + (texture2DLod (_Sky_Inscatter, tmpvar_216.xy, 0.0) * tmpvar_211)) * (1.0 - tmpvar_214)) + (((texture2DLod (_Sky_Inscatter, tmpvar_217.xy, 0.0) * (1.0 - tmpvar_211)) + (texture2DLod (_Sky_Inscatter, tmpvar_218.xy, 0.0) * tmpvar_211)) * tmpvar_214));
      float uMu_219;
      float uR_220;
      float tmpvar_221;
      tmpvar_221 = sqrt(((Rt * Rt) - (Rg * Rg)));
      float tmpvar_222;
      tmpvar_222 = sqrt(((r1_80 * r1_80) - (Rg * Rg)));
      float tmpvar_223;
      tmpvar_223 = (r1_80 * mu1_79);
      float tmpvar_224;
      tmpvar_224 = (((tmpvar_223 * tmpvar_223) - (r1_80 * r1_80)) + (Rg * Rg));
      vec4 tmpvar_225;
      if (((tmpvar_223 < 0.0) && (tmpvar_224 > 0.0))) {
        vec4 tmpvar_226;
        tmpvar_226.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_226.w = (0.5 - (0.5 / RES_MU));
        tmpvar_225 = tmpvar_226;
      } else {
        vec4 tmpvar_227;
        tmpvar_227.x = -1.0;
        tmpvar_227.y = (tmpvar_221 * tmpvar_221);
        tmpvar_227.z = tmpvar_221;
        tmpvar_227.w = (0.5 + (0.5 / RES_MU));
        tmpvar_225 = tmpvar_227;
      };
      uR_220 = ((0.5 / RES_R) + ((tmpvar_222 / tmpvar_221) * (1.0 - (1.0/(RES_R)))));
      uMu_219 = (tmpvar_225.w + ((((tmpvar_223 * tmpvar_225.x) + sqrt((tmpvar_224 + tmpvar_225.y))) / (tmpvar_222 + tmpvar_225.z)) * (0.5 - (1.0/(RES_MU)))));
      float y_over_x_228;
      y_over_x_228 = (max (muS1_78, -0.1975) * 5.34962);
      float x_229;
      x_229 = (y_over_x_228 * inversesqrt(((y_over_x_228 * y_over_x_228) + 1.0)));
      float tmpvar_230;
      tmpvar_230 = ((0.5 / RES_MU_S) + (((((sign(x_229) * (1.5708 - (sqrt((1.0 - abs(x_229))) * (1.5708 + (abs(x_229) * (-0.214602 + (abs(x_229) * (0.0865667 + (abs(x_229) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
      float tmpvar_231;
      tmpvar_231 = (((tmpvar_82 + 1.0) / 2.0) * (RES_NU - 1.0));
      float tmpvar_232;
      tmpvar_232 = floor(tmpvar_231);
      float tmpvar_233;
      tmpvar_233 = (tmpvar_231 - tmpvar_232);
      float tmpvar_234;
      tmpvar_234 = (floor(((uR_220 * RES_R) - 1.0)) / RES_R);
      float tmpvar_235;
      tmpvar_235 = (floor((uR_220 * RES_R)) / RES_R);
      float tmpvar_236;
      tmpvar_236 = fract((uR_220 * RES_R));
      vec4 tmpvar_237;
      tmpvar_237.zw = vec2(0.0, 0.0);
      tmpvar_237.x = ((tmpvar_232 + tmpvar_230) / RES_NU);
      tmpvar_237.y = ((uMu_219 / RES_R) + tmpvar_234);
      vec4 tmpvar_238;
      tmpvar_238.zw = vec2(0.0, 0.0);
      tmpvar_238.x = (((tmpvar_232 + tmpvar_230) + 1.0) / RES_NU);
      tmpvar_238.y = ((uMu_219 / RES_R) + tmpvar_234);
      vec4 tmpvar_239;
      tmpvar_239.zw = vec2(0.0, 0.0);
      tmpvar_239.x = ((tmpvar_232 + tmpvar_230) / RES_NU);
      tmpvar_239.y = ((uMu_219 / RES_R) + tmpvar_235);
      vec4 tmpvar_240;
      tmpvar_240.zw = vec2(0.0, 0.0);
      tmpvar_240.x = (((tmpvar_232 + tmpvar_230) + 1.0) / RES_NU);
      tmpvar_240.y = ((uMu_219 / RES_R) + tmpvar_235);
      inScatter_81 = max ((inScatter0_1_196 - (((((texture2DLod (_Sky_Inscatter, tmpvar_237.xy, 0.0) * (1.0 - tmpvar_233)) + (texture2DLod (_Sky_Inscatter, tmpvar_238.xy, 0.0) * tmpvar_233)) * (1.0 - tmpvar_236)) + (((texture2DLod (_Sky_Inscatter, tmpvar_239.xy, 0.0) * (1.0 - tmpvar_233)) + (texture2DLod (_Sky_Inscatter, tmpvar_240.xy, 0.0) * tmpvar_233)) * tmpvar_236)) * extinction_61.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
    };
    float t_241;
    t_241 = max (min ((tmpvar_83 / 0.02), 1.0), 0.0);
    inScatter_81.w = (inScatter_81.w * (t_241 * (t_241 * (3.0 - (2.0 * t_241)))));
  } else {
    extinction_61 = vec3(1.0, 1.0, 1.0);
  };
  vec3 L_242;
  vec3 tmpvar_243;
  tmpvar_243 = ((surfaceColor_1 * extinction_61) * _Exposure);
  L_242 = tmpvar_243;
  float tmpvar_244;
  if ((tmpvar_243.x < 1.413)) {
    tmpvar_244 = pow ((tmpvar_243.x * 0.38317), 0.454545);
  } else {
    tmpvar_244 = (1.0 - exp(-(tmpvar_243.x)));
  };
  L_242.x = tmpvar_244;
  float tmpvar_245;
  if ((tmpvar_243.y < 1.413)) {
    tmpvar_245 = pow ((tmpvar_243.y * 0.38317), 0.454545);
  } else {
    tmpvar_245 = (1.0 - exp(-(tmpvar_243.y)));
  };
  L_242.y = tmpvar_245;
  float tmpvar_246;
  if ((tmpvar_243.z < 1.413)) {
    tmpvar_246 = pow ((tmpvar_243.z * 0.38317), 0.454545);
  } else {
    tmpvar_246 = (1.0 - exp(-(tmpvar_243.z)));
  };
  L_242.z = tmpvar_246;
  vec4 tmpvar_247;
  tmpvar_247.xyz = L_242;
  tmpvar_247.w = outAlpha_4;
  gl_FragData[0] = tmpvar_247;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 286 math, 16 textures, 7 branches
Bind "vertex" Vertex
Matrix 0 [_Ocean_OceanToCamera]
Matrix 4 [_Ocean_CameraToOcean]
Matrix 8 [_Globals_ScreenToCamera]
Matrix 12 [_Globals_CameraToScreen]
Float 16 [_Ocean_Radius]
Vector 17 [_Ocean_Horizon1]
Vector 18 [_Ocean_Horizon2]
Float 19 [_Ocean_HeightOffset]
Vector 20 [_Ocean_CameraPos]
Vector 21 [_Ocean_MapSize]
Vector 22 [_Ocean_Choppyness]
Vector 23 [_Ocean_GridSizes]
Vector 24 [_Ocean_ScreenGridSize]
SetTexture 0 [_Ocean_Map0] 2D 0
SetTexture 1 [_Ocean_Map3] 2D 1
SetTexture 2 [_Ocean_Map4] 2D 2
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c25, 1.25000000, 0.00000000, 1.00000000, 2.00000000
def c26, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_2d s0
dcl_2d s1
dcl_2d s2
mul r4.xy, v0, c25.x
mad r0.x, r4, c18.z, c18.y
mad r0.x, r4, r0, c18
rsq r0.x, r0.x
rcp r0.y, r0.x
mad r0.x, r4, c17.y, c17
add r0.x, r0, -r0.y
min r1.y, r4, r0.x
mov r1.zw, c25.xyyz
mov r1.x, r4
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mov r0.xyz, r1
mov r0.w, c25.y
dp4 r2.z, r0, c6
dp4 r2.y, r0, c5
mov r1.w, c25.y
dp4 r2.x, r0, c4
if_eq c16.x, r1.w
mov r0.x, c19
rcp r0.y, r2.z
add r0.x, -c20.z, r0
mul r1.w, r0.x, r0.y
else
mov r0.x, c16
mul r0.y, c25.w, r0.x
add r0.z, r0.y, c20
mov r0.x, c20.z
add r0.x, c16, r0
rcp r0.y, r0.y
mul r0.x, r2.z, r0
mul r0.z, r0, c20
mad r0.z, r0.x, r0.x, -r0
max r0.z, r0, c25.y
rsq r0.z, r0.z
rcp r0.z, r0.z
add r0.w, -r0.x, -r0.z
rcp r0.x, r2.z
mad r0.z, -r2, r2, c25
mul r0.y, r0, c20.z
mad r0.y, r0, r0.z, c25.z
mul r0.x, r0, -c20.z
mul r0.x, r0, r0.y
add r0.y, r0.x, -r0.w
mul r0.y, r0, r2.z
abs r0.y, r0
slt r0.y, r0, c25.z
max r0.y, -r0, r0
slt r0.y, c25, r0
add r0.z, -r0.y, c25
mul r0.z, r0.w, r0
mad r1.w, r0.y, r0.x, r0.z
endif
mov r0.y, c25
mov r0.x, c24
add r0.xy, r4, r0
mad r0.z, r0.x, c18, c18.y
mad r0.z, r0.x, r0, c18.x
rsq r0.z, r0.z
rcp r0.w, r0.z
mad r0.z, r0.x, c17.y, c17.x
add r0.z, r0, -r0.w
min r0.y, r0, r0.z
mov r0.zw, c25.xyyz
dp4 r3.z, r0, c10
dp4 r3.x, r0, c8
dp4 r3.y, r0, c9
dp3 r0.x, r3, r3
rsq r0.x, r0.x
mul r0.xyz, r0.x, r3
mov r0.w, c25.y
dp4 r3.z, r0, c6
dp4 r3.y, r0, c5
dp4 r3.x, r0, c4
mov r0.x, c25.y
mad r7.xy, r1.w, r2, c20
if_eq c16.x, r0.x
mov r0.x, c19
rcp r0.y, r3.z
add r0.x, -c20.z, r0
mul r2.w, r0.x, r0.y
else
mov r0.x, c16
mul r0.z, c25.w, r0.x
add r0.y, r0.z, c20.z
mov r0.x, c20.z
add r0.x, c16, r0
rcp r0.z, r0.z
mul r0.x, r3.z, r0
mul r0.y, r0, c20.z
mad r0.y, r0.x, r0.x, -r0
max r0.y, r0, c25
rsq r0.y, r0.y
rcp r0.y, r0.y
add r0.x, -r0, -r0.y
rcp r0.y, r3.z
mad r0.w, -r3.z, r3.z, c25.z
mul r0.z, r0, c20
mad r0.z, r0, r0.w, c25
mul r0.y, r0, -c20.z
mul r0.y, r0, r0.z
add r0.z, r0.y, -r0.x
mul r0.z, r0, r3
abs r0.z, r0
slt r0.z, r0, c25
max r0.z, -r0, r0
slt r0.z, c25.y, r0
add r0.w, -r0.z, c25.z
mul r0.x, r0, r0.w
mad r2.w, r0.z, r0.y, r0.x
endif
mov r0.y, c24
mov r0.x, c25.y
add r0.xy, r4, r0
mad r0.z, r0.x, c18, c18.y
mad r0.z, r0.x, r0, c18.x
rsq r0.z, r0.z
rcp r0.w, r0.z
mad r0.z, r0.x, c17.y, c17.x
add r0.z, r0, -r0.w
min r0.y, r0, r0.z
mov r0.zw, c25.xyyz
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
dp3 r0.x, r4, r4
rsq r0.x, r0.x
mul r0.xyz, r0.x, r4
mov r0.w, c25.y
dp4 r4.z, r0, c6
dp4 r4.y, r0, c5
dp4 r4.x, r0, c4
mad r0.xy, r2.w, r3, c20
mov r0.z, c25.y
add r3.zw, r0.xyxy, -r7.xyxy
if_eq c16.x, r0.z
mov r0.x, c19
rcp r0.y, r4.z
add r0.x, -c20.z, r0
mul r0.x, r0, r0.y
else
mov r0.x, c16
mul r0.z, c25.w, r0.x
add r0.y, r0.z, c20.z
mov r0.x, c20.z
add r0.x, c16, r0
rcp r0.z, r0.z
mul r0.x, r4.z, r0
mul r0.y, r0, c20.z
mad r0.y, r0.x, r0.x, -r0
max r0.y, r0, c25
rsq r0.y, r0.y
rcp r0.y, r0.y
add r0.x, -r0, -r0.y
rcp r0.y, r4.z
mad r0.w, -r4.z, r4.z, c25.z
mul r0.z, r0, c20
mad r0.z, r0, r0.w, c25
mul r0.y, r0, -c20.z
mul r0.y, r0, r0.z
add r0.z, r0.y, -r0.x
mul r0.z, r0, r4
abs r0.z, r0
slt r0.z, r0, c25
max r0.z, -r0, r0
slt r0.z, c25.y, r0
add r0.w, -r0.z, c25.z
mul r0.x, r0, r0.w
mad r0.x, r0.z, r0.y, r0
endif
mad r0.xy, r0.x, r4, c20
add r5.xy, r0, -r7
slt r0.y, r0, r7
slt r0.z, c25.y, r5.y
add r0.z, r0.y, r0
slt r0.y, c25, r5.x
slt r0.x, r0, r7
add r0.x, r0, r0.y
add_sat r0.x, r0, r0.z
mov r4.xy, c25.y
mov r4.z, c19.x
if_gt r0.x, c25.y
rcp r2.w, c23.x
rcp r4.w, c23.y
mul r0.zw, r5.xyxy, r2.w
mul r0.xy, r3.zwzw, r2.w
mul r0.zw, r0, c21.y
mul r0.zw, r0, r0
mul r0.xy, r0, c21.x
mul r0.xy, r0, r0
add r0.x, r0, r0.y
add r0.z, r0, r0.w
max r0.x, r0, r0.z
log r3.x, r0.x
mul r0.zw, r5.xyxy, r4.w
mul r0.xy, r3.zwzw, r4.w
mul r0.zw, r0, c21.y
mul r0.zw, r0, r0
mul r0.xy, r0, c21.x
mul r0.xy, r0, r0
add r0.z, r0, r0.w
add r0.x, r0, r0.y
max r0.w, r0.x, r0.z
mul r0.xy, r7, r2.w
mul r0.z, r3.x, c26.x
texldl r3.xy, r0.xyzz, s1
texldl r0.x, r0.xyzz, s0
log r0.w, r0.w
mul r6.z, r0.w, c26.x
mul r6.xy, r7, r4.w
rcp r0.w, c23.z
mad r3.xy, r3, c22.x, r4
mul r4.xy, r3.zwzw, r0.w
rcp r2.w, c23.w
texldl r5.zw, r6.xyzz, s1
mad r3.xy, r5.zwzw, c22.y, r3
mul r5.zw, r5.xyxy, r0.w
mul r4.xy, r4, c21.x
mul r4.xy, r4, r4
mul r5.zw, r5, c21.y
mul r3.zw, r3, r2.w
mul r3.zw, r3, c21.x
mul r3.zw, r3, r3
add r4.x, r4, r4.y
mul r5.zw, r5, r5
add r4.y, r5.z, r5.w
max r4.w, r4.x, r4.y
mul r4.xy, r5, r2.w
add r3.z, r3, r3.w
mul r4.xy, r4, c21.y
mul r4.xy, r4, r4
add r4.x, r4, r4.y
max r3.z, r3, r4.x
log r3.w, r4.w
log r3.z, r3.z
mul r5.xy, r7, r0.w
mul r5.z, r3.w, c26.x
texldl r4.xy, r5.xyzz, s2
mad r4.xy, r4, c22.z, r3
mul r3.z, r3, c26.x
mul r3.xy, r7, r2.w
texldl r7.zw, r3.xyzz, s2
add r0.x, r4.z, r0
texldl r0.y, r6.xyzz, s0
add r0.x, r0, r0.y
texldl r0.z, r5.xyzz, s0
texldl r0.w, r3.xyzz, s0
add r0.x, r0, r0.z
mad r4.xy, r7.zwzw, c22.w, r4
add r4.z, r0.x, r0.w
endif
mov r0.w, c25.z
dp3 r0.z, r4, c2
dp3 r0.y, r4, c1
dp3 r0.x, r4, c0
mad r0.xyz, r1.w, r1, r0
dp4 o0.w, r0, c15
dp4 o0.z, r0, c14
dp4 o0.y, r0, c13
dp4 o0.x, r0, c12
mad r1.xyz, r1.w, r2, r4
mov r0.z, c20
mov r0.xy, c25.y
add o2.xyz, r1, r0
mov o1.xy, r7
"
}
SubProgram "d3d11 " {
// Stats: 149 math, 2 branches
Bind "vertex" Vertex
SetTexture 0 [_Ocean_Map0] 2D 0
SetTexture 1 [_Ocean_Map3] 2D 1
SetTexture 2 [_Ocean_Map4] 2D 2
ConstBuffer "$Globals" 720
Matrix 192 [_Ocean_OceanToCamera]
Matrix 256 [_Ocean_CameraToOcean]
Matrix 320 [_Globals_ScreenToCamera]
Matrix 512 [_Globals_CameraToScreen]
Float 132 [_Ocean_Radius]
Vector 144 [_Ocean_Horizon1] 3
Vector 160 [_Ocean_Horizon2] 3
Float 172 [_Ocean_HeightOffset]
Vector 176 [_Ocean_CameraPos] 3
Vector 592 [_Ocean_MapSize] 2
Vector 608 [_Ocean_Choppyness]
Vector 656 [_Ocean_GridSizes]
Vector 672 [_Ocean_ScreenGridSize] 2
BindCB  "$Globals" 0
"vs_4_0
eefiecedcgpomonkcjkllgljdemkcpaikkckpkbeabaaaaaakabhaaaaadaaaaaa
cmaaaaaakaaaaaaabaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapadaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefciibgaaaaeaaaabaakcafaaaa
fjaaaaaeegiocaaaaaaaaaaaclaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafpaaaaaddcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacajaaaaaa
diaaaaakdcaabaaaaaaaaaaaegbabaaaaaaaaaaaaceaaaaaaaaakadpaaaakadp
aaaaaaaaaaaaaaaadcaaaaalecaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaadcaaaaalicaabaaaaaaaaaaa
ckiacaaaaaaaaaaaakaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaa
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaakaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaddaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaabfaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaabeaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaabhaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaa
egiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaa
baaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaaaaaaaaabcaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaabiaaaaai
ecaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaaaaaaaaaak
icaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaackiacaiaebaaaaaaaaaaaaaa
alaaaaaaaoaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaa
aaaaaaajicaabaaaacaaaaaabkiacaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaa
alaaaaaadiaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aaaaaaajccaabaaaadaaaaaabkiacaaaaaaaaaaaaiaaaaaabkiacaaaaaaaaaaa
aiaaaaaadcaaaaalecaabaaaadaaaaaabkiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaaaeackiacaaaaaaaaaaaalaaaaaadiaaaaaiecaabaaaadaaaaaackaabaaa
adaaaaaackiacaaaaaaaaaaaalaaaaaadcaaaaakbcaabaaaadaaaaaaakaabaaa
adaaaaaaakaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaadeaaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaaadaaaaaa
akaabaaaadaaaaaadcaaaaalbcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaa
dkaabaaaacaaaaaaakaabaiaebaaaaaaadaaaaaaaoaaaaajicaabaaaadaaaaaa
ckiacaiaebaaaaaaaaaaaaaaalaaaaaackaabaaaacaaaaaaaoaaaaaiccaabaaa
adaaaaaackiacaaaaaaaaaaaalaaaaaabkaabaaaadaaaaaadcaaaaakbcaabaaa
aeaaaaaackaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadp
dcaaaaajbcaabaaaaeaaaaaabkaabaaaadaaaaaaakaabaaaaeaaaaaaabeaaaaa
aaaaiadpdiaaaaahccaabaaaaeaaaaaadkaabaaaadaaaaaaakaabaaaaeaaaaaa
dcaaaaakicaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaaaeaaaaaaakaabaia
ebaaaaaaadaaaaaadiaaaaahicaabaaaadaaaaaackaabaaaacaaaaaadkaabaaa
adaaaaaadbaaaaaiicaabaaaadaaaaaadkaabaiaibaaaaaaadaaaaaaabeaaaaa
aaaaiadpdhaaaaajbcaabaaaadaaaaaadkaabaaaadaaaaaabkaabaaaaeaaaaaa
akaabaaaadaaaaaadhaaaaajicaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaaakaabaaaadaaaaaadcaaaaakjcaabaaaadaaaaaapgapbaaaabaaaaaa
agaebaaaacaaaaaaagiecaaaaaaaaaaaalaaaaaadcaaaaakbcaabaaaaeaaaaaa
bkbabaaaaaaaaaaaabeaaaaaaaaakadpbkiacaaaaaaaaaaackaaaaaadcaaaaal
ccaabaaaaeaaaaaabkiacaaaaaaaaaaaajaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaajaaaaaadcaaaaalecaabaaaaeaaaaaackiacaaaaaaaaaaaakaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaadcaaaaakecaabaaaaeaaaaaa
ckaabaaaaeaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaakaaaaaaelaaaaaf
ecaabaaaaeaaaaaackaabaaaaeaaaaaaaaaaaaaiccaabaaaaeaaaaaackaabaia
ebaaaaaaaeaaaaaabkaabaaaaeaaaaaaddaaaaahbcaabaaaaeaaaaaabkaabaaa
aeaaaaaaakaabaaaaeaaaaaadiaaaaaihcaabaaaaeaaaaaaagaabaaaaeaaaaaa
egiccaaaaaaaaaaabfaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaaaaaaaaa
beaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaaaaaaaaaihcaabaaaaeaaaaaa
egacbaaaaeaaaaaaegiccaaaaaaaaaaabhaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaeaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaa
diaaaaaihcaabaaaafaaaaaafgafbaaaaeaaaaaaegiccaaaaaaaaaaabbaaaaaa
dcaaaaaklcaabaaaaeaaaaaaegiicaaaaaaaaaaabaaaaaaaagaabaaaaeaaaaaa
egaibaaaafaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaaaaaaaaabcaaaaaa
kgakbaaaaeaaaaaaegadbaaaaeaaaaaaaoaaaaahbcaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaaeaaaaaadiaaaaahicaabaaaaeaaaaaadkaabaaaacaaaaaa
ckaabaaaaeaaaaaadcaaaaakicaabaaaaeaaaaaadkaabaaaaeaaaaaadkaabaaa
aeaaaaaackaabaiaebaaaaaaadaaaaaadeaaaaahicaabaaaaeaaaaaadkaabaaa
aeaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaaeaaaaaadkaabaaaaeaaaaaa
dcaaaaalicaabaaaaeaaaaaackaabaiaebaaaaaaaeaaaaaadkaabaaaacaaaaaa
dkaabaiaebaaaaaaaeaaaaaaaoaaaaajbcaabaaaafaaaaaackiacaiaebaaaaaa
aaaaaaaaalaaaaaackaabaaaaeaaaaaadcaaaaakccaabaaaafaaaaaackaabaia
ebaaaaaaaeaaaaaackaabaaaaeaaaaaaabeaaaaaaaaaiadpdcaaaaajccaabaaa
afaaaaaabkaabaaaadaaaaaabkaabaaaafaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaafaaaaaabkaabaaaafaaaaaaakaabaaaafaaaaaadcaaaaakbcaabaaa
afaaaaaaakaabaaaafaaaaaabkaabaaaafaaaaaadkaabaiaebaaaaaaaeaaaaaa
diaaaaahecaabaaaaeaaaaaackaabaaaaeaaaaaaakaabaaaafaaaaaadbaaaaai
ecaabaaaaeaaaaaackaabaiaibaaaaaaaeaaaaaaabeaaaaaaaaaiadpdhaaaaaj
ecaabaaaaeaaaaaackaabaaaaeaaaaaackaabaaaafaaaaaadkaabaaaaeaaaaaa
dhaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aeaaaaaadcaaaaakpcaabaaaaeaaaaaaagaabaaaaaaaaaaaegaebaaaaeaaaaaa
egiecaaaaaaaaaaaalaaaaaaaaaaaaaipcaabaaaaeaaaaaamgambaiaebaaaaaa
adaaaaaaegaobaaaaeaaaaaadjaaaaakdcaabaaaafaaaaaaogakbaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadmaaaaahbcaabaaaaaaaaaaa
bkaabaaaafaaaaaaakaabaaaafaaaaaabpaaaeadakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakbabaaaaaaaaaaaabeaaaaaaaaakadpakiacaaaaaaaaaaa
ckaaaaaadcaaaaalbcaabaaaafaaaaaabkiacaaaaaaaaaaaajaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaajaaaaaadcaaaaalccaabaaaafaaaaaackiacaaa
aaaaaaaaakaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaadcaaaaak
ccaabaaaafaaaaaabkaabaaaafaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
akaaaaaaelaaaaafccaabaaaafaaaaaabkaabaaaafaaaaaaaaaaaaaibcaabaaa
afaaaaaabkaabaiaebaaaaaaafaaaaaaakaabaaaafaaaaaaddaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaafaaaaaadiaaaaaihcaabaaaafaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaabfaaaaaadcaaaaakhcaabaaaafaaaaaa
egiccaaaaaaaaaaabeaaaaaaagaabaaaaaaaaaaaegacbaaaafaaaaaaaaaaaaai
hcaabaaaafaaaaaaegacbaaaafaaaaaaegiccaaaaaaaaaaabhaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaafaaaaaaagaabaaaaaaaaaaa
egacbaaaafaaaaaadiaaaaaihcaabaaaagaaaaaafgafbaaaafaaaaaaegiccaaa
aaaaaaaabbaaaaaadcaaaaaklcaabaaaafaaaaaaegiicaaaaaaaaaaabaaaaaaa
agaabaaaafaaaaaaegaibaaaagaaaaaadcaaaaakhcaabaaaafaaaaaaegiccaaa
aaaaaaaabcaaaaaakgakbaaaafaaaaaaegadbaaaafaaaaaaaoaaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaafaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaacaaaaaackaabaaaafaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaiaebaaaaaaadaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaackaabaiaebaaaaaaafaaaaaa
dkaabaaaacaaaaaabkaabaiaebaaaaaaaaaaaaaaaoaaaaajicaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaalaaaaaackaabaaaafaaaaaadcaaaaakicaabaaa
acaaaaaackaabaiaebaaaaaaafaaaaaackaabaaaafaaaaaaabeaaaaaaaaaiadp
dcaaaaajicaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpdiaaaaahccaabaaaadaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaa
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaabkaabaia
ebaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaaafaaaaaadkaabaaa
aaaaaaaadbaaaaaiicaabaaaaaaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdhaaaaajccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaadaaaaaa
bkaabaaaaaaaaaaadhaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaebaaaafaaaaaaegiecaaaaaaaaaaaalaaaaaaaaaaaaaipcaabaaaaaaaaaaa
mgambaiaebaaaaaaadaaaaaaegaobaaaaaaaaaaaaoaaaaaipcaabaaaafaaaaaa
mgambaaaadaaaaaaagifcaaaaaaaaaaacjaaaaaaaoaaaaaipcaabaaaagaaaaaa
ogaobaaaaaaaaaaaagifcaaaaaaaaaaacjaaaaaaaoaaaaaipcaabaaaahaaaaaa
ogaobaaaaeaaaaaaagifcaaaaaaaaaaacjaaaaaadiaaaaaipcaabaaaagaaaaaa
egaobaaaagaaaaaaagiacaaaaaaaaaaacfaaaaaadiaaaaaipcaabaaaahaaaaaa
egaobaaaahaaaaaafgifcaaaaaaaaaaacfaaaaaaapaaaaahicaabaaaacaaaaaa
egaabaaaagaaaaaaegaabaaaagaaaaaaapaaaaahccaabaaaadaaaaaaegaabaaa
ahaaaaaaegaabaaaahaaaaaadeaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
bkaabaaaadaaaaaacpaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaadpeiaaaaalpcaabaaa
aiaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadkaabaaa
acaaaaaaaaaaaaaiccaabaaaadaaaaaaakaabaaaaiaaaaaadkiacaaaaaaaaaaa
akaaaaaaapaaaaahecaabaaaadaaaaaaogakbaaaagaaaaaaogakbaaaagaaaaaa
apaaaaahbcaabaaaagaaaaaaogakbaaaahaaaaaaogakbaaaahaaaaaadeaaaaah
ecaabaaaadaaaaaackaabaaaadaaaaaaakaabaaaagaaaaaacpaaaaafecaabaaa
adaaaaaackaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaackaabaaaadaaaaaa
abeaaaaaaaaaaadpeiaaaaalpcaabaaaagaaaaaaogakbaaaafaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaackaabaaaadaaaaaaaaaaaaahccaabaaaadaaaaaa
bkaabaaaadaaaaaabkaabaaaagaaaaaaaoaaaaaipcaabaaaagaaaaaamgambaaa
adaaaaaakgipcaaaaaaaaaaacjaaaaaaaoaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaakgipcaaaaaaaaaaacjaaaaaaaoaaaaaipcaabaaaaeaaaaaaegaobaaa
aeaaaaaakgipcaaaaaaaaaaacjaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaagiacaaaaaaaaaaacfaaaaaadiaaaaaipcaabaaaaeaaaaaaegaobaaa
aeaaaaaafgifcaaaaaaaaaaacfaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegaabaaaaaaaaaaaapaaaaahccaabaaaaaaaaaaaegaabaaaaeaaaaaa
egaabaaaaeaaaaaadeaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpeiaaaaalpcaabaaaahaaaaaa
egaabaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaadaaaaaackaabaaaahaaaaaaapaaaaah
ecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaogakbaaaaeaaaaaaogakbaaaaeaaaaaadeaaaaahecaabaaaaaaaaaaa
dkaabaaaaaaaaaaackaabaaaaaaaaaaacpaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadp
eiaaaaalpcaabaaaaeaaaaaaogakbaaaagaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaahecaabaaaaeaaaaaabkaabaaaaaaaaaaa
dkaabaaaaeaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadkaabaaaacaaaaaaeiaaaaalpcaabaaaafaaaaaa
ogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaackaabaaaadaaaaaa
diaaaaaikcaabaaaaaaaaaaakgaobaaaafaaaaaafgifcaaaaaaaaaaacgaaaaaa
dcaaaaakkcaabaaaaaaaaaaaagiacaaaaaaaaaaacgaaaaaaagaebaaaahaaaaaa
fganbaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaaegaabaaaagaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaakaabaaaaaaaaaaadcaaaaakdcaabaaaaaaaaaaa
kgikcaaaaaaaaaaacgaaaaaaegaabaaaafaaaaaangafbaaaaaaaaaaaeiaaaaal
pcaabaaaafaaaaaaogakbaaaagaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
ckaabaaaaaaaaaaadcaaaaakdcaabaaaaeaaaaaapgipcaaaaaaaaaaacgaaaaaa
ogakbaaaafaaaaaaegaabaaaaaaaaaaabcaaaaabdgaaaaafbcaabaaaaaaaaaaa
abeaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaa
dgaaaaafhcaabaaaaeaaaaaaagacbaaaaaaaaaaabfaaaaabdiaaaaaihcaabaaa
aaaaaaaafgafbaaaaeaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaamaaaaaaagaabaaaaeaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgakbaaaaeaaaaaa
egacbaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaadgaaaaafbcaabaaaacaaaaaaabeaaaaa
aaaaaaaadgaaaaagecaabaaaacaaaaaackiacaaaaaaaaaaaalaaaaaaaaaaaaah
hccabaaaacaaaaaaegacbaaaabaaaaaaagacbaaaacaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaacbaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaacaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaccaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaacdaaaaaadgaaaaafdccabaaaabaaaaaamgaabaaaadaaaaaadoaaaaab
"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal (normalize(_glesNormal))
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLod( s, coord.xy, coord.w);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 221
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 275
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 271
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 126
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
};
#line 60
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
};
#line 16
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 21
uniform highp vec3 _WorldSpaceCameraPos;
#line 27
uniform highp vec4 _ProjectionParams;
#line 33
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
#line 40
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 53
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 58
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
#line 63
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
#line 69
uniform highp vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 73
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 77
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 83
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 90
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 94
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 110
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 122
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
#line 133
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 149
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 173
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
#line 182
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 48
uniform lowp vec4 unity_ColorSpaceGrey;
#line 89
#line 104
#line 119
#line 125
#line 143
#line 175
#line 192
#line 227
#line 238
#line 248
#line 256
#line 280
#line 286
#line 296
#line 305
#line 312
#line 321
#line 329
#line 338
#line 357
#line 363
#line 376
#line 387
#line 392
#line 418
#line 434
#line 447
#line 3
uniform highp float _Exposure;
#line 7
#line 14
uniform highp float scale;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RL;
#line 22
uniform highp float HR;
uniform highp vec3 betaR;
#line 26
uniform highp float HM;
uniform highp vec3 betaMSca;
uniform highp vec3 betaMEx;
uniform highp float mieG;
#line 35
uniform highp float TRANSMITTANCE_W;
uniform highp float TRANSMITTANCE_H;
uniform highp float SKY_W;
#line 39
uniform highp float SKY_H;
uniform highp float RES_R;
uniform highp float RES_MU;
#line 43
uniform highp float RES_MU_S;
uniform highp float RES_NU;
#line 55
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Irradiance;
#line 59
uniform sampler2D _Sky_Inscatter;
#line 71
#line 95
#line 109
#line 203
#line 226
#line 263
#line 276
#line 282
#line 288
#line 293
#line 308
#line 321
#line 391
#line 459
#line 486
#line 33
#line 37
#line 42
#line 70
#line 87
#line 91
#line 99
#line 103
#line 29
uniform highp float _Ocean_Radius;
uniform highp vec3 _Ocean_Horizon1;
uniform highp vec3 _Ocean_Horizon2;
uniform highp float _Ocean_HeightOffset;
#line 33
uniform highp vec3 _Ocean_CameraPos;
uniform highp mat4 _Ocean_OceanToCamera;
uniform highp mat4 _Ocean_CameraToOcean;
#line 37
#line 67
#line 75
#line 90
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_WorldToScreen;
uniform highp mat4 _Globals_CameraToScreen;
#line 94
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec2 _Ocean_MapSize;
uniform highp vec4 _Ocean_Choppyness;
#line 98
uniform highp vec3 _Ocean_SunDir;
uniform highp vec3 _Ocean_Color;
uniform highp vec4 _Ocean_GridSizes;
uniform highp vec2 _Ocean_ScreenGridSize;
#line 102
uniform highp float _Ocean_WhiteCapStr;
uniform highp float farWhiteCapStr;
uniform lowp sampler3D _Ocean_Variance;
#line 106
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
uniform sampler2D _Ocean_Map3;
#line 110
uniform sampler2D _Ocean_Map4;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
#line 114
uniform highp float _OceanAlpha;
uniform highp float alphaRadius;
uniform highp float sunReflectionMultiplier;
#line 118
uniform highp float skyReflectionMultiplier;
uniform highp float seaRefractionMultiplier;
#line 122
uniform highp vec2 _VarianceMax;
uniform sampler2D _Sky_Map;
#line 133
#line 175
#line 37
highp vec2 OceanPos( in highp vec4 vert, in highp mat4 stoc, out highp float t, out highp vec3 cameraDir, out highp vec3 oceanDir ) {
    highp float horizon = (_Ocean_Horizon1.x + (_Ocean_Horizon1.y * vert.x));
    #line 41
    horizon -= sqrt((_Ocean_Horizon2.x + ((_Ocean_Horizon2.y + (_Ocean_Horizon2.z * vert.x)) * vert.x)));
    highp vec4 v = vec4( vert.x, min( vert.y, horizon), 0.0, 1.0);
    #line 45
    cameraDir = normalize((stoc * v).xyz);
    oceanDir = (_Ocean_CameraToOcean * vec4( cameraDir, 0.0)).xyz;
    highp float cz = _Ocean_CameraPos.z;
    #line 49
    highp float dz = oceanDir.z;
    highp float radius = _Ocean_Radius;
    if ((radius == 0.0)){
        #line 53
        t = ((_Ocean_HeightOffset + (-cz)) / dz);
    }
    else{
        #line 57
        highp float b = (dz * (cz + radius));
        highp float c = (cz * (cz + (2.0 * radius)));
        highp float tSphere = ((-b) - sqrt(max( ((b * b) - c), 0.0)));
        highp float tApprox = (((-cz) / dz) * (1.0 + ((cz / (2.0 * radius)) * (1.0 - (dz * dz)))));
        #line 61
        t = (( (abs(((tApprox - tSphere) * dz)) < 1.0) ) ? ( tApprox ) : ( tSphere ));
    }
    return (_Ocean_CameraPos.xy + (t * oceanDir.xy));
}
#line 67
highp vec2 OceanPos( in highp vec4 vert, in highp mat4 stoc ) {
    highp float t;
    highp vec3 cameraDir;
    #line 71
    highp vec3 oceanDir;
    return OceanPos( vert, stoc, t, cameraDir, oceanDir);
}
#line 75
highp vec4 Tex2DGrad( in sampler2D tex, in highp vec2 uv, in highp vec2 dx, in highp vec2 dy, in highp vec2 texSize ) {
    #line 79
    highp vec2 px = (texSize.x * dx);
    highp vec2 py = (texSize.y * dy);
    highp float lod = (0.5 * log2(max( dot( px, px), dot( py, py))));
    return xll_tex2Dlod( tex, vec4( uv, 0.0, lod));
}
#line 133
v2f vert( in appdata_base v ) {
    highp float t;
    highp vec3 cameraDir;
    highp vec3 oceanDir;
    #line 138
    highp vec4 vert = v.vertex;
    vert.xy *= 1.25;
    highp vec2 u = OceanPos( vert, _Globals_ScreenToCamera, t, cameraDir, oceanDir);
    #line 142
    highp vec2 dux = (OceanPos( (vert + vec4( _Ocean_ScreenGridSize.x, 0.0, 0.0, 0.0)), _Globals_ScreenToCamera) - u);
    highp vec2 duy = (OceanPos( (vert + vec4( 0.0, _Ocean_ScreenGridSize.y, 0.0, 0.0)), _Globals_ScreenToCamera) - u);
    highp vec3 dP = vec3( 0.0, 0.0, _Ocean_HeightOffset);
    #line 146
    if (((duy.x != 0.0) || (duy.y != 0.0))){
        highp vec4 GRID_SIZES = _Ocean_GridSizes;
        highp vec4 CHOPPYNESS = _Ocean_Choppyness;
        #line 151
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.x), (dux / GRID_SIZES.x), (duy / GRID_SIZES.x), _Ocean_MapSize).x;
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.y), (dux / GRID_SIZES.y), (duy / GRID_SIZES.y), _Ocean_MapSize).y;
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.z), (dux / GRID_SIZES.z), (duy / GRID_SIZES.z), _Ocean_MapSize).z;
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.w), (dux / GRID_SIZES.w), (duy / GRID_SIZES.w), _Ocean_MapSize).w;
        #line 156
        dP.xy += (CHOPPYNESS.x * Tex2DGrad( _Ocean_Map3, (u / GRID_SIZES.x), (dux / GRID_SIZES.x), (duy / GRID_SIZES.x), _Ocean_MapSize).xy);
        dP.xy += (CHOPPYNESS.y * Tex2DGrad( _Ocean_Map3, (u / GRID_SIZES.y), (dux / GRID_SIZES.y), (duy / GRID_SIZES.y), _Ocean_MapSize).zw);
        dP.xy += (CHOPPYNESS.z * Tex2DGrad( _Ocean_Map4, (u / GRID_SIZES.z), (dux / GRID_SIZES.z), (duy / GRID_SIZES.z), _Ocean_MapSize).xy);
        dP.xy += (CHOPPYNESS.w * Tex2DGrad( _Ocean_Map4, (u / GRID_SIZES.w), (dux / GRID_SIZES.w), (duy / GRID_SIZES.w), _Ocean_MapSize).zw);
    }
    #line 162
    v2f OUT;
    highp mat3 otoc = xll_constructMat3_mf4x4( _Ocean_OceanToCamera);
    highp vec4 screenP = vec4( ((t * cameraDir) + (otoc * dP)), 1.0);
    #line 166
    highp vec3 oceanP = (((t * oceanDir) + dP) + vec3( 0.0, 0.0, _Ocean_CameraPos.z));
    OUT.pos = (_Globals_CameraToScreen * screenP);
    OUT.oceanU = u;
    #line 170
    OUT.oceanP = oceanP;
    return OUT;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata_base xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.oceanU);
    xlv_TEXCOORD1 = vec3(xl_retval.oceanP);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:131(2): warning: empty declaration
0:65(2): warning: empty declaration
0:105(39): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
*/


#endif
#ifdef FRAGMENT

#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#extension GL_EXT_shader_texture_lod : require
#extension GL_OES_standard_derivatives : require
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLodEXT( s, coord.xy, coord.w);
}
#line 221
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 275
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 271
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 126
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
};
#line 60
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
};
#line 16
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 21
uniform highp vec3 _WorldSpaceCameraPos;
#line 27
uniform highp vec4 _ProjectionParams;
#line 33
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
#line 40
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 53
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 58
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
#line 63
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
#line 69
uniform highp vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 73
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 77
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 83
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 90
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 94
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 110
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 122
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
#line 133
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 149
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 173
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
#line 182
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 48
uniform lowp vec4 unity_ColorSpaceGrey;
#line 89
#line 104
#line 119
#line 125
#line 143
#line 175
#line 192
#line 227
#line 238
#line 248
#line 256
#line 280
#line 286
#line 296
#line 305
#line 312
#line 321
#line 329
#line 338
#line 357
#line 363
#line 376
#line 387
#line 392
#line 418
#line 434
#line 447
#line 3
uniform highp float _Exposure;
#line 7
#line 14
uniform highp float scale;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RL;
#line 22
uniform highp float HR;
uniform highp vec3 betaR;
#line 26
uniform highp float HM;
uniform highp vec3 betaMSca;
uniform highp vec3 betaMEx;
uniform highp float mieG;
#line 35
uniform highp float TRANSMITTANCE_W;
uniform highp float TRANSMITTANCE_H;
uniform highp float SKY_W;
#line 39
uniform highp float SKY_H;
uniform highp float RES_R;
uniform highp float RES_MU;
#line 43
uniform highp float RES_MU_S;
uniform highp float RES_NU;
#line 55
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Irradiance;
#line 59
uniform sampler2D _Sky_Inscatter;
#line 71
#line 95
#line 109
#line 203
#line 226
#line 263
#line 276
#line 282
#line 288
#line 293
#line 308
#line 321
#line 391
#line 459
#line 486
#line 33
#line 37
#line 42
#line 70
#line 87
#line 91
#line 99
#line 103
#line 29
uniform highp float _Ocean_Radius;
uniform highp vec3 _Ocean_Horizon1;
uniform highp vec3 _Ocean_Horizon2;
uniform highp float _Ocean_HeightOffset;
#line 33
uniform highp vec3 _Ocean_CameraPos;
uniform highp mat4 _Ocean_OceanToCamera;
uniform highp mat4 _Ocean_CameraToOcean;
#line 37
#line 67
#line 75
#line 90
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_WorldToScreen;
uniform highp mat4 _Globals_CameraToScreen;
#line 94
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec2 _Ocean_MapSize;
uniform highp vec4 _Ocean_Choppyness;
#line 98
uniform highp vec3 _Ocean_SunDir;
uniform highp vec3 _Ocean_Color;
uniform highp vec4 _Ocean_GridSizes;
uniform highp vec2 _Ocean_ScreenGridSize;
#line 102
uniform highp float _Ocean_WhiteCapStr;
uniform highp float farWhiteCapStr;
uniform lowp sampler3D _Ocean_Variance;
#line 106
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
uniform sampler2D _Ocean_Map3;
#line 110
uniform sampler2D _Ocean_Map4;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
#line 114
uniform highp float _OceanAlpha;
uniform highp float alphaRadius;
uniform highp float sunReflectionMultiplier;
#line 118
uniform highp float skyReflectionMultiplier;
uniform highp float seaRefractionMultiplier;
#line 122
uniform highp vec2 _VarianceMax;
uniform sampler2D _Sky_Map;
#line 133
#line 175
#line 288
highp vec3 GetMie( in highp vec4 rayMie ) {
    return (((rayMie.xyz * rayMie.w) / max( rayMie.x, 0.0001)) * (betaR.x / betaR));
}
#line 282
highp float PhaseFunctionM( in highp float mu ) {
    return ((((0.119366 * (1.0 - (mieG * mieG))) * pow( ((1.0 + (mieG * mieG)) - ((2.0 * mieG) * mu)), -1.5)) * (1.0 + (mu * mu))) / (2.0 + (mieG * mieG)));
}
#line 276
highp float PhaseFunctionR( in highp float mu ) {
    return (0.0596831 * (1.0 + (mu * mu)));
}
#line 293
highp float SQRT( in highp float f, in highp float err ) {
    #line 297
    return (( (f >= 0.0) ) ? ( sqrt(f) ) : ( err ));
}
#line 109
highp vec4 Texture4D( in sampler2D table, in highp float r, in highp float mu, in highp float muS, in highp float nu ) {
    highp float H = sqrt(((Rt * Rt) - (Rg * Rg)));
    highp float rho = sqrt(((r * r) - (Rg * Rg)));
    #line 116
    highp float rmu = (r * mu);
    highp float delta = (((rmu * rmu) - (r * r)) + (Rg * Rg));
    highp vec4 cst = (( ((rmu < 0.0) && (delta > 0.0)) ) ? ( vec4( 1.0, 0.0, 0.0, (0.5 - (0.5 / RES_MU))) ) : ( vec4( -1.0, (H * H), H, (0.5 + (0.5 / RES_MU))) ));
    highp float uR = ((0.5 / RES_R) + ((rho / H) * (1.0 - (1.0 / RES_R))));
    #line 120
    highp float uMu = (cst.w + ((((rmu * cst.x) + sqrt((delta + cst.y))) / (rho + cst.z)) * (0.5 - (1.0 / RES_MU))));
    #line 126
    highp float uMuS = ((0.5 / RES_MU_S) + ((((atan((max( muS, -0.1975) * tan(1.386))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0 / RES_MU_S))));
    #line 132
    highp float _lerp = (((nu + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float uNu = floor(_lerp);
    _lerp = (_lerp - uNu);
    #line 140
    highp float u_0 = (floor(((uR * RES_R) - 1.0)) / RES_R);
    highp float u_1 = (floor((uR * RES_R)) / RES_R);
    #line 146
    highp float u_frac = fract((uR * RES_R));
    #line 156
    highp vec4 A = ((xll_tex2Dlod( table, vec4( ((uNu + uMuS) / RES_NU), ((uMu / RES_R) + u_0), 0.0, 0.0)) * (1.0 - _lerp)) + (xll_tex2Dlod( table, vec4( (((uNu + uMuS) + 1.0) / RES_NU), ((uMu / RES_R) + u_0), 0.0, 0.0)) * _lerp));
    highp vec4 B = ((xll_tex2Dlod( table, vec4( ((uNu + uMuS) / RES_NU), ((uMu / RES_R) + u_1), 0.0, 0.0)) * (1.0 - _lerp)) + (xll_tex2Dlod( table, vec4( (((uNu + uMuS) + 1.0) / RES_NU), ((uMu / RES_R) + u_1), 0.0, 0.0)) * _lerp));
    #line 165
    return ((A * (1.0 - u_frac)) + (B * u_frac));
}
#line 71
highp vec2 GetTransmittanceUV( in highp float r, in highp float mu ) {
    highp float uR;
    highp float uMu;
    uR = sqrt(((r - Rg) / (Rt - Rg)));
    #line 75
    uMu = (atan((((mu + 0.15) / 1.15) * tan(1.5))) / 1.5);
    #line 80
    return vec2( uMu, uR);
}
#line 203
highp vec3 Transmittance( in highp float r, in highp float mu ) {
    highp vec2 uv = GetTransmittanceUV( r, mu);
    #line 209
    return xll_tex2Dlod( _Sky_Transmittance, vec4( uv, 0.0, 0.0)).xyz;
}
#line 486
highp vec3 InScattering( in highp vec3 camera, in highp vec3 _point, in highp vec3 sundir, out highp vec3 extinction, in highp float shaftWidth ) {
    #line 490
    camera *= scale;
    _point *= scale;
    highp vec3 result;
    #line 494
    highp vec3 viewdir = (_point - camera);
    highp float d = length(viewdir);
    viewdir = (viewdir / d);
    #line 498
    highp float r = length(camera);
    if ((r < (0.9 * Rg))){
        camera.z += Rg;
        _point.z += Rg;
        #line 502
        r = length(camera);
    }
    highp float rMu = dot( camera, viewdir);
    #line 506
    highp float mu = (rMu / r);
    highp float r0 = r;
    highp float mu0 = mu;
    _point -= (viewdir * clamp( shaftWidth, 0.0, d));
    #line 511
    highp float deltaSq = SQRT( (((rMu * rMu) - (r * r)) + (Rt * Rt)), 1e+30);
    highp float din = max( ((-rMu) - deltaSq), 0.0);
    if (((din > 0.0) && (din < d))){
        camera += (din * viewdir);
        #line 515
        rMu += din;
        mu = (rMu / Rt);
        r = Rt;
        d -= din;
    }
    #line 521
    if ((r <= Rt)){
        highp float nu = dot( viewdir, sundir);
        highp float muS = (dot( camera, sundir) / r);
        #line 525
        highp vec4 inScatter;
        if ((r < (Rg + 2000.0))){
            #line 529
            highp float f = ((Rg + 2000.0) / r);
            r = (r * f);
            rMu = (rMu * f);
            _point = (_point * f);
        }
        #line 535
        highp float r1 = length(_point);
        highp float rMu1 = dot( _point, viewdir);
        highp float mu1 = (rMu1 / r1);
        highp float muS1 = (dot( _point, sundir) / r1);
        #line 543
        if ((mu > 0.0)){
            extinction = min( (Transmittance( r, mu) / Transmittance( r1, mu1)), vec3( 1.0));
        }
        else{
            extinction = min( (Transmittance( r1, (-mu1)) / Transmittance( r, (-mu))), vec3( 1.0));
        }
        #line 551
        const highp float EPS = 0.004;
        highp float lim = (-sqrt((1.0 - ((Rg / r) * (Rg / r)))));
        if ((abs((mu - lim)) < 0.004)){
            highp float a = (((mu - lim) + 0.004) / 0.008);
            #line 556
            mu = (lim - 0.004);
            r1 = sqrt((((r * r) + (d * d)) + (((2.0 * r) * d) * mu)));
            mu1 = (((r * mu) + d) / r1);
            highp vec4 inScatter0 = Texture4D( _Sky_Inscatter, r, mu, muS, nu);
            #line 560
            highp vec4 inScatter1 = Texture4D( _Sky_Inscatter, r1, mu1, muS1, nu);
            highp vec4 inScatterA = max( (inScatter0 - (inScatter1 * extinction.xyzx)), vec4( 0.0));
            mu = (lim + 0.004);
            #line 564
            r1 = sqrt((((r * r) + (d * d)) + (((2.0 * r) * d) * mu)));
            mu1 = (((r * mu) + d) / r1);
            inScatter0 = Texture4D( _Sky_Inscatter, r, mu, muS, nu);
            inScatter1 = Texture4D( _Sky_Inscatter, r1, mu1, muS1, nu);
            #line 568
            highp vec4 inScatterB = max( (inScatter0 - (inScatter1 * extinction.xyzx)), vec4( 0.0));
            inScatter = mix( inScatterA, inScatterB, vec4( a));
        }
        else{
            #line 573
            highp vec4 inScatter0_1 = Texture4D( _Sky_Inscatter, r, mu, muS, nu);
            highp vec4 inScatter1_1 = Texture4D( _Sky_Inscatter, r1, mu1, muS1, nu);
            inScatter = max( (inScatter0_1 - (inScatter1_1 * extinction.xyzx)), vec4( 0.0));
        }
        #line 588
        inScatter.w *= smoothstep( 0.0, 0.02, muS);
        highp vec3 inScatterM = GetMie( inScatter);
        highp float phase = PhaseFunctionR( nu);
        #line 592
        highp float phaseM = PhaseFunctionM( nu);
        result = ((inScatter.xyz * phase) + (inScatterM * phaseM));
    }
    else{
        #line 596
        result = vec3( 0.0, 0.0, 0.0);
        extinction = vec3( 1.0, 1.0, 1.0);
    }
    #line 600
    return (result * _Sun_Intensity);
}
#line 42
highp float ReflectedSunRadiance( in highp vec3 L, in highp vec3 V, in highp vec3 N, in highp float sigmaSq ) {
    highp vec3 H = normalize((L + V));
    #line 46
    highp float hn = dot( H, N);
    highp float p = (exp(((-2.0 * ((1.0 - (hn * hn)) / sigmaSq)) / (1.0 + hn))) / (12.5664 * sigmaSq));
    highp float c = (1.0 - dot( V, H));
    #line 50
    highp float c2 = (c * c);
    highp float fresnel = (0.02 + (((0.98 * c2) * c2) * c));
    highp float zL = dot( L, N);
    #line 54
    highp float zV = dot( V, N);
    zL = max( zL, 0.01);
    zV = max( zV, 0.01);
    #line 59
    return (( (zL <= 0.0) ) ? ( 0.0 ) : ( max( ((fresnel * p) * sqrt(abs((zL / zV)))), 0.0) ));
}
#line 33
highp float MeanFresnel( in highp float cosThetaV, in highp float sigmaV ) {
    return (pow( (1.0 - cosThetaV), (5.0 * exp((-2.69 * sigmaV)))) / (1.0 + (22.7 * pow( sigmaV, 1.5))));
}
#line 37
highp float MeanFresnel( in highp vec3 V, in highp vec3 N, in highp float sigmaSq ) {
    return MeanFresnel( dot( V, N), sqrt(sigmaSq));
}
#line 87
highp float RefractedSeaRadiance( in highp vec3 V, in highp vec3 N, in highp float sigmaSq ) {
    return (0.98 * (1.0 - MeanFresnel( V, N, sigmaSq)));
}
#line 95
highp vec2 GetIrradianceUV( in highp float r, in highp float muS ) {
    highp float uR = ((r - Rg) / (Rt - Rg));
    highp float uMuS = ((muS + 0.2) / 1.2);
    #line 99
    return vec2( uMuS, uR);
}
#line 263
highp vec3 Irradiance( in sampler2D samp, in highp float r, in highp float muS ) {
    highp vec2 uv = GetIrradianceUV( r, muS);
    #line 269
    return xll_tex2Dlod( samp, vec4( uv, 0.0, 0.0)).xyz;
}
#line 321
highp vec3 SkyIrradiance( in highp float r, in highp float muS ) {
    return (Irradiance( _Sky_Irradiance, r, muS) * _Sun_Intensity);
}
#line 226
highp vec3 TransmittanceWithShadow( in highp float r, in highp float mu ) {
    return (( (mu < (-sqrt((1.0 - ((Rg / r) * (Rg / r)))))) ) ? ( vec3( 0.0, 0.0, 0.0) ) : ( Transmittance( r, mu) ));
}
#line 308
highp vec3 SunRadiance( in highp float r, in highp float muS ) {
    return (TransmittanceWithShadow( r, muS) * _Sun_Intensity);
}
#line 459
void SunRadianceAndSkyIrradiance( in highp vec3 worldP, in highp vec3 worldN, in highp vec3 worldS, out highp vec3 sunL, out highp vec3 skyE ) {
    worldP *= scale;
    highp float r = length(worldP);
    #line 463
    if ((r < (0.9 * Rg))){
        worldP.z += Rg;
        r = length(worldP);
    }
    #line 467
    highp vec3 worldV = (worldP / r);
    highp float muS = dot( worldV, worldS);
    highp float sunOcclusion = 1.0;
    #line 471
    sunL = (SunRadiance( r, muS) * sunOcclusion);
    highp float skyOcclusion = ((1.0 + dot( worldV, worldN)) * 0.5);
    #line 477
    skyE = ((2.0 * SkyIrradiance( r, muS)) * skyOcclusion);
}
#line 91
highp float erf( in highp float x ) {
    highp float a = 0.140012;
    highp float x2 = (x * x);
    #line 95
    highp float ax2 = (a * x2);
    return (sign(x) * sqrt((1.0 - exp((((-x2) * (1.27324 + ax2)) / (1.0 + ax2))))));
}
#line 99
highp float WhitecapCoverage( in highp float epsilon, in highp float mu, in highp float sigma2 ) {
    return ((0.5 * erf( (((0.5 * sqrt(2.0)) * (epsilon - mu)) * (1.0 / sqrt(sigma2))))) + 0.5);
}
#line 7
highp vec3 hdr( in highp vec3 L ) {
    L = (L * _Exposure);
    L.x = (( (L.x < 1.413) ) ? ( pow( (L.x * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.x))) ));
    #line 11
    L.y = (( (L.y < 1.413) ) ? ( pow( (L.y * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.y))) ));
    L.z = (( (L.z < 1.413) ) ? ( pow( (L.z * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.z))) ));
    return L;
}
#line 175
highp vec4 frag( in v2f IN ) {
    #line 180
    highp vec3 L = _Ocean_SunDir;
    highp float radius = _Ocean_Radius;
    highp vec2 u = IN.oceanU;
    highp vec3 oceanP = IN.oceanP;
    #line 187
    highp vec3 earthCamera = vec3( 0.0, 0.0, (_Ocean_CameraPos.z + radius));
    highp vec3 earthP = (( (radius > 0.0) ) ? ( (normalize((oceanP + vec3( 0.0, 0.0, radius))) * (radius + 10.0)) ) : ( oceanP ));
    #line 191
    highp float dist = length((earthP - earthCamera));
    highp float clampFactor = clamp( (dist / alphaRadius), 0.0, 1.0);
    #line 195
    highp float outAlpha = mix( _OceanAlpha, 1.0, clampFactor);
    highp float outWhiteCapStr = mix( _Ocean_WhiteCapStr, farWhiteCapStr, clampFactor);
    #line 199
    highp vec3 oceanCamera = vec3( 0.0, 0.0, _Ocean_CameraPos.z);
    highp vec3 V = normalize((oceanCamera - oceanP));
    highp vec2 slopes = vec2( 0.0, 0.0);
    #line 203
    slopes += texture2D( _Ocean_Map1, (u / _Ocean_GridSizes.x)).xy;
    slopes += texture2D( _Ocean_Map1, (u / _Ocean_GridSizes.y)).zw;
    slopes += texture2D( _Ocean_Map2, (u / _Ocean_GridSizes.z)).xy;
    slopes += texture2D( _Ocean_Map2, (u / _Ocean_GridSizes.w)).zw;
    #line 208
    if ((radius > 0.0)){
        slopes -= (oceanP.xy / (radius + oceanP.z));
    }
    #line 212
    highp vec3 N = normalize(vec3( (-slopes.x), (-slopes.y), 1.0));
    if ((dot( V, N) < 0.0)){
        N = reflect( N, V);
    }
    #line 218
    highp float Jxx = xll_dFdx_f(u.x);
    highp float Jxy = xll_dFdy_f(u.x);
    highp float Jyx = xll_dFdx_f(u.y);
    highp float Jyy = xll_dFdy_f(u.y);
    #line 222
    highp float A = ((Jxx * Jxx) + (Jyx * Jyx));
    highp float B = ((Jxx * Jxy) + (Jyx * Jyy));
    highp float C = ((Jxy * Jxy) + (Jyy * Jyy));
    const highp float SCALE = 10.0;
    #line 226
    highp float ua = pow( (A / 10.0), 0.25);
    highp float ub = (0.5 + ((0.5 * B) / sqrt((A * C))));
    highp float uc = pow( (C / 10.0), 0.25);
    #line 230
    highp vec2 sigmaSq = (texture3D( _Ocean_Variance, vec3( ua, ub, uc)).xy * _VarianceMax);
    sigmaSq = max( sigmaSq, vec2( 2e-05));
    #line 234
    highp vec3 sunL;
    highp vec3 skyE;
    highp vec3 extinction;
    SunRadianceAndSkyIrradiance( earthP, N, L, sunL, skyE);
    #line 239
    highp vec3 Lsky;
    #line 243
    Lsky = ((MeanFresnel( V, N, float( sigmaSq)) * skyE) / 3.14159);
    highp vec3 Lsun = (ReflectedSunRadiance( L, V, N, float( sigmaSq)) * sunL);
    highp vec3 Lsea = (((RefractedSeaRadiance( V, N, float( sigmaSq)) * _Ocean_Color) * skyE) / 3.14159);
    #line 249
    highp vec2 jm1 = texture2D( _Ocean_Foam0, (u / _Ocean_GridSizes.x)).xy;
    highp vec2 jm2 = texture2D( _Ocean_Foam0, (u / _Ocean_GridSizes.y)).zw;
    highp vec2 jm3 = texture2D( _Ocean_Foam1, (u / _Ocean_GridSizes.z)).xy;
    highp vec2 jm4 = texture2D( _Ocean_Foam1, (u / _Ocean_GridSizes.w)).zw;
    #line 253
    highp vec2 jm = (((jm1 + jm2) + jm3) + jm4);
    highp float jSigma2 = max( (jm.y - ((((jm1.x * jm1.x) + (jm2.x * jm2.x)) + (jm3.x * jm3.x)) + (jm4.x * jm4.x))), 0.0);
    #line 257
    highp float W = WhitecapCoverage( outWhiteCapStr, jm.x, jSigma2);
    highp vec3 l = (((sunL * max( dot( N, L), 0.0)) + skyE) / 3.14159);
    #line 261
    highp vec3 R_ftot = ((W * l) * 0.4);
    highp vec3 surfaceColor = ((((sunReflectionMultiplier * Lsun) + (skyReflectionMultiplier * Lsky)) + (seaRefractionMultiplier * Lsea)) + R_ftot);
    #line 267
    highp vec3 inscatter = InScattering( earthCamera, earthP, L, extinction, 0.0);
    highp vec3 finalColor = (surfaceColor * extinction);
    return vec4( hdr( finalColor), outAlpha);
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main() {
    highp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.oceanU = vec2(xlv_TEXCOORD0);
    xlt_IN.oceanP = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:131(2): warning: empty declaration
0:65(2): warning: empty declaration
0:105(39): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
0:231(50): error: `_Ocean_Variance' undeclared
0:0(0): error: no matching function for call to `texture3D(error, vec3)'
0:231(74): error: type mismatch
0:231(88): error: operands to arithmetic operators must be numeric
*/


#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal (normalize(_glesNormal))
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLod( s, coord.xy, coord.w);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 221
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 275
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 271
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 126
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
};
#line 60
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
};
#line 16
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 21
uniform highp vec3 _WorldSpaceCameraPos;
#line 27
uniform highp vec4 _ProjectionParams;
#line 33
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
#line 40
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 53
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 58
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
#line 63
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
#line 69
uniform highp vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 73
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 77
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 83
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 90
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 94
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 110
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 122
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
#line 133
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 149
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 173
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
#line 182
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 48
uniform lowp vec4 unity_ColorSpaceGrey;
#line 89
#line 104
#line 119
#line 125
#line 143
#line 175
#line 192
#line 227
#line 238
#line 248
#line 256
#line 280
#line 286
#line 296
#line 305
#line 312
#line 321
#line 329
#line 338
#line 357
#line 363
#line 376
#line 387
#line 392
#line 418
#line 434
#line 447
#line 3
uniform highp float _Exposure;
#line 7
#line 14
uniform highp float scale;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RL;
#line 22
uniform highp float HR;
uniform highp vec3 betaR;
#line 26
uniform highp float HM;
uniform highp vec3 betaMSca;
uniform highp vec3 betaMEx;
uniform highp float mieG;
#line 35
uniform highp float TRANSMITTANCE_W;
uniform highp float TRANSMITTANCE_H;
uniform highp float SKY_W;
#line 39
uniform highp float SKY_H;
uniform highp float RES_R;
uniform highp float RES_MU;
#line 43
uniform highp float RES_MU_S;
uniform highp float RES_NU;
#line 55
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Irradiance;
#line 59
uniform sampler2D _Sky_Inscatter;
#line 71
#line 95
#line 109
#line 203
#line 226
#line 263
#line 276
#line 282
#line 288
#line 293
#line 308
#line 321
#line 391
#line 459
#line 486
#line 33
#line 37
#line 42
#line 70
#line 87
#line 91
#line 99
#line 103
#line 29
uniform highp float _Ocean_Radius;
uniform highp vec3 _Ocean_Horizon1;
uniform highp vec3 _Ocean_Horizon2;
uniform highp float _Ocean_HeightOffset;
#line 33
uniform highp vec3 _Ocean_CameraPos;
uniform highp mat4 _Ocean_OceanToCamera;
uniform highp mat4 _Ocean_CameraToOcean;
#line 37
#line 67
#line 75
#line 90
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_WorldToScreen;
uniform highp mat4 _Globals_CameraToScreen;
#line 94
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec2 _Ocean_MapSize;
uniform highp vec4 _Ocean_Choppyness;
#line 98
uniform highp vec3 _Ocean_SunDir;
uniform highp vec3 _Ocean_Color;
uniform highp vec4 _Ocean_GridSizes;
uniform highp vec2 _Ocean_ScreenGridSize;
#line 102
uniform highp float _Ocean_WhiteCapStr;
uniform highp float farWhiteCapStr;
uniform lowp sampler3D _Ocean_Variance;
#line 106
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
uniform sampler2D _Ocean_Map3;
#line 110
uniform sampler2D _Ocean_Map4;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
#line 114
uniform highp float _OceanAlpha;
uniform highp float alphaRadius;
uniform highp float sunReflectionMultiplier;
#line 118
uniform highp float skyReflectionMultiplier;
uniform highp float seaRefractionMultiplier;
#line 122
uniform highp vec2 _VarianceMax;
uniform sampler2D _Sky_Map;
#line 133
#line 175
#line 37
highp vec2 OceanPos( in highp vec4 vert, in highp mat4 stoc, out highp float t, out highp vec3 cameraDir, out highp vec3 oceanDir ) {
    highp float horizon = (_Ocean_Horizon1.x + (_Ocean_Horizon1.y * vert.x));
    #line 41
    horizon -= sqrt((_Ocean_Horizon2.x + ((_Ocean_Horizon2.y + (_Ocean_Horizon2.z * vert.x)) * vert.x)));
    highp vec4 v = vec4( vert.x, min( vert.y, horizon), 0.0, 1.0);
    #line 45
    cameraDir = normalize((stoc * v).xyz);
    oceanDir = (_Ocean_CameraToOcean * vec4( cameraDir, 0.0)).xyz;
    highp float cz = _Ocean_CameraPos.z;
    #line 49
    highp float dz = oceanDir.z;
    highp float radius = _Ocean_Radius;
    if ((radius == 0.0)){
        #line 53
        t = ((_Ocean_HeightOffset + (-cz)) / dz);
    }
    else{
        #line 57
        highp float b = (dz * (cz + radius));
        highp float c = (cz * (cz + (2.0 * radius)));
        highp float tSphere = ((-b) - sqrt(max( ((b * b) - c), 0.0)));
        highp float tApprox = (((-cz) / dz) * (1.0 + ((cz / (2.0 * radius)) * (1.0 - (dz * dz)))));
        #line 61
        t = (( (abs(((tApprox - tSphere) * dz)) < 1.0) ) ? ( tApprox ) : ( tSphere ));
    }
    return (_Ocean_CameraPos.xy + (t * oceanDir.xy));
}
#line 67
highp vec2 OceanPos( in highp vec4 vert, in highp mat4 stoc ) {
    highp float t;
    highp vec3 cameraDir;
    #line 71
    highp vec3 oceanDir;
    return OceanPos( vert, stoc, t, cameraDir, oceanDir);
}
#line 75
highp vec4 Tex2DGrad( in sampler2D tex, in highp vec2 uv, in highp vec2 dx, in highp vec2 dy, in highp vec2 texSize ) {
    #line 79
    highp vec2 px = (texSize.x * dx);
    highp vec2 py = (texSize.y * dy);
    highp float lod = (0.5 * log2(max( dot( px, px), dot( py, py))));
    return xll_tex2Dlod( tex, vec4( uv, 0.0, lod));
}
#line 133
v2f vert( in appdata_base v ) {
    highp float t;
    highp vec3 cameraDir;
    highp vec3 oceanDir;
    #line 138
    highp vec4 vert = v.vertex;
    vert.xy *= 1.25;
    highp vec2 u = OceanPos( vert, _Globals_ScreenToCamera, t, cameraDir, oceanDir);
    #line 142
    highp vec2 dux = (OceanPos( (vert + vec4( _Ocean_ScreenGridSize.x, 0.0, 0.0, 0.0)), _Globals_ScreenToCamera) - u);
    highp vec2 duy = (OceanPos( (vert + vec4( 0.0, _Ocean_ScreenGridSize.y, 0.0, 0.0)), _Globals_ScreenToCamera) - u);
    highp vec3 dP = vec3( 0.0, 0.0, _Ocean_HeightOffset);
    #line 146
    if (((duy.x != 0.0) || (duy.y != 0.0))){
        highp vec4 GRID_SIZES = _Ocean_GridSizes;
        highp vec4 CHOPPYNESS = _Ocean_Choppyness;
        #line 151
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.x), (dux / GRID_SIZES.x), (duy / GRID_SIZES.x), _Ocean_MapSize).x;
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.y), (dux / GRID_SIZES.y), (duy / GRID_SIZES.y), _Ocean_MapSize).y;
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.z), (dux / GRID_SIZES.z), (duy / GRID_SIZES.z), _Ocean_MapSize).z;
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.w), (dux / GRID_SIZES.w), (duy / GRID_SIZES.w), _Ocean_MapSize).w;
        #line 156
        dP.xy += (CHOPPYNESS.x * Tex2DGrad( _Ocean_Map3, (u / GRID_SIZES.x), (dux / GRID_SIZES.x), (duy / GRID_SIZES.x), _Ocean_MapSize).xy);
        dP.xy += (CHOPPYNESS.y * Tex2DGrad( _Ocean_Map3, (u / GRID_SIZES.y), (dux / GRID_SIZES.y), (duy / GRID_SIZES.y), _Ocean_MapSize).zw);
        dP.xy += (CHOPPYNESS.z * Tex2DGrad( _Ocean_Map4, (u / GRID_SIZES.z), (dux / GRID_SIZES.z), (duy / GRID_SIZES.z), _Ocean_MapSize).xy);
        dP.xy += (CHOPPYNESS.w * Tex2DGrad( _Ocean_Map4, (u / GRID_SIZES.w), (dux / GRID_SIZES.w), (duy / GRID_SIZES.w), _Ocean_MapSize).zw);
    }
    #line 162
    v2f OUT;
    highp mat3 otoc = xll_constructMat3_mf4x4( _Ocean_OceanToCamera);
    highp vec4 screenP = vec4( ((t * cameraDir) + (otoc * dP)), 1.0);
    #line 166
    highp vec3 oceanP = (((t * oceanDir) + dP) + vec3( 0.0, 0.0, _Ocean_CameraPos.z));
    OUT.pos = (_Globals_CameraToScreen * screenP);
    OUT.oceanU = u;
    #line 170
    OUT.oceanP = oceanP;
    return OUT;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata_base xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.oceanU);
    xlv_TEXCOORD1 = vec3(xl_retval.oceanP);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:131(2): warning: empty declaration
0:65(2): warning: empty declaration
0:105(39): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
*/


#endif
#ifdef FRAGMENT

#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
#endif
#extension GL_EXT_shader_texture_lod : require
#extension GL_OES_standard_derivatives : require
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLodEXT( s, coord.xy, coord.w);
}
#line 221
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 275
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 271
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 126
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
};
#line 60
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
};
#line 16
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 21
uniform highp vec3 _WorldSpaceCameraPos;
#line 27
uniform highp vec4 _ProjectionParams;
#line 33
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
#line 40
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 53
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 58
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
#line 63
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
#line 69
uniform highp vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 73
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 77
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 83
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 90
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 94
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 110
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 122
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
#line 133
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 149
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 173
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
#line 182
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 48
uniform lowp vec4 unity_ColorSpaceGrey;
#line 89
#line 104
#line 119
#line 125
#line 143
#line 175
#line 192
#line 227
#line 238
#line 248
#line 256
#line 280
#line 286
#line 296
#line 305
#line 312
#line 321
#line 329
#line 338
#line 357
#line 363
#line 376
#line 387
#line 392
#line 418
#line 434
#line 447
#line 3
uniform highp float _Exposure;
#line 7
#line 14
uniform highp float scale;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RL;
#line 22
uniform highp float HR;
uniform highp vec3 betaR;
#line 26
uniform highp float HM;
uniform highp vec3 betaMSca;
uniform highp vec3 betaMEx;
uniform highp float mieG;
#line 35
uniform highp float TRANSMITTANCE_W;
uniform highp float TRANSMITTANCE_H;
uniform highp float SKY_W;
#line 39
uniform highp float SKY_H;
uniform highp float RES_R;
uniform highp float RES_MU;
#line 43
uniform highp float RES_MU_S;
uniform highp float RES_NU;
#line 55
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Irradiance;
#line 59
uniform sampler2D _Sky_Inscatter;
#line 71
#line 95
#line 109
#line 203
#line 226
#line 263
#line 276
#line 282
#line 288
#line 293
#line 308
#line 321
#line 391
#line 459
#line 486
#line 33
#line 37
#line 42
#line 70
#line 87
#line 91
#line 99
#line 103
#line 29
uniform highp float _Ocean_Radius;
uniform highp vec3 _Ocean_Horizon1;
uniform highp vec3 _Ocean_Horizon2;
uniform highp float _Ocean_HeightOffset;
#line 33
uniform highp vec3 _Ocean_CameraPos;
uniform highp mat4 _Ocean_OceanToCamera;
uniform highp mat4 _Ocean_CameraToOcean;
#line 37
#line 67
#line 75
#line 90
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_WorldToScreen;
uniform highp mat4 _Globals_CameraToScreen;
#line 94
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp vec2 _Ocean_MapSize;
uniform highp vec4 _Ocean_Choppyness;
#line 98
uniform highp vec3 _Ocean_SunDir;
uniform highp vec3 _Ocean_Color;
uniform highp vec4 _Ocean_GridSizes;
uniform highp vec2 _Ocean_ScreenGridSize;
#line 102
uniform highp float _Ocean_WhiteCapStr;
uniform highp float farWhiteCapStr;
uniform lowp sampler3D _Ocean_Variance;
#line 106
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
uniform sampler2D _Ocean_Map3;
#line 110
uniform sampler2D _Ocean_Map4;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
#line 114
uniform highp float _OceanAlpha;
uniform highp float alphaRadius;
uniform highp float sunReflectionMultiplier;
#line 118
uniform highp float skyReflectionMultiplier;
uniform highp float seaRefractionMultiplier;
#line 122
uniform highp vec2 _VarianceMax;
uniform sampler2D _Sky_Map;
#line 133
#line 175
#line 288
highp vec3 GetMie( in highp vec4 rayMie ) {
    return (((rayMie.xyz * rayMie.w) / max( rayMie.x, 0.0001)) * (betaR.x / betaR));
}
#line 282
highp float PhaseFunctionM( in highp float mu ) {
    return ((((0.119366 * (1.0 - (mieG * mieG))) * pow( ((1.0 + (mieG * mieG)) - ((2.0 * mieG) * mu)), -1.5)) * (1.0 + (mu * mu))) / (2.0 + (mieG * mieG)));
}
#line 276
highp float PhaseFunctionR( in highp float mu ) {
    return (0.0596831 * (1.0 + (mu * mu)));
}
#line 293
highp float SQRT( in highp float f, in highp float err ) {
    #line 297
    return (( (f >= 0.0) ) ? ( sqrt(f) ) : ( err ));
}
#line 109
highp vec4 Texture4D( in sampler2D table, in highp float r, in highp float mu, in highp float muS, in highp float nu ) {
    highp float H = sqrt(((Rt * Rt) - (Rg * Rg)));
    highp float rho = sqrt(((r * r) - (Rg * Rg)));
    #line 116
    highp float rmu = (r * mu);
    highp float delta = (((rmu * rmu) - (r * r)) + (Rg * Rg));
    highp vec4 cst = (( ((rmu < 0.0) && (delta > 0.0)) ) ? ( vec4( 1.0, 0.0, 0.0, (0.5 - (0.5 / RES_MU))) ) : ( vec4( -1.0, (H * H), H, (0.5 + (0.5 / RES_MU))) ));
    highp float uR = ((0.5 / RES_R) + ((rho / H) * (1.0 - (1.0 / RES_R))));
    #line 120
    highp float uMu = (cst.w + ((((rmu * cst.x) + sqrt((delta + cst.y))) / (rho + cst.z)) * (0.5 - (1.0 / RES_MU))));
    #line 126
    highp float uMuS = ((0.5 / RES_MU_S) + ((((atan((max( muS, -0.1975) * tan(1.386))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0 / RES_MU_S))));
    #line 132
    highp float _lerp = (((nu + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float uNu = floor(_lerp);
    _lerp = (_lerp - uNu);
    #line 140
    highp float u_0 = (floor(((uR * RES_R) - 1.0)) / RES_R);
    highp float u_1 = (floor((uR * RES_R)) / RES_R);
    #line 146
    highp float u_frac = fract((uR * RES_R));
    #line 156
    highp vec4 A = ((xll_tex2Dlod( table, vec4( ((uNu + uMuS) / RES_NU), ((uMu / RES_R) + u_0), 0.0, 0.0)) * (1.0 - _lerp)) + (xll_tex2Dlod( table, vec4( (((uNu + uMuS) + 1.0) / RES_NU), ((uMu / RES_R) + u_0), 0.0, 0.0)) * _lerp));
    highp vec4 B = ((xll_tex2Dlod( table, vec4( ((uNu + uMuS) / RES_NU), ((uMu / RES_R) + u_1), 0.0, 0.0)) * (1.0 - _lerp)) + (xll_tex2Dlod( table, vec4( (((uNu + uMuS) + 1.0) / RES_NU), ((uMu / RES_R) + u_1), 0.0, 0.0)) * _lerp));
    #line 165
    return ((A * (1.0 - u_frac)) + (B * u_frac));
}
#line 71
highp vec2 GetTransmittanceUV( in highp float r, in highp float mu ) {
    highp float uR;
    highp float uMu;
    uR = sqrt(((r - Rg) / (Rt - Rg)));
    #line 75
    uMu = (atan((((mu + 0.15) / 1.15) * tan(1.5))) / 1.5);
    #line 80
    return vec2( uMu, uR);
}
#line 203
highp vec3 Transmittance( in highp float r, in highp float mu ) {
    highp vec2 uv = GetTransmittanceUV( r, mu);
    #line 209
    return xll_tex2Dlod( _Sky_Transmittance, vec4( uv, 0.0, 0.0)).xyz;
}
#line 486
highp vec3 InScattering( in highp vec3 camera, in highp vec3 _point, in highp vec3 sundir, out highp vec3 extinction, in highp float shaftWidth ) {
    #line 490
    camera *= scale;
    _point *= scale;
    highp vec3 result;
    #line 494
    highp vec3 viewdir = (_point - camera);
    highp float d = length(viewdir);
    viewdir = (viewdir / d);
    #line 498
    highp float r = length(camera);
    if ((r < (0.9 * Rg))){
        camera.z += Rg;
        _point.z += Rg;
        #line 502
        r = length(camera);
    }
    highp float rMu = dot( camera, viewdir);
    #line 506
    highp float mu = (rMu / r);
    highp float r0 = r;
    highp float mu0 = mu;
    _point -= (viewdir * clamp( shaftWidth, 0.0, d));
    #line 511
    highp float deltaSq = SQRT( (((rMu * rMu) - (r * r)) + (Rt * Rt)), 1e+30);
    highp float din = max( ((-rMu) - deltaSq), 0.0);
    if (((din > 0.0) && (din < d))){
        camera += (din * viewdir);
        #line 515
        rMu += din;
        mu = (rMu / Rt);
        r = Rt;
        d -= din;
    }
    #line 521
    if ((r <= Rt)){
        highp float nu = dot( viewdir, sundir);
        highp float muS = (dot( camera, sundir) / r);
        #line 525
        highp vec4 inScatter;
        if ((r < (Rg + 2000.0))){
            #line 529
            highp float f = ((Rg + 2000.0) / r);
            r = (r * f);
            rMu = (rMu * f);
            _point = (_point * f);
        }
        #line 535
        highp float r1 = length(_point);
        highp float rMu1 = dot( _point, viewdir);
        highp float mu1 = (rMu1 / r1);
        highp float muS1 = (dot( _point, sundir) / r1);
        #line 543
        if ((mu > 0.0)){
            extinction = min( (Transmittance( r, mu) / Transmittance( r1, mu1)), vec3( 1.0));
        }
        else{
            extinction = min( (Transmittance( r1, (-mu1)) / Transmittance( r, (-mu))), vec3( 1.0));
        }
        #line 551
        const highp float EPS = 0.004;
        highp float lim = (-sqrt((1.0 - ((Rg / r) * (Rg / r)))));
        if ((abs((mu - lim)) < 0.004)){
            highp float a = (((mu - lim) + 0.004) / 0.008);
            #line 556
            mu = (lim - 0.004);
            r1 = sqrt((((r * r) + (d * d)) + (((2.0 * r) * d) * mu)));
            mu1 = (((r * mu) + d) / r1);
            highp vec4 inScatter0 = Texture4D( _Sky_Inscatter, r, mu, muS, nu);
            #line 560
            highp vec4 inScatter1 = Texture4D( _Sky_Inscatter, r1, mu1, muS1, nu);
            highp vec4 inScatterA = max( (inScatter0 - (inScatter1 * extinction.xyzx)), vec4( 0.0));
            mu = (lim + 0.004);
            #line 564
            r1 = sqrt((((r * r) + (d * d)) + (((2.0 * r) * d) * mu)));
            mu1 = (((r * mu) + d) / r1);
            inScatter0 = Texture4D( _Sky_Inscatter, r, mu, muS, nu);
            inScatter1 = Texture4D( _Sky_Inscatter, r1, mu1, muS1, nu);
            #line 568
            highp vec4 inScatterB = max( (inScatter0 - (inScatter1 * extinction.xyzx)), vec4( 0.0));
            inScatter = mix( inScatterA, inScatterB, vec4( a));
        }
        else{
            #line 573
            highp vec4 inScatter0_1 = Texture4D( _Sky_Inscatter, r, mu, muS, nu);
            highp vec4 inScatter1_1 = Texture4D( _Sky_Inscatter, r1, mu1, muS1, nu);
            inScatter = max( (inScatter0_1 - (inScatter1_1 * extinction.xyzx)), vec4( 0.0));
        }
        #line 588
        inScatter.w *= smoothstep( 0.0, 0.02, muS);
        highp vec3 inScatterM = GetMie( inScatter);
        highp float phase = PhaseFunctionR( nu);
        #line 592
        highp float phaseM = PhaseFunctionM( nu);
        result = ((inScatter.xyz * phase) + (inScatterM * phaseM));
    }
    else{
        #line 596
        result = vec3( 0.0, 0.0, 0.0);
        extinction = vec3( 1.0, 1.0, 1.0);
    }
    #line 600
    return (result * _Sun_Intensity);
}
#line 42
highp float ReflectedSunRadiance( in highp vec3 L, in highp vec3 V, in highp vec3 N, in highp float sigmaSq ) {
    highp vec3 H = normalize((L + V));
    #line 46
    highp float hn = dot( H, N);
    highp float p = (exp(((-2.0 * ((1.0 - (hn * hn)) / sigmaSq)) / (1.0 + hn))) / (12.5664 * sigmaSq));
    highp float c = (1.0 - dot( V, H));
    #line 50
    highp float c2 = (c * c);
    highp float fresnel = (0.02 + (((0.98 * c2) * c2) * c));
    highp float zL = dot( L, N);
    #line 54
    highp float zV = dot( V, N);
    zL = max( zL, 0.01);
    zV = max( zV, 0.01);
    #line 59
    return (( (zL <= 0.0) ) ? ( 0.0 ) : ( max( ((fresnel * p) * sqrt(abs((zL / zV)))), 0.0) ));
}
#line 33
highp float MeanFresnel( in highp float cosThetaV, in highp float sigmaV ) {
    return (pow( (1.0 - cosThetaV), (5.0 * exp((-2.69 * sigmaV)))) / (1.0 + (22.7 * pow( sigmaV, 1.5))));
}
#line 37
highp float MeanFresnel( in highp vec3 V, in highp vec3 N, in highp float sigmaSq ) {
    return MeanFresnel( dot( V, N), sqrt(sigmaSq));
}
#line 87
highp float RefractedSeaRadiance( in highp vec3 V, in highp vec3 N, in highp float sigmaSq ) {
    return (0.98 * (1.0 - MeanFresnel( V, N, sigmaSq)));
}
#line 95
highp vec2 GetIrradianceUV( in highp float r, in highp float muS ) {
    highp float uR = ((r - Rg) / (Rt - Rg));
    highp float uMuS = ((muS + 0.2) / 1.2);
    #line 99
    return vec2( uMuS, uR);
}
#line 263
highp vec3 Irradiance( in sampler2D samp, in highp float r, in highp float muS ) {
    highp vec2 uv = GetIrradianceUV( r, muS);
    #line 269
    return xll_tex2Dlod( samp, vec4( uv, 0.0, 0.0)).xyz;
}
#line 321
highp vec3 SkyIrradiance( in highp float r, in highp float muS ) {
    return (Irradiance( _Sky_Irradiance, r, muS) * _Sun_Intensity);
}
#line 226
highp vec3 TransmittanceWithShadow( in highp float r, in highp float mu ) {
    return (( (mu < (-sqrt((1.0 - ((Rg / r) * (Rg / r)))))) ) ? ( vec3( 0.0, 0.0, 0.0) ) : ( Transmittance( r, mu) ));
}
#line 308
highp vec3 SunRadiance( in highp float r, in highp float muS ) {
    return (TransmittanceWithShadow( r, muS) * _Sun_Intensity);
}
#line 459
void SunRadianceAndSkyIrradiance( in highp vec3 worldP, in highp vec3 worldN, in highp vec3 worldS, out highp vec3 sunL, out highp vec3 skyE ) {
    worldP *= scale;
    highp float r = length(worldP);
    #line 463
    if ((r < (0.9 * Rg))){
        worldP.z += Rg;
        r = length(worldP);
    }
    #line 467
    highp vec3 worldV = (worldP / r);
    highp float muS = dot( worldV, worldS);
    highp float sunOcclusion = 1.0;
    #line 471
    sunL = (SunRadiance( r, muS) * sunOcclusion);
    highp float skyOcclusion = ((1.0 + dot( worldV, worldN)) * 0.5);
    #line 477
    skyE = ((2.0 * SkyIrradiance( r, muS)) * skyOcclusion);
}
#line 91
highp float erf( in highp float x ) {
    highp float a = 0.140012;
    highp float x2 = (x * x);
    #line 95
    highp float ax2 = (a * x2);
    return (sign(x) * sqrt((1.0 - exp((((-x2) * (1.27324 + ax2)) / (1.0 + ax2))))));
}
#line 99
highp float WhitecapCoverage( in highp float epsilon, in highp float mu, in highp float sigma2 ) {
    return ((0.5 * erf( (((0.5 * sqrt(2.0)) * (epsilon - mu)) * (1.0 / sqrt(sigma2))))) + 0.5);
}
#line 7
highp vec3 hdr( in highp vec3 L ) {
    L = (L * _Exposure);
    L.x = (( (L.x < 1.413) ) ? ( pow( (L.x * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.x))) ));
    #line 11
    L.y = (( (L.y < 1.413) ) ? ( pow( (L.y * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.y))) ));
    L.z = (( (L.z < 1.413) ) ? ( pow( (L.z * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.z))) ));
    return L;
}
#line 175
highp vec4 frag( in v2f IN ) {
    #line 180
    highp vec3 L = _Ocean_SunDir;
    highp float radius = _Ocean_Radius;
    highp vec2 u = IN.oceanU;
    highp vec3 oceanP = IN.oceanP;
    #line 187
    highp vec3 earthCamera = vec3( 0.0, 0.0, (_Ocean_CameraPos.z + radius));
    highp vec3 earthP = (( (radius > 0.0) ) ? ( (normalize((oceanP + vec3( 0.0, 0.0, radius))) * (radius + 10.0)) ) : ( oceanP ));
    #line 191
    highp float dist = length((earthP - earthCamera));
    highp float clampFactor = clamp( (dist / alphaRadius), 0.0, 1.0);
    #line 195
    highp float outAlpha = mix( _OceanAlpha, 1.0, clampFactor);
    highp float outWhiteCapStr = mix( _Ocean_WhiteCapStr, farWhiteCapStr, clampFactor);
    #line 199
    highp vec3 oceanCamera = vec3( 0.0, 0.0, _Ocean_CameraPos.z);
    highp vec3 V = normalize((oceanCamera - oceanP));
    highp vec2 slopes = vec2( 0.0, 0.0);
    #line 203
    slopes += texture2D( _Ocean_Map1, (u / _Ocean_GridSizes.x)).xy;
    slopes += texture2D( _Ocean_Map1, (u / _Ocean_GridSizes.y)).zw;
    slopes += texture2D( _Ocean_Map2, (u / _Ocean_GridSizes.z)).xy;
    slopes += texture2D( _Ocean_Map2, (u / _Ocean_GridSizes.w)).zw;
    #line 208
    if ((radius > 0.0)){
        slopes -= (oceanP.xy / (radius + oceanP.z));
    }
    #line 212
    highp vec3 N = normalize(vec3( (-slopes.x), (-slopes.y), 1.0));
    if ((dot( V, N) < 0.0)){
        N = reflect( N, V);
    }
    #line 218
    highp float Jxx = xll_dFdx_f(u.x);
    highp float Jxy = xll_dFdy_f(u.x);
    highp float Jyx = xll_dFdx_f(u.y);
    highp float Jyy = xll_dFdy_f(u.y);
    #line 222
    highp float A = ((Jxx * Jxx) + (Jyx * Jyx));
    highp float B = ((Jxx * Jxy) + (Jyx * Jyy));
    highp float C = ((Jxy * Jxy) + (Jyy * Jyy));
    const highp float SCALE = 10.0;
    #line 226
    highp float ua = pow( (A / 10.0), 0.25);
    highp float ub = (0.5 + ((0.5 * B) / sqrt((A * C))));
    highp float uc = pow( (C / 10.0), 0.25);
    #line 230
    highp vec2 sigmaSq = (texture3D( _Ocean_Variance, vec3( ua, ub, uc)).xy * _VarianceMax);
    sigmaSq = max( sigmaSq, vec2( 2e-05));
    #line 234
    highp vec3 sunL;
    highp vec3 skyE;
    highp vec3 extinction;
    SunRadianceAndSkyIrradiance( earthP, N, L, sunL, skyE);
    #line 239
    highp vec3 Lsky;
    #line 243
    Lsky = ((MeanFresnel( V, N, float( sigmaSq)) * skyE) / 3.14159);
    highp vec3 Lsun = (ReflectedSunRadiance( L, V, N, float( sigmaSq)) * sunL);
    highp vec3 Lsea = (((RefractedSeaRadiance( V, N, float( sigmaSq)) * _Ocean_Color) * skyE) / 3.14159);
    #line 249
    highp vec2 jm1 = texture2D( _Ocean_Foam0, (u / _Ocean_GridSizes.x)).xy;
    highp vec2 jm2 = texture2D( _Ocean_Foam0, (u / _Ocean_GridSizes.y)).zw;
    highp vec2 jm3 = texture2D( _Ocean_Foam1, (u / _Ocean_GridSizes.z)).xy;
    highp vec2 jm4 = texture2D( _Ocean_Foam1, (u / _Ocean_GridSizes.w)).zw;
    #line 253
    highp vec2 jm = (((jm1 + jm2) + jm3) + jm4);
    highp float jSigma2 = max( (jm.y - ((((jm1.x * jm1.x) + (jm2.x * jm2.x)) + (jm3.x * jm3.x)) + (jm4.x * jm4.x))), 0.0);
    #line 257
    highp float W = WhitecapCoverage( outWhiteCapStr, jm.x, jSigma2);
    highp vec3 l = (((sunL * max( dot( N, L), 0.0)) + skyE) / 3.14159);
    #line 261
    highp vec3 R_ftot = ((W * l) * 0.4);
    highp vec3 surfaceColor = ((((sunReflectionMultiplier * Lsun) + (skyReflectionMultiplier * Lsky)) + (seaRefractionMultiplier * Lsea)) + R_ftot);
    #line 267
    highp vec3 inscatter = InScattering( earthCamera, earthP, L, extinction, 0.0);
    highp vec3 finalColor = (surfaceColor * extinction);
    return vec4( hdr( finalColor), outAlpha);
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main() {
    highp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.oceanU = vec2(xlv_TEXCOORD0);
    xlt_IN.oceanP = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:131(2): warning: empty declaration
0:65(2): warning: empty declaration
0:105(39): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
0:231(50): error: `_Ocean_Variance' undeclared
0:0(0): error: no matching function for call to `texture3D(error, vec3)'
0:231(74): error: type mismatch
0:231(88): error: operands to arithmetic operators must be numeric
*/


#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
uniform highp float _Ocean_Radius;
uniform highp vec3 _Ocean_Horizon1;
uniform highp vec3 _Ocean_Horizon2;
uniform highp float _Ocean_HeightOffset;
uniform highp vec3 _Ocean_CameraPos;
uniform highp mat4 _Ocean_OceanToCamera;
uniform highp mat4 _Ocean_CameraToOcean;
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Globals_CameraToScreen;
uniform highp vec2 _Ocean_MapSize;
uniform highp vec4 _Ocean_Choppyness;
uniform highp vec4 _Ocean_GridSizes;
uniform highp vec2 _Ocean_ScreenGridSize;
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map3;
uniform sampler2D _Ocean_Map4;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 dP_1;
  highp vec4 vert_2;
  vert_2.zw = _glesVertex.zw;
  vert_2.xy = (_glesVertex.xy * 1.25);
  highp vec2 tmpvar_3;
  highp float t_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 1.0);
  tmpvar_5.x = vert_2.x;
  tmpvar_5.y = min (vert_2.y, ((_Ocean_Horizon1.x + (_Ocean_Horizon1.y * vert_2.x)) - sqrt((_Ocean_Horizon2.x + ((_Ocean_Horizon2.y + (_Ocean_Horizon2.z * vert_2.x)) * vert_2.x)))));
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_Globals_ScreenToCamera * tmpvar_5).xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = tmpvar_6;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_Ocean_CameraToOcean * tmpvar_7).xyz;
  if ((_Ocean_Radius == 0.0)) {
    t_4 = ((_Ocean_HeightOffset + -(_Ocean_CameraPos.z)) / tmpvar_8.z);
  } else {
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_8.z * (_Ocean_CameraPos.z + _Ocean_Radius));
    highp float tmpvar_10;
    tmpvar_10 = (-(tmpvar_9) - sqrt(max (((tmpvar_9 * tmpvar_9) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
    highp float tmpvar_11;
    tmpvar_11 = ((-(_Ocean_CameraPos.z) / tmpvar_8.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_8.z * tmpvar_8.z)))));
    highp float tmpvar_12;
    tmpvar_12 = abs(((tmpvar_11 - tmpvar_10) * tmpvar_8.z));
    highp float tmpvar_13;
    if ((tmpvar_12 < 1.0)) {
      tmpvar_13 = tmpvar_11;
    } else {
      tmpvar_13 = tmpvar_10;
    };
    t_4 = tmpvar_13;
  };
  tmpvar_3 = (_Ocean_CameraPos.xy + (t_4 * tmpvar_8.xy));
  highp vec4 tmpvar_14;
  tmpvar_14.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_14.x = _Ocean_ScreenGridSize.x;
  highp vec4 vert_15;
  vert_15 = (vert_2 + tmpvar_14);
  highp float t_16;
  highp vec4 tmpvar_17;
  tmpvar_17.zw = vec2(0.0, 1.0);
  tmpvar_17.x = vert_15.x;
  tmpvar_17.y = min (vert_15.y, ((_Ocean_Horizon1.x + (_Ocean_Horizon1.y * vert_15.x)) - sqrt((_Ocean_Horizon2.x + ((_Ocean_Horizon2.y + (_Ocean_Horizon2.z * vert_15.x)) * vert_15.x)))));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = normalize((_Globals_ScreenToCamera * tmpvar_17).xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = (_Ocean_CameraToOcean * tmpvar_18).xyz;
  if ((_Ocean_Radius == 0.0)) {
    t_16 = ((_Ocean_HeightOffset + -(_Ocean_CameraPos.z)) / tmpvar_19.z);
  } else {
    highp float tmpvar_20;
    tmpvar_20 = (tmpvar_19.z * (_Ocean_CameraPos.z + _Ocean_Radius));
    highp float tmpvar_21;
    tmpvar_21 = (-(tmpvar_20) - sqrt(max (((tmpvar_20 * tmpvar_20) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
    highp float tmpvar_22;
    tmpvar_22 = ((-(_Ocean_CameraPos.z) / tmpvar_19.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_19.z * tmpvar_19.z)))));
    highp float tmpvar_23;
    tmpvar_23 = abs(((tmpvar_22 - tmpvar_21) * tmpvar_19.z));
    highp float tmpvar_24;
    if ((tmpvar_23 < 1.0)) {
      tmpvar_24 = tmpvar_22;
    } else {
      tmpvar_24 = tmpvar_21;
    };
    t_16 = tmpvar_24;
  };
  highp vec2 tmpvar_25;
  tmpvar_25 = ((_Ocean_CameraPos.xy + (t_16 * tmpvar_19.xy)) - tmpvar_3);
  highp vec4 tmpvar_26;
  tmpvar_26.xzw = vec3(0.0, 0.0, 0.0);
  tmpvar_26.y = _Ocean_ScreenGridSize.y;
  highp vec4 vert_27;
  vert_27 = (vert_2 + tmpvar_26);
  highp float t_28;
  highp vec4 tmpvar_29;
  tmpvar_29.zw = vec2(0.0, 1.0);
  tmpvar_29.x = vert_27.x;
  tmpvar_29.y = min (vert_27.y, ((_Ocean_Horizon1.x + (_Ocean_Horizon1.y * vert_27.x)) - sqrt((_Ocean_Horizon2.x + ((_Ocean_Horizon2.y + (_Ocean_Horizon2.z * vert_27.x)) * vert_27.x)))));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = normalize((_Globals_ScreenToCamera * tmpvar_29).xyz);
  highp vec3 tmpvar_31;
  tmpvar_31 = (_Ocean_CameraToOcean * tmpvar_30).xyz;
  if ((_Ocean_Radius == 0.0)) {
    t_28 = ((_Ocean_HeightOffset + -(_Ocean_CameraPos.z)) / tmpvar_31.z);
  } else {
    highp float tmpvar_32;
    tmpvar_32 = (tmpvar_31.z * (_Ocean_CameraPos.z + _Ocean_Radius));
    highp float tmpvar_33;
    tmpvar_33 = (-(tmpvar_32) - sqrt(max (((tmpvar_32 * tmpvar_32) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
    highp float tmpvar_34;
    tmpvar_34 = ((-(_Ocean_CameraPos.z) / tmpvar_31.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_31.z * tmpvar_31.z)))));
    highp float tmpvar_35;
    tmpvar_35 = abs(((tmpvar_34 - tmpvar_33) * tmpvar_31.z));
    highp float tmpvar_36;
    if ((tmpvar_35 < 1.0)) {
      tmpvar_36 = tmpvar_34;
    } else {
      tmpvar_36 = tmpvar_33;
    };
    t_28 = tmpvar_36;
  };
  highp vec2 tmpvar_37;
  tmpvar_37 = ((_Ocean_CameraPos.xy + (t_28 * tmpvar_31.xy)) - tmpvar_3);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, 0.0);
  tmpvar_38.z = _Ocean_HeightOffset;
  dP_1 = tmpvar_38;
  if (((tmpvar_37.x != 0.0) || (tmpvar_37.y != 0.0))) {
    highp vec4 tmpvar_39;
    highp vec2 tmpvar_40;
    tmpvar_40 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.x));
    highp vec2 tmpvar_41;
    tmpvar_41 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.x));
    highp vec4 tmpvar_42;
    tmpvar_42.z = 0.0;
    tmpvar_42.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_42.w = (0.5 * log2(max (dot (tmpvar_40, tmpvar_40), dot (tmpvar_41, tmpvar_41))));
    lowp vec4 tmpvar_43;
    tmpvar_43 = textureLod (_Ocean_Map0, tmpvar_42.xy, tmpvar_42.w);
    tmpvar_39 = tmpvar_43;
    dP_1.z = (_Ocean_HeightOffset + tmpvar_39.x);
    highp vec4 tmpvar_44;
    highp vec2 tmpvar_45;
    tmpvar_45 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.y));
    highp vec2 tmpvar_46;
    tmpvar_46 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.y));
    highp vec4 tmpvar_47;
    tmpvar_47.z = 0.0;
    tmpvar_47.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_47.w = (0.5 * log2(max (dot (tmpvar_45, tmpvar_45), dot (tmpvar_46, tmpvar_46))));
    lowp vec4 tmpvar_48;
    tmpvar_48 = textureLod (_Ocean_Map0, tmpvar_47.xy, tmpvar_47.w);
    tmpvar_44 = tmpvar_48;
    dP_1.z = (dP_1.z + tmpvar_44.y);
    highp vec4 tmpvar_49;
    highp vec2 tmpvar_50;
    tmpvar_50 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.z));
    highp vec2 tmpvar_51;
    tmpvar_51 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.z));
    highp vec4 tmpvar_52;
    tmpvar_52.z = 0.0;
    tmpvar_52.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_52.w = (0.5 * log2(max (dot (tmpvar_50, tmpvar_50), dot (tmpvar_51, tmpvar_51))));
    lowp vec4 tmpvar_53;
    tmpvar_53 = textureLod (_Ocean_Map0, tmpvar_52.xy, tmpvar_52.w);
    tmpvar_49 = tmpvar_53;
    dP_1.z = (dP_1.z + tmpvar_49.z);
    highp vec4 tmpvar_54;
    highp vec2 tmpvar_55;
    tmpvar_55 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.w));
    highp vec2 tmpvar_56;
    tmpvar_56 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.w));
    highp vec4 tmpvar_57;
    tmpvar_57.z = 0.0;
    tmpvar_57.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_57.w = (0.5 * log2(max (dot (tmpvar_55, tmpvar_55), dot (tmpvar_56, tmpvar_56))));
    lowp vec4 tmpvar_58;
    tmpvar_58 = textureLod (_Ocean_Map0, tmpvar_57.xy, tmpvar_57.w);
    tmpvar_54 = tmpvar_58;
    dP_1.z = (dP_1.z + tmpvar_54.w);
    highp vec4 tmpvar_59;
    highp vec2 tmpvar_60;
    tmpvar_60 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.x));
    highp vec2 tmpvar_61;
    tmpvar_61 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.x));
    highp vec4 tmpvar_62;
    tmpvar_62.z = 0.0;
    tmpvar_62.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_62.w = (0.5 * log2(max (dot (tmpvar_60, tmpvar_60), dot (tmpvar_61, tmpvar_61))));
    lowp vec4 tmpvar_63;
    tmpvar_63 = textureLod (_Ocean_Map3, tmpvar_62.xy, tmpvar_62.w);
    tmpvar_59 = tmpvar_63;
    dP_1.xy = (_Ocean_Choppyness.x * tmpvar_59.xy);
    highp vec4 tmpvar_64;
    highp vec2 tmpvar_65;
    tmpvar_65 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.y));
    highp vec2 tmpvar_66;
    tmpvar_66 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.y));
    highp vec4 tmpvar_67;
    tmpvar_67.z = 0.0;
    tmpvar_67.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_67.w = (0.5 * log2(max (dot (tmpvar_65, tmpvar_65), dot (tmpvar_66, tmpvar_66))));
    lowp vec4 tmpvar_68;
    tmpvar_68 = textureLod (_Ocean_Map3, tmpvar_67.xy, tmpvar_67.w);
    tmpvar_64 = tmpvar_68;
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.y * tmpvar_64.zw));
    highp vec4 tmpvar_69;
    highp vec2 tmpvar_70;
    tmpvar_70 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.z));
    highp vec2 tmpvar_71;
    tmpvar_71 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.z));
    highp vec4 tmpvar_72;
    tmpvar_72.z = 0.0;
    tmpvar_72.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_72.w = (0.5 * log2(max (dot (tmpvar_70, tmpvar_70), dot (tmpvar_71, tmpvar_71))));
    lowp vec4 tmpvar_73;
    tmpvar_73 = textureLod (_Ocean_Map4, tmpvar_72.xy, tmpvar_72.w);
    tmpvar_69 = tmpvar_73;
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.z * tmpvar_69.xy));
    highp vec4 tmpvar_74;
    highp vec2 tmpvar_75;
    tmpvar_75 = (_Ocean_MapSize.x * (tmpvar_25 / _Ocean_GridSizes.w));
    highp vec2 tmpvar_76;
    tmpvar_76 = (_Ocean_MapSize.y * (tmpvar_37 / _Ocean_GridSizes.w));
    highp vec4 tmpvar_77;
    tmpvar_77.z = 0.0;
    tmpvar_77.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_77.w = (0.5 * log2(max (dot (tmpvar_75, tmpvar_75), dot (tmpvar_76, tmpvar_76))));
    lowp vec4 tmpvar_78;
    tmpvar_78 = textureLod (_Ocean_Map4, tmpvar_77.xy, tmpvar_77.w);
    tmpvar_74 = tmpvar_78;
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.w * tmpvar_74.zw));
  };
  mat3 tmpvar_79;
  tmpvar_79[0] = _Ocean_OceanToCamera[0].xyz;
  tmpvar_79[1] = _Ocean_OceanToCamera[1].xyz;
  tmpvar_79[2] = _Ocean_OceanToCamera[2].xyz;
  highp vec4 tmpvar_80;
  tmpvar_80.w = 1.0;
  tmpvar_80.xyz = ((t_4 * tmpvar_6) + (tmpvar_79 * dP_1));
  highp vec3 tmpvar_81;
  tmpvar_81.xy = vec2(0.0, 0.0);
  tmpvar_81.z = _Ocean_CameraPos.z;
  gl_Position = (_Globals_CameraToScreen * tmpvar_80);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (((t_4 * tmpvar_8) + dP_1) + tmpvar_81);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp float _Exposure;
uniform highp float scale;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp float _Sun_Intensity;
uniform sampler2D _Sky_Transmittance;
uniform sampler2D _Sky_Irradiance;
uniform sampler2D _Sky_Inscatter;
uniform highp float _Ocean_Radius;
uniform highp vec3 _Ocean_CameraPos;
uniform highp vec3 _Ocean_SunDir;
uniform highp vec3 _Ocean_Color;
uniform highp vec4 _Ocean_GridSizes;
uniform highp float _Ocean_WhiteCapStr;
uniform highp float farWhiteCapStr;
uniform lowp sampler3D _Ocean_Variance;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
uniform highp float _OceanAlpha;
uniform highp float alphaRadius;
uniform highp float sunReflectionMultiplier;
uniform highp float skyReflectionMultiplier;
uniform highp float seaRefractionMultiplier;
uniform highp vec2 _VarianceMax;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 surfaceColor_1;
  highp vec2 jm4_2;
  highp vec2 jm3_3;
  highp vec2 jm2_4;
  highp vec2 jm1_5;
  highp vec3 N_6;
  highp vec2 slopes_7;
  highp float outAlpha_8;
  highp vec3 tmpvar_9;
  tmpvar_9.xy = vec2(0.0, 0.0);
  tmpvar_9.z = (_Ocean_CameraPos.z + _Ocean_Radius);
  highp vec3 tmpvar_10;
  if ((_Ocean_Radius > 0.0)) {
    highp vec3 tmpvar_11;
    tmpvar_11.xy = vec2(0.0, 0.0);
    tmpvar_11.z = _Ocean_Radius;
    tmpvar_10 = (normalize((xlv_TEXCOORD1 + tmpvar_11)) * (_Ocean_Radius + 10.0));
  } else {
    tmpvar_10 = xlv_TEXCOORD1;
  };
  highp vec3 arg0_12;
  arg0_12 = (tmpvar_10 - tmpvar_9);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((sqrt(dot (arg0_12, arg0_12)) / alphaRadius), 0.0, 1.0);
  outAlpha_8 = mix (_OceanAlpha, 1.0, tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = mix (_Ocean_WhiteCapStr, farWhiteCapStr, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15.xy = vec2(0.0, 0.0);
  tmpvar_15.z = _Ocean_CameraPos.z;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 - xlv_TEXCOORD1));
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 / _Ocean_GridSizes.x);
  tmpvar_17 = texture (_Ocean_Map1, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 / _Ocean_GridSizes.y);
  tmpvar_19 = texture (_Ocean_Map1, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 / _Ocean_GridSizes.z);
  tmpvar_21 = texture (_Ocean_Map2, P_22);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 / _Ocean_GridSizes.w);
  tmpvar_23 = texture (_Ocean_Map2, P_24);
  highp vec2 tmpvar_25;
  tmpvar_25 = (((tmpvar_17.xy + tmpvar_19.zw) + tmpvar_21.xy) + tmpvar_23.zw);
  slopes_7 = tmpvar_25;
  if ((_Ocean_Radius > 0.0)) {
    slopes_7 = (tmpvar_25 - (xlv_TEXCOORD1.xy / (_Ocean_Radius + xlv_TEXCOORD1.z)));
  };
  highp vec3 tmpvar_26;
  tmpvar_26.z = 1.0;
  tmpvar_26.x = -(slopes_7.x);
  tmpvar_26.y = -(slopes_7.y);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_26);
  N_6 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (tmpvar_16, tmpvar_27);
  if ((tmpvar_28 < 0.0)) {
    N_6 = (tmpvar_27 - (2.0 * (dot (tmpvar_16, tmpvar_27) * tmpvar_16)));
  };
  highp float tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD0.x);
  highp float tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD0.x);
  highp float tmpvar_31;
  tmpvar_31 = dFdx(xlv_TEXCOORD0.y);
  highp float tmpvar_32;
  tmpvar_32 = dFdy(xlv_TEXCOORD0.y);
  highp float tmpvar_33;
  tmpvar_33 = ((tmpvar_29 * tmpvar_29) + (tmpvar_31 * tmpvar_31));
  highp float tmpvar_34;
  tmpvar_34 = ((tmpvar_30 * tmpvar_30) + (tmpvar_32 * tmpvar_32));
  highp vec3 tmpvar_35;
  tmpvar_35.x = pow ((tmpvar_33 / 10.0), 0.25);
  tmpvar_35.y = (0.5 + ((0.5 * ((tmpvar_29 * tmpvar_30) + (tmpvar_31 * tmpvar_32))) / sqrt((tmpvar_33 * tmpvar_34))));
  tmpvar_35.z = pow ((tmpvar_34 / 10.0), 0.25);
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture (_Ocean_Variance, tmpvar_35);
  highp vec2 tmpvar_37;
  tmpvar_37 = max ((tmpvar_36.xy * _VarianceMax), vec2(2e-05, 2e-05));
  highp vec3 worldP_38;
  highp float r_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_10 * scale);
  worldP_38 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_40, tmpvar_40));
  r_39 = tmpvar_41;
  if ((tmpvar_41 < (0.9 * Rg))) {
    worldP_38.z = (tmpvar_40.z + Rg);
    r_39 = sqrt(dot (worldP_38, worldP_38));
  };
  highp vec3 tmpvar_42;
  tmpvar_42 = (worldP_38 / r_39);
  highp float tmpvar_43;
  tmpvar_43 = dot (tmpvar_42, _Ocean_SunDir);
  highp float tmpvar_44;
  tmpvar_44 = sqrt((1.0 - ((Rg / r_39) * (Rg / r_39))));
  highp vec3 tmpvar_45;
  if ((tmpvar_43 < -(tmpvar_44))) {
    tmpvar_45 = vec3(0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_46;
    highp float y_over_x_47;
    y_over_x_47 = (((tmpvar_43 + 0.15) / 1.15) * 14.1014);
    highp float x_48;
    x_48 = (y_over_x_47 * inversesqrt(((y_over_x_47 * y_over_x_47) + 1.0)));
    highp vec2 tmpvar_49;
    tmpvar_49.x = ((sign(x_48) * (1.5708 - (sqrt((1.0 - abs(x_48))) * (1.5708 + (abs(x_48) * (-0.214602 + (abs(x_48) * (0.0865667 + (abs(x_48) * -0.0310296))))))))) / 1.5);
    tmpvar_49.y = sqrt(((r_39 - Rg) / (Rt - Rg)));
    lowp vec4 tmpvar_50;
    tmpvar_50 = textureLod (_Sky_Transmittance, tmpvar_49, 0.0);
    tmpvar_46 = tmpvar_50.xyz;
    tmpvar_45 = tmpvar_46;
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_45 * _Sun_Intensity);
  highp vec3 tmpvar_52;
  highp vec2 tmpvar_53;
  tmpvar_53.x = ((tmpvar_43 + 0.2) / 1.2);
  tmpvar_53.y = ((r_39 - Rg) / (Rt - Rg));
  lowp vec4 tmpvar_54;
  tmpvar_54 = textureLod (_Sky_Irradiance, tmpvar_53, 0.0);
  tmpvar_52 = tmpvar_54.xyz;
  highp vec3 tmpvar_55;
  tmpvar_55 = ((2.0 * (tmpvar_52 * _Sun_Intensity)) * ((1.0 + dot (tmpvar_42, N_6)) * 0.5));
  highp float tmpvar_56;
  tmpvar_56 = sqrt(tmpvar_37.x);
  highp vec3 tmpvar_57;
  tmpvar_57 = (((pow ((1.0 - dot (tmpvar_16, N_6)), (5.0 * exp((-2.69 * tmpvar_56)))) / (1.0 + (22.7 * pow (tmpvar_56, 1.5)))) * tmpvar_55) / 3.14159);
  highp vec3 tmpvar_58;
  tmpvar_58 = normalize((_Ocean_SunDir + tmpvar_16));
  highp float tmpvar_59;
  tmpvar_59 = dot (tmpvar_58, N_6);
  highp float tmpvar_60;
  tmpvar_60 = (exp(((-2.0 * ((1.0 - (tmpvar_59 * tmpvar_59)) / tmpvar_37.x)) / (1.0 + tmpvar_59))) / (12.5664 * tmpvar_37.x));
  highp float tmpvar_61;
  tmpvar_61 = (1.0 - dot (tmpvar_16, tmpvar_58));
  highp float tmpvar_62;
  tmpvar_62 = (tmpvar_61 * tmpvar_61);
  highp float tmpvar_63;
  tmpvar_63 = (0.02 + (((0.98 * tmpvar_62) * tmpvar_62) * tmpvar_61));
  highp float tmpvar_64;
  tmpvar_64 = max (dot (_Ocean_SunDir, N_6), 0.01);
  highp float tmpvar_65;
  tmpvar_65 = max (dot (tmpvar_16, N_6), 0.01);
  highp float tmpvar_66;
  if ((tmpvar_64 <= 0.0)) {
    tmpvar_66 = 0.0;
  } else {
    tmpvar_66 = max (((tmpvar_63 * tmpvar_60) * sqrt(abs((tmpvar_64 / tmpvar_65)))), 0.0);
  };
  highp float tmpvar_67;
  tmpvar_67 = sqrt(tmpvar_37.x);
  highp vec2 P_68;
  P_68 = (xlv_TEXCOORD0 / _Ocean_GridSizes.x);
  lowp vec2 tmpvar_69;
  tmpvar_69 = texture (_Ocean_Foam0, P_68).xy;
  jm1_5 = tmpvar_69;
  highp vec2 P_70;
  P_70 = (xlv_TEXCOORD0 / _Ocean_GridSizes.y);
  lowp vec2 tmpvar_71;
  tmpvar_71 = texture (_Ocean_Foam0, P_70).zw;
  jm2_4 = tmpvar_71;
  highp vec2 P_72;
  P_72 = (xlv_TEXCOORD0 / _Ocean_GridSizes.z);
  lowp vec2 tmpvar_73;
  tmpvar_73 = texture (_Ocean_Foam1, P_72).xy;
  jm3_3 = tmpvar_73;
  highp vec2 P_74;
  P_74 = (xlv_TEXCOORD0 / _Ocean_GridSizes.w);
  lowp vec2 tmpvar_75;
  tmpvar_75 = texture (_Ocean_Foam1, P_74).zw;
  jm4_2 = tmpvar_75;
  highp vec2 tmpvar_76;
  tmpvar_76 = (((jm1_5 + jm2_4) + jm3_3) + jm4_2);
  highp float x_77;
  x_77 = ((0.707107 * (tmpvar_14 - tmpvar_76.x)) * inversesqrt(max ((tmpvar_76.y - ((((jm1_5.x * jm1_5.x) + (jm2_4.x * jm2_4.x)) + (jm3_3.x * jm3_3.x)) + (jm4_2.x * jm4_2.x))), 0.0)));
  highp float tmpvar_78;
  tmpvar_78 = (x_77 * x_77);
  highp float tmpvar_79;
  tmpvar_79 = (0.140012 * tmpvar_78);
  surfaceColor_1 = ((((sunReflectionMultiplier * (tmpvar_66 * tmpvar_51)) + (skyReflectionMultiplier * tmpvar_57)) + (seaRefractionMultiplier * ((((0.98 * (1.0 - (pow ((1.0 - dot (tmpvar_16, N_6)), (5.0 * exp((-2.69 * tmpvar_67)))) / (1.0 + (22.7 * pow (tmpvar_67, 1.5)))))) * _Ocean_Color) * tmpvar_55) / 3.14159))) + ((((0.5 * (sign(x_77) * sqrt((1.0 - exp(((-(tmpvar_78) * (1.27324 + tmpvar_79)) / (1.0 + tmpvar_79))))))) + 0.5) * (((tmpvar_51 * max (dot (N_6, _Ocean_SunDir), 0.0)) + tmpvar_55) / 3.14159)) * 0.4));
  highp vec3 camera_80;
  highp vec3 _point_81;
  highp vec3 extinction_82;
  highp float mu_83;
  highp float rMu_84;
  highp float r_85;
  highp float d_86;
  highp vec3 tmpvar_87;
  tmpvar_87 = (tmpvar_9 * scale);
  camera_80 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = (tmpvar_10 * scale);
  _point_81 = tmpvar_88;
  highp vec3 tmpvar_89;
  tmpvar_89 = (tmpvar_88 - tmpvar_87);
  highp float tmpvar_90;
  tmpvar_90 = sqrt(dot (tmpvar_89, tmpvar_89));
  d_86 = tmpvar_90;
  highp vec3 tmpvar_91;
  tmpvar_91 = (tmpvar_89 / tmpvar_90);
  highp float tmpvar_92;
  tmpvar_92 = sqrt(dot (tmpvar_87, tmpvar_87));
  r_85 = tmpvar_92;
  if ((tmpvar_92 < (0.9 * Rg))) {
    camera_80.z = (tmpvar_87.z + Rg);
    _point_81.z = (tmpvar_88.z + Rg);
    r_85 = sqrt(dot (camera_80, camera_80));
  };
  highp float tmpvar_93;
  tmpvar_93 = dot (camera_80, tmpvar_91);
  rMu_84 = tmpvar_93;
  mu_83 = (tmpvar_93 / r_85);
  highp vec3 tmpvar_94;
  tmpvar_94 = (_point_81 - (tmpvar_91 * clamp (0.0, 0.0, tmpvar_90)));
  _point_81 = tmpvar_94;
  highp float f_95;
  f_95 = (((tmpvar_93 * tmpvar_93) - (r_85 * r_85)) + (Rt * Rt));
  highp float tmpvar_96;
  if ((f_95 >= 0.0)) {
    tmpvar_96 = sqrt(f_95);
  } else {
    tmpvar_96 = 1e+30;
  };
  highp float tmpvar_97;
  tmpvar_97 = max ((-(tmpvar_93) - tmpvar_96), 0.0);
  if (((tmpvar_97 > 0.0) && (tmpvar_97 < tmpvar_90))) {
    camera_80 = (camera_80 + (tmpvar_97 * tmpvar_91));
    highp float tmpvar_98;
    tmpvar_98 = (tmpvar_93 + tmpvar_97);
    rMu_84 = tmpvar_98;
    mu_83 = (tmpvar_98 / Rt);
    r_85 = Rt;
    d_86 = (tmpvar_90 - tmpvar_97);
  };
  if ((r_85 <= Rt)) {
    highp float muS1_99;
    highp float mu1_100;
    highp float r1_101;
    highp vec4 inScatter_102;
    highp float tmpvar_103;
    tmpvar_103 = dot (tmpvar_91, _Ocean_SunDir);
    highp float tmpvar_104;
    tmpvar_104 = (dot (camera_80, _Ocean_SunDir) / r_85);
    if ((r_85 < (Rg + 2000.0))) {
      highp float tmpvar_105;
      tmpvar_105 = ((Rg + 2000.0) / r_85);
      r_85 = (r_85 * tmpvar_105);
      rMu_84 = (rMu_84 * tmpvar_105);
      _point_81 = (tmpvar_94 * tmpvar_105);
    };
    highp float tmpvar_106;
    tmpvar_106 = sqrt(dot (_point_81, _point_81));
    r1_101 = tmpvar_106;
    highp float tmpvar_107;
    tmpvar_107 = (dot (_point_81, tmpvar_91) / tmpvar_106);
    mu1_100 = tmpvar_107;
    muS1_99 = (dot (_point_81, _Ocean_SunDir) / tmpvar_106);
    if ((mu_83 > 0.0)) {
      highp vec3 tmpvar_108;
      highp float y_over_x_109;
      y_over_x_109 = (((mu_83 + 0.15) / 1.15) * 14.1014);
      highp float x_110;
      x_110 = (y_over_x_109 * inversesqrt(((y_over_x_109 * y_over_x_109) + 1.0)));
      highp vec2 tmpvar_111;
      tmpvar_111.x = ((sign(x_110) * (1.5708 - (sqrt((1.0 - abs(x_110))) * (1.5708 + (abs(x_110) * (-0.214602 + (abs(x_110) * (0.0865667 + (abs(x_110) * -0.0310296))))))))) / 1.5);
      tmpvar_111.y = sqrt(((r_85 - Rg) / (Rt - Rg)));
      lowp vec4 tmpvar_112;
      tmpvar_112 = textureLod (_Sky_Transmittance, tmpvar_111, 0.0);
      tmpvar_108 = tmpvar_112.xyz;
      highp vec3 tmpvar_113;
      highp float y_over_x_114;
      y_over_x_114 = (((tmpvar_107 + 0.15) / 1.15) * 14.1014);
      highp float x_115;
      x_115 = (y_over_x_114 * inversesqrt(((y_over_x_114 * y_over_x_114) + 1.0)));
      highp vec2 tmpvar_116;
      tmpvar_116.x = ((sign(x_115) * (1.5708 - (sqrt((1.0 - abs(x_115))) * (1.5708 + (abs(x_115) * (-0.214602 + (abs(x_115) * (0.0865667 + (abs(x_115) * -0.0310296))))))))) / 1.5);
      tmpvar_116.y = sqrt(((tmpvar_106 - Rg) / (Rt - Rg)));
      lowp vec4 tmpvar_117;
      tmpvar_117 = textureLod (_Sky_Transmittance, tmpvar_116, 0.0);
      tmpvar_113 = tmpvar_117.xyz;
      extinction_82 = min ((tmpvar_108 / tmpvar_113), vec3(1.0, 1.0, 1.0));
    } else {
      highp vec3 tmpvar_118;
      highp float y_over_x_119;
      y_over_x_119 = (((-(tmpvar_107) + 0.15) / 1.15) * 14.1014);
      highp float x_120;
      x_120 = (y_over_x_119 * inversesqrt(((y_over_x_119 * y_over_x_119) + 1.0)));
      highp vec2 tmpvar_121;
      tmpvar_121.x = ((sign(x_120) * (1.5708 - (sqrt((1.0 - abs(x_120))) * (1.5708 + (abs(x_120) * (-0.214602 + (abs(x_120) * (0.0865667 + (abs(x_120) * -0.0310296))))))))) / 1.5);
      tmpvar_121.y = sqrt(((tmpvar_106 - Rg) / (Rt - Rg)));
      lowp vec4 tmpvar_122;
      tmpvar_122 = textureLod (_Sky_Transmittance, tmpvar_121, 0.0);
      tmpvar_118 = tmpvar_122.xyz;
      highp vec3 tmpvar_123;
      highp float y_over_x_124;
      y_over_x_124 = (((-(mu_83) + 0.15) / 1.15) * 14.1014);
      highp float x_125;
      x_125 = (y_over_x_124 * inversesqrt(((y_over_x_124 * y_over_x_124) + 1.0)));
      highp vec2 tmpvar_126;
      tmpvar_126.x = ((sign(x_125) * (1.5708 - (sqrt((1.0 - abs(x_125))) * (1.5708 + (abs(x_125) * (-0.214602 + (abs(x_125) * (0.0865667 + (abs(x_125) * -0.0310296))))))))) / 1.5);
      tmpvar_126.y = sqrt(((r_85 - Rg) / (Rt - Rg)));
      lowp vec4 tmpvar_127;
      tmpvar_127 = textureLod (_Sky_Transmittance, tmpvar_126, 0.0);
      tmpvar_123 = tmpvar_127.xyz;
      extinction_82 = min ((tmpvar_118 / tmpvar_123), vec3(1.0, 1.0, 1.0));
    };
    highp float tmpvar_128;
    tmpvar_128 = -(sqrt((1.0 - ((Rg / r_85) * (Rg / r_85)))));
    highp float tmpvar_129;
    tmpvar_129 = abs((mu_83 - tmpvar_128));
    if ((tmpvar_129 < 0.004)) {
      highp vec4 inScatterA_130;
      highp vec4 inScatter0_131;
      highp float a_132;
      a_132 = (((mu_83 - tmpvar_128) + 0.004) / 0.008);
      highp float tmpvar_133;
      tmpvar_133 = (tmpvar_128 - 0.004);
      mu_83 = tmpvar_133;
      highp float tmpvar_134;
      tmpvar_134 = sqrt((((r_85 * r_85) + (d_86 * d_86)) + (((2.0 * r_85) * d_86) * tmpvar_133)));
      r1_101 = tmpvar_134;
      mu1_100 = (((r_85 * tmpvar_133) + d_86) / tmpvar_134);
      highp float uMu_135;
      highp float uR_136;
      highp float tmpvar_137;
      tmpvar_137 = sqrt(((Rt * Rt) - (Rg * Rg)));
      highp float tmpvar_138;
      tmpvar_138 = sqrt(((r_85 * r_85) - (Rg * Rg)));
      highp float tmpvar_139;
      tmpvar_139 = (r_85 * tmpvar_133);
      highp float tmpvar_140;
      tmpvar_140 = (((tmpvar_139 * tmpvar_139) - (r_85 * r_85)) + (Rg * Rg));
      highp vec4 tmpvar_141;
      if (((tmpvar_139 < 0.0) && (tmpvar_140 > 0.0))) {
        highp vec4 tmpvar_142;
        tmpvar_142.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_142.w = (0.5 - (0.5 / RES_MU));
        tmpvar_141 = tmpvar_142;
      } else {
        highp vec4 tmpvar_143;
        tmpvar_143.x = -1.0;
        tmpvar_143.y = (tmpvar_137 * tmpvar_137);
        tmpvar_143.z = tmpvar_137;
        tmpvar_143.w = (0.5 + (0.5 / RES_MU));
        tmpvar_141 = tmpvar_143;
      };
      uR_136 = ((0.5 / RES_R) + ((tmpvar_138 / tmpvar_137) * (1.0 - (1.0/(RES_R)))));
      uMu_135 = (tmpvar_141.w + ((((tmpvar_139 * tmpvar_141.x) + sqrt((tmpvar_140 + tmpvar_141.y))) / (tmpvar_138 + tmpvar_141.z)) * (0.5 - (1.0/(RES_MU)))));
      highp float y_over_x_144;
      y_over_x_144 = (max (tmpvar_104, -0.1975) * 5.34962);
      highp float x_145;
      x_145 = (y_over_x_144 * inversesqrt(((y_over_x_144 * y_over_x_144) + 1.0)));
      highp float tmpvar_146;
      tmpvar_146 = ((0.5 / RES_MU_S) + (((((sign(x_145) * (1.5708 - (sqrt((1.0 - abs(x_145))) * (1.5708 + (abs(x_145) * (-0.214602 + (abs(x_145) * (0.0865667 + (abs(x_145) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
      highp float tmpvar_147;
      tmpvar_147 = (((tmpvar_103 + 1.0) / 2.0) * (RES_NU - 1.0));
      highp float tmpvar_148;
      tmpvar_148 = floor(tmpvar_147);
      highp float tmpvar_149;
      tmpvar_149 = (tmpvar_147 - tmpvar_148);
      highp float tmpvar_150;
      tmpvar_150 = (floor(((uR_136 * RES_R) - 1.0)) / RES_R);
      highp float tmpvar_151;
      tmpvar_151 = (floor((uR_136 * RES_R)) / RES_R);
      highp float tmpvar_152;
      tmpvar_152 = fract((uR_136 * RES_R));
      highp vec4 tmpvar_153;
      tmpvar_153.zw = vec2(0.0, 0.0);
      tmpvar_153.x = ((tmpvar_148 + tmpvar_146) / RES_NU);
      tmpvar_153.y = ((uMu_135 / RES_R) + tmpvar_150);
      lowp vec4 tmpvar_154;
      tmpvar_154 = textureLod (_Sky_Inscatter, tmpvar_153.xy, 0.0);
      highp vec4 tmpvar_155;
      tmpvar_155.zw = vec2(0.0, 0.0);
      tmpvar_155.x = (((tmpvar_148 + tmpvar_146) + 1.0) / RES_NU);
      tmpvar_155.y = ((uMu_135 / RES_R) + tmpvar_150);
      lowp vec4 tmpvar_156;
      tmpvar_156 = textureLod (_Sky_Inscatter, tmpvar_155.xy, 0.0);
      highp vec4 tmpvar_157;
      tmpvar_157.zw = vec2(0.0, 0.0);
      tmpvar_157.x = ((tmpvar_148 + tmpvar_146) / RES_NU);
      tmpvar_157.y = ((uMu_135 / RES_R) + tmpvar_151);
      lowp vec4 tmpvar_158;
      tmpvar_158 = textureLod (_Sky_Inscatter, tmpvar_157.xy, 0.0);
      highp vec4 tmpvar_159;
      tmpvar_159.zw = vec2(0.0, 0.0);
      tmpvar_159.x = (((tmpvar_148 + tmpvar_146) + 1.0) / RES_NU);
      tmpvar_159.y = ((uMu_135 / RES_R) + tmpvar_151);
      lowp vec4 tmpvar_160;
      tmpvar_160 = textureLod (_Sky_Inscatter, tmpvar_159.xy, 0.0);
      inScatter0_131 = ((((tmpvar_154 * (1.0 - tmpvar_149)) + (tmpvar_156 * tmpvar_149)) * (1.0 - tmpvar_152)) + (((tmpvar_158 * (1.0 - tmpvar_149)) + (tmpvar_160 * tmpvar_149)) * tmpvar_152));
      highp float uMu_161;
      highp float uR_162;
      highp float tmpvar_163;
      tmpvar_163 = sqrt(((Rt * Rt) - (Rg * Rg)));
      highp float tmpvar_164;
      tmpvar_164 = sqrt(((tmpvar_134 * tmpvar_134) - (Rg * Rg)));
      highp float tmpvar_165;
      tmpvar_165 = (tmpvar_134 * mu1_100);
      highp float tmpvar_166;
      tmpvar_166 = (((tmpvar_165 * tmpvar_165) - (tmpvar_134 * tmpvar_134)) + (Rg * Rg));
      highp vec4 tmpvar_167;
      if (((tmpvar_165 < 0.0) && (tmpvar_166 > 0.0))) {
        highp vec4 tmpvar_168;
        tmpvar_168.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_168.w = (0.5 - (0.5 / RES_MU));
        tmpvar_167 = tmpvar_168;
      } else {
        highp vec4 tmpvar_169;
        tmpvar_169.x = -1.0;
        tmpvar_169.y = (tmpvar_163 * tmpvar_163);
        tmpvar_169.z = tmpvar_163;
        tmpvar_169.w = (0.5 + (0.5 / RES_MU));
        tmpvar_167 = tmpvar_169;
      };
      uR_162 = ((0.5 / RES_R) + ((tmpvar_164 / tmpvar_163) * (1.0 - (1.0/(RES_R)))));
      uMu_161 = (tmpvar_167.w + ((((tmpvar_165 * tmpvar_167.x) + sqrt((tmpvar_166 + tmpvar_167.y))) / (tmpvar_164 + tmpvar_167.z)) * (0.5 - (1.0/(RES_MU)))));
      highp float y_over_x_170;
      y_over_x_170 = (max (muS1_99, -0.1975) * 5.34962);
      highp float x_171;
      x_171 = (y_over_x_170 * inversesqrt(((y_over_x_170 * y_over_x_170) + 1.0)));
      highp float tmpvar_172;
      tmpvar_172 = ((0.5 / RES_MU_S) + (((((sign(x_171) * (1.5708 - (sqrt((1.0 - abs(x_171))) * (1.5708 + (abs(x_171) * (-0.214602 + (abs(x_171) * (0.0865667 + (abs(x_171) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
      highp float tmpvar_173;
      tmpvar_173 = (((tmpvar_103 + 1.0) / 2.0) * (RES_NU - 1.0));
      highp float tmpvar_174;
      tmpvar_174 = floor(tmpvar_173);
      highp float tmpvar_175;
      tmpvar_175 = (tmpvar_173 - tmpvar_174);
      highp float tmpvar_176;
      tmpvar_176 = (floor(((uR_162 * RES_R) - 1.0)) / RES_R);
      highp float tmpvar_177;
      tmpvar_177 = (floor((uR_162 * RES_R)) / RES_R);
      highp float tmpvar_178;
      tmpvar_178 = fract((uR_162 * RES_R));
      highp vec4 tmpvar_179;
      tmpvar_179.zw = vec2(0.0, 0.0);
      tmpvar_179.x = ((tmpvar_174 + tmpvar_172) / RES_NU);
      tmpvar_179.y = ((uMu_161 / RES_R) + tmpvar_176);
      lowp vec4 tmpvar_180;
      tmpvar_180 = textureLod (_Sky_Inscatter, tmpvar_179.xy, 0.0);
      highp vec4 tmpvar_181;
      tmpvar_181.zw = vec2(0.0, 0.0);
      tmpvar_181.x = (((tmpvar_174 + tmpvar_172) + 1.0) / RES_NU);
      tmpvar_181.y = ((uMu_161 / RES_R) + tmpvar_176);
      lowp vec4 tmpvar_182;
      tmpvar_182 = textureLod (_Sky_Inscatter, tmpvar_181.xy, 0.0);
      highp vec4 tmpvar_183;
      tmpvar_183.zw = vec2(0.0, 0.0);
      tmpvar_183.x = ((tmpvar_174 + tmpvar_172) / RES_NU);
      tmpvar_183.y = ((uMu_161 / RES_R) + tmpvar_177);
      lowp vec4 tmpvar_184;
      tmpvar_184 = textureLod (_Sky_Inscatter, tmpvar_183.xy, 0.0);
      highp vec4 tmpvar_185;
      tmpvar_185.zw = vec2(0.0, 0.0);
      tmpvar_185.x = (((tmpvar_174 + tmpvar_172) + 1.0) / RES_NU);
      tmpvar_185.y = ((uMu_161 / RES_R) + tmpvar_177);
      lowp vec4 tmpvar_186;
      tmpvar_186 = textureLod (_Sky_Inscatter, tmpvar_185.xy, 0.0);
      inScatterA_130 = max ((inScatter0_131 - (((((tmpvar_180 * (1.0 - tmpvar_175)) + (tmpvar_182 * tmpvar_175)) * (1.0 - tmpvar_178)) + (((tmpvar_184 * (1.0 - tmpvar_175)) + (tmpvar_186 * tmpvar_175)) * tmpvar_178)) * extinction_82.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      highp float tmpvar_187;
      tmpvar_187 = (tmpvar_128 + 0.004);
      mu_83 = tmpvar_187;
      highp float tmpvar_188;
      tmpvar_188 = sqrt((((r_85 * r_85) + (d_86 * d_86)) + (((2.0 * r_85) * d_86) * tmpvar_187)));
      r1_101 = tmpvar_188;
      mu1_100 = (((r_85 * tmpvar_187) + d_86) / tmpvar_188);
      highp float uMu_189;
      highp float uR_190;
      highp float tmpvar_191;
      tmpvar_191 = sqrt(((Rt * Rt) - (Rg * Rg)));
      highp float tmpvar_192;
      tmpvar_192 = sqrt(((r_85 * r_85) - (Rg * Rg)));
      highp float tmpvar_193;
      tmpvar_193 = (r_85 * tmpvar_187);
      highp float tmpvar_194;
      tmpvar_194 = (((tmpvar_193 * tmpvar_193) - (r_85 * r_85)) + (Rg * Rg));
      highp vec4 tmpvar_195;
      if (((tmpvar_193 < 0.0) && (tmpvar_194 > 0.0))) {
        highp vec4 tmpvar_196;
        tmpvar_196.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_196.w = (0.5 - (0.5 / RES_MU));
        tmpvar_195 = tmpvar_196;
      } else {
        highp vec4 tmpvar_197;
        tmpvar_197.x = -1.0;
        tmpvar_197.y = (tmpvar_191 * tmpvar_191);
        tmpvar_197.z = tmpvar_191;
        tmpvar_197.w = (0.5 + (0.5 / RES_MU));
        tmpvar_195 = tmpvar_197;
      };
      uR_190 = ((0.5 / RES_R) + ((tmpvar_192 / tmpvar_191) * (1.0 - (1.0/(RES_R)))));
      uMu_189 = (tmpvar_195.w + ((((tmpvar_193 * tmpvar_195.x) + sqrt((tmpvar_194 + tmpvar_195.y))) / (tmpvar_192 + tmpvar_195.z)) * (0.5 - (1.0/(RES_MU)))));
      highp float y_over_x_198;
      y_over_x_198 = (max (tmpvar_104, -0.1975) * 5.34962);
      highp float x_199;
      x_199 = (y_over_x_198 * inversesqrt(((y_over_x_198 * y_over_x_198) + 1.0)));
      highp float tmpvar_200;
      tmpvar_200 = ((0.5 / RES_MU_S) + (((((sign(x_199) * (1.5708 - (sqrt((1.0 - abs(x_199))) * (1.5708 + (abs(x_199) * (-0.214602 + (abs(x_199) * (0.0865667 + (abs(x_199) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
      highp float tmpvar_201;
      tmpvar_201 = (((tmpvar_103 + 1.0) / 2.0) * (RES_NU - 1.0));
      highp float tmpvar_202;
      tmpvar_202 = floor(tmpvar_201);
      highp float tmpvar_203;
      tmpvar_203 = (tmpvar_201 - tmpvar_202);
      highp float tmpvar_204;
      tmpvar_204 = (floor(((uR_190 * RES_R) - 1.0)) / RES_R);
      highp float tmpvar_205;
      tmpvar_205 = (floor((uR_190 * RES_R)) / RES_R);
      highp float tmpvar_206;
      tmpvar_206 = fract((uR_190 * RES_R));
      highp vec4 tmpvar_207;
      tmpvar_207.zw = vec2(0.0, 0.0);
      tmpvar_207.x = ((tmpvar_202 + tmpvar_200) / RES_NU);
      tmpvar_207.y = ((uMu_189 / RES_R) + tmpvar_204);
      lowp vec4 tmpvar_208;
      tmpvar_208 = textureLod (_Sky_Inscatter, tmpvar_207.xy, 0.0);
      highp vec4 tmpvar_209;
      tmpvar_209.zw = vec2(0.0, 0.0);
      tmpvar_209.x = (((tmpvar_202 + tmpvar_200) + 1.0) / RES_NU);
      tmpvar_209.y = ((uMu_189 / RES_R) + tmpvar_204);
      lowp vec4 tmpvar_210;
      tmpvar_210 = textureLod (_Sky_Inscatter, tmpvar_209.xy, 0.0);
      highp vec4 tmpvar_211;
      tmpvar_211.zw = vec2(0.0, 0.0);
      tmpvar_211.x = ((tmpvar_202 + tmpvar_200) / RES_NU);
      tmpvar_211.y = ((uMu_189 / RES_R) + tmpvar_205);
      lowp vec4 tmpvar_212;
      tmpvar_212 = textureLod (_Sky_Inscatter, tmpvar_211.xy, 0.0);
      highp vec4 tmpvar_213;
      tmpvar_213.zw = vec2(0.0, 0.0);
      tmpvar_213.x = (((tmpvar_202 + tmpvar_200) + 1.0) / RES_NU);
      tmpvar_213.y = ((uMu_189 / RES_R) + tmpvar_205);
      lowp vec4 tmpvar_214;
      tmpvar_214 = textureLod (_Sky_Inscatter, tmpvar_213.xy, 0.0);
      inScatter0_131 = ((((tmpvar_208 * (1.0 - tmpvar_203)) + (tmpvar_210 * tmpvar_203)) * (1.0 - tmpvar_206)) + (((tmpvar_212 * (1.0 - tmpvar_203)) + (tmpvar_214 * tmpvar_203)) * tmpvar_206));
      highp float uMu_215;
      highp float uR_216;
      highp float tmpvar_217;
      tmpvar_217 = sqrt(((Rt * Rt) - (Rg * Rg)));
      highp float tmpvar_218;
      tmpvar_218 = sqrt(((tmpvar_188 * tmpvar_188) - (Rg * Rg)));
      highp float tmpvar_219;
      tmpvar_219 = (tmpvar_188 * mu1_100);
      highp float tmpvar_220;
      tmpvar_220 = (((tmpvar_219 * tmpvar_219) - (tmpvar_188 * tmpvar_188)) + (Rg * Rg));
      highp vec4 tmpvar_221;
      if (((tmpvar_219 < 0.0) && (tmpvar_220 > 0.0))) {
        highp vec4 tmpvar_222;
        tmpvar_222.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_222.w = (0.5 - (0.5 / RES_MU));
        tmpvar_221 = tmpvar_222;
      } else {
        highp vec4 tmpvar_223;
        tmpvar_223.x = -1.0;
        tmpvar_223.y = (tmpvar_217 * tmpvar_217);
        tmpvar_223.z = tmpvar_217;
        tmpvar_223.w = (0.5 + (0.5 / RES_MU));
        tmpvar_221 = tmpvar_223;
      };
      uR_216 = ((0.5 / RES_R) + ((tmpvar_218 / tmpvar_217) * (1.0 - (1.0/(RES_R)))));
      uMu_215 = (tmpvar_221.w + ((((tmpvar_219 * tmpvar_221.x) + sqrt((tmpvar_220 + tmpvar_221.y))) / (tmpvar_218 + tmpvar_221.z)) * (0.5 - (1.0/(RES_MU)))));
      highp float y_over_x_224;
      y_over_x_224 = (max (muS1_99, -0.1975) * 5.34962);
      highp float x_225;
      x_225 = (y_over_x_224 * inversesqrt(((y_over_x_224 * y_over_x_224) + 1.0)));
      highp float tmpvar_226;
      tmpvar_226 = ((0.5 / RES_MU_S) + (((((sign(x_225) * (1.5708 - (sqrt((1.0 - abs(x_225))) * (1.5708 + (abs(x_225) * (-0.214602 + (abs(x_225) * (0.0865667 + (abs(x_225) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
      highp float tmpvar_227;
      tmpvar_227 = (((tmpvar_103 + 1.0) / 2.0) * (RES_NU - 1.0));
      highp float tmpvar_228;
      tmpvar_228 = floor(tmpvar_227);
      highp float tmpvar_229;
      tmpvar_229 = (tmpvar_227 - tmpvar_228);
      highp float tmpvar_230;
      tmpvar_230 = (floor(((uR_216 * RES_R) - 1.0)) / RES_R);
      highp float tmpvar_231;
      tmpvar_231 = (floor((uR_216 * RES_R)) / RES_R);
      highp float tmpvar_232;
      tmpvar_232 = fract((uR_216 * RES_R));
      highp vec4 tmpvar_233;
      tmpvar_233.zw = vec2(0.0, 0.0);
      tmpvar_233.x = ((tmpvar_228 + tmpvar_226) / RES_NU);
      tmpvar_233.y = ((uMu_215 / RES_R) + tmpvar_230);
      lowp vec4 tmpvar_234;
      tmpvar_234 = textureLod (_Sky_Inscatter, tmpvar_233.xy, 0.0);
      highp vec4 tmpvar_235;
      tmpvar_235.zw = vec2(0.0, 0.0);
      tmpvar_235.x = (((tmpvar_228 + tmpvar_226) + 1.0) / RES_NU);
      tmpvar_235.y = ((uMu_215 / RES_R) + tmpvar_230);
      lowp vec4 tmpvar_236;
      tmpvar_236 = textureLod (_Sky_Inscatter, tmpvar_235.xy, 0.0);
      highp vec4 tmpvar_237;
      tmpvar_237.zw = vec2(0.0, 0.0);
      tmpvar_237.x = ((tmpvar_228 + tmpvar_226) / RES_NU);
      tmpvar_237.y = ((uMu_215 / RES_R) + tmpvar_231);
      lowp vec4 tmpvar_238;
      tmpvar_238 = textureLod (_Sky_Inscatter, tmpvar_237.xy, 0.0);
      highp vec4 tmpvar_239;
      tmpvar_239.zw = vec2(0.0, 0.0);
      tmpvar_239.x = (((tmpvar_228 + tmpvar_226) + 1.0) / RES_NU);
      tmpvar_239.y = ((uMu_215 / RES_R) + tmpvar_231);
      lowp vec4 tmpvar_240;
      tmpvar_240 = textureLod (_Sky_Inscatter, tmpvar_239.xy, 0.0);
      inScatter_102 = mix (inScatterA_130, max ((inScatter0_131 - (((((tmpvar_234 * (1.0 - tmpvar_229)) + (tmpvar_236 * tmpvar_229)) * (1.0 - tmpvar_232)) + (((tmpvar_238 * (1.0 - tmpvar_229)) + (tmpvar_240 * tmpvar_229)) * tmpvar_232)) * extinction_82.xyzx)), vec4(0.0, 0.0, 0.0, 0.0)), vec4(a_132));
    } else {
      highp vec4 inScatter0_1_241;
      highp float uMu_242;
      highp float uR_243;
      highp float tmpvar_244;
      tmpvar_244 = sqrt(((Rt * Rt) - (Rg * Rg)));
      highp float tmpvar_245;
      tmpvar_245 = sqrt(((r_85 * r_85) - (Rg * Rg)));
      highp float tmpvar_246;
      tmpvar_246 = (r_85 * mu_83);
      highp float tmpvar_247;
      tmpvar_247 = (((tmpvar_246 * tmpvar_246) - (r_85 * r_85)) + (Rg * Rg));
      highp vec4 tmpvar_248;
      if (((tmpvar_246 < 0.0) && (tmpvar_247 > 0.0))) {
        highp vec4 tmpvar_249;
        tmpvar_249.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_249.w = (0.5 - (0.5 / RES_MU));
        tmpvar_248 = tmpvar_249;
      } else {
        highp vec4 tmpvar_250;
        tmpvar_250.x = -1.0;
        tmpvar_250.y = (tmpvar_244 * tmpvar_244);
        tmpvar_250.z = tmpvar_244;
        tmpvar_250.w = (0.5 + (0.5 / RES_MU));
        tmpvar_248 = tmpvar_250;
      };
      uR_243 = ((0.5 / RES_R) + ((tmpvar_245 / tmpvar_244) * (1.0 - (1.0/(RES_R)))));
      uMu_242 = (tmpvar_248.w + ((((tmpvar_246 * tmpvar_248.x) + sqrt((tmpvar_247 + tmpvar_248.y))) / (tmpvar_245 + tmpvar_248.z)) * (0.5 - (1.0/(RES_MU)))));
      highp float y_over_x_251;
      y_over_x_251 = (max (tmpvar_104, -0.1975) * 5.34962);
      highp float x_252;
      x_252 = (y_over_x_251 * inversesqrt(((y_over_x_251 * y_over_x_251) + 1.0)));
      highp float tmpvar_253;
      tmpvar_253 = ((0.5 / RES_MU_S) + (((((sign(x_252) * (1.5708 - (sqrt((1.0 - abs(x_252))) * (1.5708 + (abs(x_252) * (-0.214602 + (abs(x_252) * (0.0865667 + (abs(x_252) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
      highp float tmpvar_254;
      tmpvar_254 = (((tmpvar_103 + 1.0) / 2.0) * (RES_NU - 1.0));
      highp float tmpvar_255;
      tmpvar_255 = floor(tmpvar_254);
      highp float tmpvar_256;
      tmpvar_256 = (tmpvar_254 - tmpvar_255);
      highp float tmpvar_257;
      tmpvar_257 = (floor(((uR_243 * RES_R) - 1.0)) / RES_R);
      highp float tmpvar_258;
      tmpvar_258 = (floor((uR_243 * RES_R)) / RES_R);
      highp float tmpvar_259;
      tmpvar_259 = fract((uR_243 * RES_R));
      highp vec4 tmpvar_260;
      tmpvar_260.zw = vec2(0.0, 0.0);
      tmpvar_260.x = ((tmpvar_255 + tmpvar_253) / RES_NU);
      tmpvar_260.y = ((uMu_242 / RES_R) + tmpvar_257);
      lowp vec4 tmpvar_261;
      tmpvar_261 = textureLod (_Sky_Inscatter, tmpvar_260.xy, 0.0);
      highp vec4 tmpvar_262;
      tmpvar_262.zw = vec2(0.0, 0.0);
      tmpvar_262.x = (((tmpvar_255 + tmpvar_253) + 1.0) / RES_NU);
      tmpvar_262.y = ((uMu_242 / RES_R) + tmpvar_257);
      lowp vec4 tmpvar_263;
      tmpvar_263 = textureLod (_Sky_Inscatter, tmpvar_262.xy, 0.0);
      highp vec4 tmpvar_264;
      tmpvar_264.zw = vec2(0.0, 0.0);
      tmpvar_264.x = ((tmpvar_255 + tmpvar_253) / RES_NU);
      tmpvar_264.y = ((uMu_242 / RES_R) + tmpvar_258);
      lowp vec4 tmpvar_265;
      tmpvar_265 = textureLod (_Sky_Inscatter, tmpvar_264.xy, 0.0);
      highp vec4 tmpvar_266;
      tmpvar_266.zw = vec2(0.0, 0.0);
      tmpvar_266.x = (((tmpvar_255 + tmpvar_253) + 1.0) / RES_NU);
      tmpvar_266.y = ((uMu_242 / RES_R) + tmpvar_258);
      lowp vec4 tmpvar_267;
      tmpvar_267 = textureLod (_Sky_Inscatter, tmpvar_266.xy, 0.0);
      inScatter0_1_241 = ((((tmpvar_261 * (1.0 - tmpvar_256)) + (tmpvar_263 * tmpvar_256)) * (1.0 - tmpvar_259)) + (((tmpvar_265 * (1.0 - tmpvar_256)) + (tmpvar_267 * tmpvar_256)) * tmpvar_259));
      highp float uMu_268;
      highp float uR_269;
      highp float tmpvar_270;
      tmpvar_270 = sqrt(((Rt * Rt) - (Rg * Rg)));
      highp float tmpvar_271;
      tmpvar_271 = sqrt(((r1_101 * r1_101) - (Rg * Rg)));
      highp float tmpvar_272;
      tmpvar_272 = (r1_101 * mu1_100);
      highp float tmpvar_273;
      tmpvar_273 = (((tmpvar_272 * tmpvar_272) - (r1_101 * r1_101)) + (Rg * Rg));
      highp vec4 tmpvar_274;
      if (((tmpvar_272 < 0.0) && (tmpvar_273 > 0.0))) {
        highp vec4 tmpvar_275;
        tmpvar_275.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_275.w = (0.5 - (0.5 / RES_MU));
        tmpvar_274 = tmpvar_275;
      } else {
        highp vec4 tmpvar_276;
        tmpvar_276.x = -1.0;
        tmpvar_276.y = (tmpvar_270 * tmpvar_270);
        tmpvar_276.z = tmpvar_270;
        tmpvar_276.w = (0.5 + (0.5 / RES_MU));
        tmpvar_274 = tmpvar_276;
      };
      uR_269 = ((0.5 / RES_R) + ((tmpvar_271 / tmpvar_270) * (1.0 - (1.0/(RES_R)))));
      uMu_268 = (tmpvar_274.w + ((((tmpvar_272 * tmpvar_274.x) + sqrt((tmpvar_273 + tmpvar_274.y))) / (tmpvar_271 + tmpvar_274.z)) * (0.5 - (1.0/(RES_MU)))));
      highp float y_over_x_277;
      y_over_x_277 = (max (muS1_99, -0.1975) * 5.34962);
      highp float x_278;
      x_278 = (y_over_x_277 * inversesqrt(((y_over_x_277 * y_over_x_277) + 1.0)));
      highp float tmpvar_279;
      tmpvar_279 = ((0.5 / RES_MU_S) + (((((sign(x_278) * (1.5708 - (sqrt((1.0 - abs(x_278))) * (1.5708 + (abs(x_278) * (-0.214602 + (abs(x_278) * (0.0865667 + (abs(x_278) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
      highp float tmpvar_280;
      tmpvar_280 = (((tmpvar_103 + 1.0) / 2.0) * (RES_NU - 1.0));
      highp float tmpvar_281;
      tmpvar_281 = floor(tmpvar_280);
      highp float tmpvar_282;
      tmpvar_282 = (tmpvar_280 - tmpvar_281);
      highp float tmpvar_283;
      tmpvar_283 = (floor(((uR_269 * RES_R) - 1.0)) / RES_R);
      highp float tmpvar_284;
      tmpvar_284 = (floor((uR_269 * RES_R)) / RES_R);
      highp float tmpvar_285;
      tmpvar_285 = fract((uR_269 * RES_R));
      highp vec4 tmpvar_286;
      tmpvar_286.zw = vec2(0.0, 0.0);
      tmpvar_286.x = ((tmpvar_281 + tmpvar_279) / RES_NU);
      tmpvar_286.y = ((uMu_268 / RES_R) + tmpvar_283);
      lowp vec4 tmpvar_287;
      tmpvar_287 = textureLod (_Sky_Inscatter, tmpvar_286.xy, 0.0);
      highp vec4 tmpvar_288;
      tmpvar_288.zw = vec2(0.0, 0.0);
      tmpvar_288.x = (((tmpvar_281 + tmpvar_279) + 1.0) / RES_NU);
      tmpvar_288.y = ((uMu_268 / RES_R) + tmpvar_283);
      lowp vec4 tmpvar_289;
      tmpvar_289 = textureLod (_Sky_Inscatter, tmpvar_288.xy, 0.0);
      highp vec4 tmpvar_290;
      tmpvar_290.zw = vec2(0.0, 0.0);
      tmpvar_290.x = ((tmpvar_281 + tmpvar_279) / RES_NU);
      tmpvar_290.y = ((uMu_268 / RES_R) + tmpvar_284);
      lowp vec4 tmpvar_291;
      tmpvar_291 = textureLod (_Sky_Inscatter, tmpvar_290.xy, 0.0);
      highp vec4 tmpvar_292;
      tmpvar_292.zw = vec2(0.0, 0.0);
      tmpvar_292.x = (((tmpvar_281 + tmpvar_279) + 1.0) / RES_NU);
      tmpvar_292.y = ((uMu_268 / RES_R) + tmpvar_284);
      lowp vec4 tmpvar_293;
      tmpvar_293 = textureLod (_Sky_Inscatter, tmpvar_292.xy, 0.0);
      inScatter_102 = max ((inScatter0_1_241 - (((((tmpvar_287 * (1.0 - tmpvar_282)) + (tmpvar_289 * tmpvar_282)) * (1.0 - tmpvar_285)) + (((tmpvar_291 * (1.0 - tmpvar_282)) + (tmpvar_293 * tmpvar_282)) * tmpvar_285)) * extinction_82.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
    };
    highp float t_294;
    t_294 = max (min ((tmpvar_104 / 0.02), 1.0), 0.0);
    inScatter_102.w = (inScatter_102.w * (t_294 * (t_294 * (3.0 - (2.0 * t_294)))));
  } else {
    extinction_82 = vec3(1.0, 1.0, 1.0);
  };
  highp vec3 L_295;
  highp vec3 tmpvar_296;
  tmpvar_296 = ((surfaceColor_1 * extinction_82) * _Exposure);
  L_295 = tmpvar_296;
  highp float tmpvar_297;
  if ((tmpvar_296.x < 1.413)) {
    tmpvar_297 = pow ((tmpvar_296.x * 0.38317), 0.454545);
  } else {
    tmpvar_297 = (1.0 - exp(-(tmpvar_296.x)));
  };
  L_295.x = tmpvar_297;
  highp float tmpvar_298;
  if ((tmpvar_296.y < 1.413)) {
    tmpvar_298 = pow ((tmpvar_296.y * 0.38317), 0.454545);
  } else {
    tmpvar_298 = (1.0 - exp(-(tmpvar_296.y)));
  };
  L_295.y = tmpvar_298;
  highp float tmpvar_299;
  if ((tmpvar_296.z < 1.413)) {
    tmpvar_299 = pow ((tmpvar_296.z * 0.38317), 0.454545);
  } else {
    tmpvar_299 = (1.0 - exp(-(tmpvar_296.z)));
  };
  L_295.z = tmpvar_299;
  highp vec4 tmpvar_300;
  tmpvar_300.xyz = L_295;
  tmpvar_300.w = outAlpha_8;
  _glesFragData[0] = tmpvar_300;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 458 math, 21 textures, 6 branches
Float 0 [_Exposure]
Float 1 [scale]
Float 2 [Rg]
Float 3 [Rt]
Float 4 [_Sun_Intensity]
Float 5 [_Ocean_Radius]
Vector 6 [_Ocean_CameraPos]
Vector 7 [_Ocean_SunDir]
Vector 8 [_Ocean_Color]
Vector 9 [_Ocean_GridSizes]
Float 10 [_Ocean_WhiteCapStr]
Float 11 [farWhiteCapStr]
Float 12 [_OceanAlpha]
Float 13 [alphaRadius]
Float 14 [sunReflectionMultiplier]
Float 15 [skyReflectionMultiplier]
Float 16 [seaRefractionMultiplier]
Vector 17 [_VarianceMax]
SetTexture 0 [_Ocean_Map1] 2D 0
SetTexture 1 [_Ocean_Map2] 2D 1
SetTexture 2 [_Ocean_Variance] 3D 2
SetTexture 3 [_Sky_Transmittance] 2D 3
SetTexture 4 [_Sky_Irradiance] 2D 4
SetTexture 5 [_Ocean_Foam0] 2D 5
SetTexture 6 [_Ocean_Foam1] 2D 6
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_volume s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c18, 0.00000000, 10.00000000, 1.00000000, 0.89999998
def c19, 0.15000001, 12.26193905, -1.00000000, -0.12123910
def c20, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c21, 0.99999559, 1.57079601, 0.66666669, 2.00000000
def c22, 0.20000000, 0.83333331, 0.50000000, 0.70710677
def c23, 0.14001200, 1.27323985, 1.00000000, 2.71828198
def c24, 0.10000000, 0.25000000, 0.00002000, -2.69000006
def c25, 5.00000000, 1.50000000, 22.70000076, 1.00000000
def c26, 0.01000000, 0.98000002, 0.02000000, -2.00000000
def c27, 12.56636810, 0.31830996, 0.31194377, 0.12732399
def c28, 1000000015047466200000000000000.00000000, 2000.00000000, 0.00400000, 0.38317001
def c29, 0.45454544, -1.41299999, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
rcp r0.x, c9.x
rcp r0.y, c9.y
mul r6.xy, v0, r0.y
mul r5.xy, v0, r0.x
rcp r1.z, c9.w
mul r3.xy, v0, r1.z
rcp r1.x, c9.z
texld r0.xy, r5, s0
texld r0.zw, r6, s0
add r0.zw, r0.xyxy, r0
mul r1.xy, v0, r1.x
texld r0.xy, r1, s1
add r0.xy, r0.zwzw, r0
texld r0.zw, r3, s1
add r0.xy, r0, r0.zwzw
add r1.z, v1, c5.x
rcp r0.z, r1.z
mad r0.zw, -v1.xyxy, r0.z, r0.xyxy
cmp r0.xy, -c5.x, r0, r0.zwzw
mov r2.xy, -r0
mov r2.z, c18
dp3 r1.z, r2, r2
rsq r1.z, r1.z
mul r4.xyz, r1.z, r2
dsx r3.z, v0.y
dsx r1.w, v0.x
mov r0.xy, c18.x
mov r0.z, c6
add r0.xyz, -v1, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r10.xyz, r0.w, r0
dp3 r0.w, r10, r4
add r0.xyz, r10, c7
dp3 r1.z, r0, r0
mul r2.xyz, r10, r0.w
mad r2.xyz, -r2, c21.w, r4
cmp r9.xyz, r0.w, r4, r2
dp3 r5.w, r9, r10
rsq r1.z, r1.z
mul r8.xyz, r1.z, r0
mul r0.x, r3.z, r3.z
mad r3.w, r1, r1, r0.x
dsy r4.y, v0
dp3 r1.z, r9, r8
mul r2.x, r3.w, c24
mul r0.x, r4.y, r4.y
dsy r4.x, v0
mad r4.z, r4.x, r4.x, r0.x
pow r0, r2.x, c24.y
mul r0.y, r4.z, c24.x
pow r2, r0.y, c24.y
mul r0.z, r3, r4.y
mad r0.z, r1.w, r4.x, r0
mul r0.y, r3.w, r4.z
add r2.y, r1.z, c18.z
rsq r0.y, r0.y
mul r0.y, r0, r0.z
mov r1.w, c5.x
mov r0.z, r2
mad r0.y, r0, c22.z, c22.z
texld r0.x, r0, s2
mul r0.w, r0.x, c17.x
max r3.w, r0, c24.z
add r6.z, -r5.w, c18
mad r2.x, -r1.z, r1.z, c18.z
add r1.w, c18.y, r1
rcp r2.y, r2.y
mov r0.z, c5.x
mov r0.xy, c18.x
add r0.xyz, v1, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mul r0.xyz, r0, r1.w
cmp r11.xyz, -c5.x, v1, r0
mul r7.xyz, r11, c1.x
rcp r0.w, r3.w
mul r2.x, r2, r0.w
mul r2.x, r2, r2.y
mul r2.x, r2, c26.w
dp3 r0.z, r7, r7
rsq r0.z, r0.z
rcp r0.w, r0.z
mov r0.z, c2.x
mad r1.z, c18.w, -r0, r0.w
add r3.z, r7, c2.x
cmp r0.z, r1, r7, r3
mov r0.xy, r7
dp3 r1.w, r0, r0
rsq r1.w, r1.w
rcp r1.w, r1.w
cmp r1.z, r1, r0.w, r1.w
rsq r0.w, r3.w
rcp r6.w, r0.w
pow r4, c23.w, r2.x
rcp r5.z, r1.z
mul r4.yzw, r0.xxyz, r5.z
mul r2.x, r6.w, c24.w
pow r0, c23.w, r2.x
pow r2, r6.w, c25.y
mul r2.y, r0.x, c25.x
pow r0, r6.z, r2.y
mad r0.y, r2.x, c25.z, c25.w
dp3 r1.w, r4.yzww, r9
dp3 r0.w, r4.yzww, c7
mov r6.z, r0.x
rcp r2.w, r0.y
mov r0.x, c3
mad r6.w, -r6.z, r2, c18.z
add r2.x, r1.w, c18.z
add r0.z, r0.w, c22.x
add r0.y, -c2.x, r0.x
mul r0.x, r0.z, c22.y
rcp r0.z, r0.y
add r0.y, r1.z, -c2.x
mul r1.zw, r0.y, r0.z
mov r0.y, r1.w
mov r0.z, c18.x
texldl r0.xyz, r0.xyzz, s4
mul r1.w, r2.x, c22.z
mul r0.xyz, r0, c4.x
mul r2.xyz, r0, r1.w
mul r1.w, r3, c27.x
mul r4.yzw, r2.xxyz, c21.w
mul r0.xyz, r6.w, c8
mul r2.xyz, r4.yzww, r0
dp3 r0.x, r10, r8
add r0.x, -r0, c18.z
mul r0.y, r0.x, r0.x
mul r0.y, r0, r0
mul r0.x, r0.y, r0
max r3.w, r5, c26.x
mov r0.z, r4.x
rcp r1.w, r1.w
mul r0.z, r0, r1.w
mad r0.x, r0, c26.y, c26.z
mul r0.y, r0.x, r0.z
dp3 r1.w, r9, c7
add r0.z, r0.w, c19.x
mul r4.x, r0.z, c19.y
max r0.x, r1.w, c26
rcp r0.z, r3.w
mul r3.w, r0.x, r0.z
abs r5.w, r4.x
abs r7.w, r3
max r0.z, r5.w, c18
rcp r3.w, r0.z
min r0.z, r5.w, c18
mul r6.w, r0.z, r3
rsq r3.w, r7.w
rcp r7.w, r3.w
mul r0.z, r6.w, r6.w
mad r3.w, r0.z, c20.x, c20.y
mul r7.w, r0.y, r7
mad r0.y, r3.w, r0.z, c19.w
max r3.w, r7, c18.x
mad r0.y, r0, r0.z, c20.z
cmp r3.w, -r0.x, c18.x, r3
mad r0.x, r0.y, r0.z, c20.w
mul r0.y, r6.z, r2.w
mad r2.w, r0.x, r0.z, c21.x
mul r0.xyz, r4.yzww, r0.y
mul r8.xyz, r0, c15.x
mul r2.w, r2, r6
mul r0.x, r5.z, c2
add r0.z, -r2.w, c21.y
add r0.y, r5.w, c19.z
cmp r0.y, -r0, r2.w, r0.z
cmp r0.z, r4.x, r0.y, -r0.y
mad r0.x, -r0, r0, c18.z
rsq r0.y, r0.x
rcp r2.w, r0.y
rsq r0.y, r1.z
mul r0.x, r0.z, c21.z
add r0.w, r0, r2
mul r9.xyz, r8, c27.y
max r1.z, r1.w, c18.x
mov r0.z, c18.x
rcp r0.y, r0.y
texldl r0.xyz, r0.xyzz, s3
cmp r0.xyz, r0.w, r0, c18.x
mul r0.xyz, r0, c4.x
mul r8.xyz, r0, r3.w
mad r4.xyz, r0, r1.z, r4.yzww
mov r0.w, c6.z
mad r8.xyz, r8, c14.x, r9
mul r2.xyz, r2, c16.x
mov r0.xy, c18.x
add r0.z, c5.x, r0.w
mad r2.xyz, r2, c27.z, r8
mul r9.xyz, r0, c1.x
add r8.xyz, r11, -r0
dp3 r0.x, r8, r8
rsq r0.x, r0.x
texld r0.zw, r6, s5
add r8.xyz, r7, -r9
rcp r0.y, c13.x
rcp r0.x, r0.x
mul_sat r2.w, r0.x, r0.y
texld r0.xy, r1, s6
texld r1.xy, r5, s5
add r1.zw, r1.xyxy, r0
add r1.zw, r1, r0.xyxy
mul r0.y, r0.z, r0.z
texld r0.zw, r3, s6
mad r0.y, r1.x, r1.x, r0
mad r0.x, r0, r0, r0.y
mov r0.y, c11.x
add r0.y, -c10.x, r0
add r1.xy, r1.zwzw, r0.zwzw
mad r0.x, r0.z, r0.z, r0
add r0.x, r1.y, -r0
mad r0.y, r2.w, r0, c10.x
max r0.x, r0, c18
dp3 r0.z, r9, r9
rsq r0.z, r0.z
rcp r5.y, r0.z
mov r0.z, c2.x
mad r3.x, c18.w, -r0.z, r5.y
add r3.y, r9.z, c2.x
cmp r0.z, r3.x, r9, r3.y
add r0.y, r0, -r1.x
rsq r0.x, r0.x
mul r0.x, r0, r0.y
mul r3.w, r0.x, c22
mul r0.w, r3, r3
dp3 r0.y, r8, r8
rsq r1.w, r0.y
mad r4.w, r0, c23.x, c23.y
mul r1.xyz, r1.w, r8
mov r0.xy, r9
dp3 r3.y, r1, r0
dp3 r0.y, r0, r0
mad r0.x, r0.w, c23, c23.z
rsq r0.y, r0.y
mul r4.w, -r0, r4
rcp r0.x, r0.x
mul r5.x, r4.w, r0
rcp r0.y, r0.y
cmp r4.w, r3.x, r5.y, r0.y
pow r0, c23.w, r5.x
mul r0.y, r4.w, r4.w
mad r0.y, r3, r3, -r0
mad r0.w, c3.x, c3.x, r0.y
rsq r0.y, r0.w
rcp r5.x, r0.y
add r0.x, -r0, c18.z
rsq r0.x, r0.x
rcp r0.z, r0.x
cmp r0.y, r3.w, c18.x, c18.z
cmp r0.x, -r3.w, c18, c18.z
add r0.x, r0, -r0.y
mul r0.x, r0, r0.z
cmp r0.y, r0.w, r5.x, c28.x
add r0.w, -r3.y, -r0.y
mad r0.x, r0, c22.z, c22.z
mul r0.xyz, r4, r0.x
max r0.w, r0, c18.x
mad r2.xyz, r0, c27.w, r2
rcp r3.w, r1.w
add r1.w, -r3, r0
cmp r0.y, r1.w, c18.x, c18.z
cmp r0.x, -r0.w, c18, c18.z
mul_pp r0.x, r0, r0.y
add r0.z, r0.w, r3.y
rcp r0.w, c3.x
rcp r0.y, r4.w
mul r0.y, r3, r0
mul r0.z, r0, r0.w
cmp r0.w, -r0.x, r0.y, r0.z
cmp r1.w, -r0.x, r4, c3.x
cmp r0.z, r3.x, r7, r3
mov r3.x, c12
add r3.x, c18.z, -r3
min_sat r3.y, r3.w, c18.x
mov r0.xy, r7
mad r0.xyz, -r1, r3.y, r0
mad r2.w, r2, r3.x, c12.x
if_le r1.w, c3.x
mov r3.x, c2
add r3.x, c28.y, r3
rcp r3.y, r1.w
mul r3.y, r3.x, r3
mul r4.xyz, r0, r3.y
add r3.y, r1.w, -r3.x
cmp r0.xyz, r3.y, r0, r4
dp3 r3.z, r0, r0
dp3 r0.y, r0, r1
rsq r0.x, r3.z
mul r0.y, r0.x, r0
rcp r0.x, r0.x
cmp r1.w, r3.y, r1, r3.x
if_gt r0.w, c18.x
add r0.y, r0, c19.x
mul r3.x, r0.y, c19.y
abs r3.y, r3.x
max r0.y, r3, c18.z
rcp r0.z, r0.y
min r0.y, r3, c18.z
mul r1.z, r0.y, r0
mul r1.y, r1.z, r1.z
mad r0.z, r1.y, c20.x, c20.y
mad r0.z, r0, r1.y, c19.w
mad r1.x, r0.z, r1.y, c20.z
mad r3.z, r1.x, r1.y, c20.w
mad r3.z, r3, r1.y, c21.x
mul r3.z, r3, r1
add r0.y, r0.w, c19.x
mul r0.y, r0, c19
abs r0.z, r0.y
max r1.x, r0.z, c18.z
rcp r1.y, r1.x
min r1.x, r0.z, c18.z
mul r1.y, r1.x, r1
mul r1.z, r1.y, r1.y
mad r1.x, r1.z, c20, c20.y
mad r1.x, r1, r1.z, c19.w
add r3.w, -r3.z, c21.y
add r3.y, r3, c19.z
cmp r3.y, -r3, r3.z, r3.w
cmp r3.y, r3.x, r3, -r3
mad r3.x, r1, r1.z, c20.z
mad r3.x, r3, r1.z, c20.w
mul r1.x, r3.y, c21.z
mad r1.z, r3.x, r1, c21.x
mov r3.y, c3.x
add r3.x, -c2, r3.y
rcp r3.z, r3.x
mul r3.x, r1.z, r1.y
add r0.x, r0, -c2
mul r0.x, r3.z, r0
rsq r0.x, r0.x
rcp r1.y, r0.x
add r0.x, r0.z, c19.z
mov r1.z, c18.x
texldl r1.xyz, r1.xyzz, s3
add r3.y, -r3.x, c21
cmp r0.x, -r0, r3, r3.y
cmp r0.x, r0.y, r0, -r0
add r0.z, r1.w, -c2.x
mul r0.y, r0.z, r3.z
rsq r0.y, r0.y
mul r0.x, r0, c21.z
mov r0.z, c18.x
rcp r0.y, r0.y
texldl r0.xyz, r0.xyzz, s3
rcp r1.x, r1.x
rcp r1.z, r1.z
rcp r1.y, r1.y
mul r0.xyz, r0, r1
min r0.xyz, r0, c18.z
else
add r0.z, -r0.w, c19.x
mul r3.x, r0.z, c19.y
abs r3.y, r3.x
max r0.z, r3.y, c18
rcp r1.x, r0.z
min r0.z, r3.y, c18
mul r1.z, r0, r1.x
mul r1.y, r1.z, r1.z
mad r0.z, r1.y, c20.x, c20.y
mad r0.z, r0, r1.y, c19.w
mad r1.x, r0.z, r1.y, c20.z
mad r3.z, r1.x, r1.y, c20.w
mad r3.z, r3, r1.y, c21.x
mul r3.z, r3, r1
add r0.y, -r0, c19.x
mul r0.y, r0, c19
abs r0.z, r0.y
max r1.x, r0.z, c18.z
rcp r1.y, r1.x
min r1.x, r0.z, c18.z
mul r1.y, r1.x, r1
mul r1.z, r1.y, r1.y
mad r1.x, r1.z, c20, c20.y
mad r1.x, r1, r1.z, c19.w
add r3.w, -r3.z, c21.y
add r3.y, r3, c19.z
cmp r3.y, -r3, r3.z, r3.w
cmp r3.y, r3.x, r3, -r3
mad r3.x, r1, r1.z, c20.z
mad r3.x, r3, r1.z, c20.w
mul r1.x, r3.y, c21.z
mad r1.z, r3.x, r1, c21.x
mov r3.y, c3.x
add r3.x, -c2, r3.y
rcp r3.z, r3.x
mul r3.x, r1.z, r1.y
add r3.y, r1.w, -c2.x
mul r3.y, r3.z, r3
rsq r1.y, r3.y
add r3.y, -r3.x, c21
add r0.z, r0, c19
cmp r0.z, -r0, r3.x, r3.y
add r3.x, r0, -c2
cmp r0.x, r0.y, r0.z, -r0.z
mul r0.y, r3.x, r3.z
rsq r0.y, r0.y
mov r1.z, c18.x
rcp r1.y, r1.y
texldl r1.xyz, r1.xyzz, s3
mul r0.x, r0, c21.z
mov r0.z, c18.x
rcp r0.y, r0.y
texldl r0.xyz, r0.xyzz, s3
rcp r1.x, r1.x
rcp r1.z, r1.z
rcp r1.y, r1.y
mul r0.xyz, r0, r1
min r0.xyz, r0, c18.z
endif
rcp r1.x, r1.w
mul r1.x, r1, c2
mad r1.x, -r1, r1, c18.z
rsq r1.x, r1.x
rcp r1.x, r1.x
add r0.w, r0, r1.x
abs r0.w, r0
if_lt r0.w, c28.z
else
endif
else
mov r0.xyz, c18.z
endif
mul r0.xyz, r2, r0
mul r2.xyz, r0, c0.x
pow r1, c23.w, -r2.x
mul r3.y, r2.x, c28.w
pow r0, r3.y, c29.x
add r3.x, r2, c29.y
mov r0.y, r1.x
mov r0.z, r0.x
pow r1, c23.w, -r2.y
add r0.x, -r0.y, c18.z
cmp oC0.x, r3, r0, r0.z
mul r3.x, r2.y, c28.w
pow r0, r3.x, c29.x
add r2.x, r2.y, c29.y
mov r0.y, r1.x
mov r0.z, r0.x
add r0.x, -r0.y, c18.z
cmp oC0.y, r2.x, r0.x, r0.z
mul r2.y, r2.z, c28.w
pow r0, r2.y, c29.x
pow r1, c23.w, -r2.z
mov r0.z, r0.x
mov r0.y, r1.x
add r2.x, r2.z, c29.y
add r0.x, -r0.y, c18.z
cmp oC0.z, r2.x, r0.x, r0
mov oC0.w, r2
"
}
SubProgram "d3d11 " {
// Stats: 324 math, 9 textures, 4 branches
SetTexture 0 [_Ocean_Map1] 2D 3
SetTexture 1 [_Ocean_Map2] 2D 4
SetTexture 2 [_Ocean_Variance] 3D 2
SetTexture 3 [_Sky_Transmittance] 2D 0
SetTexture 4 [_Sky_Irradiance] 2D 1
SetTexture 5 [_Ocean_Foam0] 2D 5
SetTexture 6 [_Ocean_Foam1] 2D 6
ConstBuffer "$Globals" 720
Float 16 [_Exposure]
Float 20 [scale]
Float 24 [Rg]
Float 28 [Rt]
Float 128 [_Sun_Intensity]
Float 132 [_Ocean_Radius]
Vector 176 [_Ocean_CameraPos] 3
Vector 624 [_Ocean_SunDir] 3
Vector 640 [_Ocean_Color] 3
Vector 656 [_Ocean_GridSizes]
Float 680 [_Ocean_WhiteCapStr]
Float 684 [farWhiteCapStr]
Float 688 [_OceanAlpha]
Float 692 [alphaRadius]
Float 696 [sunReflectionMultiplier]
Float 700 [skyReflectionMultiplier]
Float 704 [seaRefractionMultiplier]
Vector 708 [_VarianceMax] 2
BindCB  "$Globals" 0
"ps_4_0
eefiecedeccjgphfaeakbfiacaokoaecmibgbbfcabaaaaaafmcoaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciecnaaaaeaaaaaaagbalaaaa
fjaaaaaeegiocaaaaaaaaaaacnaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaaficiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaa
ffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaoaaaaaa
aaaaaaajccaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaackiacaaaaaaaaaaa
alaaaaaadbaaaaaiecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkiacaaaaaaaaaaa
aiaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaagecaabaaa
abaaaaaabkiacaaaaaaaaaaaaiaaaaaaaaaaaaahhcaabaaaabaaaaaaagacbaaa
abaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
lcaabaaaabaaaaaapgapbaaaaaaaaaaaegaibaaaabaaaaaaaaaaaaaiicaabaaa
aaaaaaaabkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaacaebdiaaaaahlcaabaaa
abaaaaaapgapbaaaaaaaaaaaegambaaaabaaaaaadhaaaaajlcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegambaaaabaaaaaaegbibaaaacaaaaaadgaaaaafbcaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaihcaabaaaacaaaaaaagabbaiaebaaaaaa
aaaaaaaaegadbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaocaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaclaaaaaaaaaaaaaj
bcaabaaaacaaaaaaakiacaiaebaaaaaaaaaaaaaaclaaaaaaabeaaaaaaaaaiadp
dcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaaakiacaaa
aaaaaaaaclaaaaaaaaaaaaakbcaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaa
ckaaaaaadkiacaaaaaaaaaaackaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaacaaaaaackiacaaaaaaaaaaackaaaaaadgaaaaafbcaabaaa
acaaaaaaabeaaaaaaaaaaaaadgaaaaagecaabaaaacaaaaaackiacaaaaaaaaaaa
alaaaaaaaaaaaaaihcaabaaaacaaaaaaagacbaaaacaaaaaaegbcbaiaebaaaaaa
acaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaacaaaaaaegacbaaaacaaaaaaaoaaaaaipcaabaaaaeaaaaaaegbebaaa
abaaaaaaagifcaaaaaaaaaaacjaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaagaaaaaa
ogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaaaaaaaaahdcaabaaa
afaaaaaaegaabaaaafaaaaaaogakbaaaagaaaaaaaoaaaaaipcaabaaaagaaaaaa
egbebaaaabaaaaaakgipcaaaaaaaaaaacjaaaaaaefaaaaajpcaabaaaahaaaaaa
egaabaaaagaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaaaaaaaaahdcaabaaa
afaaaaaaegaabaaaafaaaaaaegaabaaaahaaaaaaefaaaaajpcaabaaaahaaaaaa
ogakbaaaagaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaaaaaaaaahdcaabaaa
afaaaaaaegaabaaaafaaaaaaogakbaaaahaaaaaaaoaaaaahmcaabaaaafaaaaaa
agbebaaaacaaaaaakgakbaaaabaaaaaaaaaaaaaimcaabaaaafaaaaaakgaobaia
ebaaaaaaafaaaaaaagaebaaaafaaaaaadhaaaaajdcaabaaaafaaaaaakgakbaaa
aaaaaaaaogakbaaaafaaaaaaegaabaaaafaaaaaadgaaaaagdcaabaaaafaaaaaa
egaabaiaebaaaaaaafaaaaaadgaaaaafecaabaaaafaaaaaaabeaaaaaaaaaiadp
baaaaaahecaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaafaaaaaakgakbaaa
aaaaaaaaegacbaaaafaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaafaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaakhcaabaaaahaaaaaaegacbaaaadaaaaaakgakbaiaebaaaaaaaaaaaaaa
egacbaaaafaaaaaadhaaaaajhcaabaaaafaaaaaakgakbaaaabaaaaaaegacbaaa
ahaaaaaaegacbaaaafaaaaaaalaaaaafdcaabaaaahaaaaaaegbabaaaabaaaaaa
amaaaaafmcaabaaaahaaaaaaagbebaaaabaaaaaadiaaaaahdcaabaaaaiaaaaaa
egaabaaaahaaaaaaegaabaaaahaaaaaaaaaaaaahecaabaaaaaaaaaaabkaabaaa
aiaaaaaaakaabaaaaiaaaaaadiaaaaahdcaabaaaahaaaaaaogakbaaaahaaaaaa
egaabaaaahaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaaahaaaaaaakaabaaa
ahaaaaaadiaaaaahdcaabaaaahaaaaaaogakbaaaahaaaaaaogakbaaaahaaaaaa
aaaaaaahicaabaaaadaaaaaabkaabaaaahaaaaaaakaabaaaahaaaaaadiaaaaah
icaabaaaafaaaaaackaabaaaaaaaaaaaabeaaaaamnmmmmdncpaaaaaficaabaaa
afaaaaaadkaabaaaafaaaaaadiaaaaahicaabaaaafaaaaaadkaabaaaafaaaaaa
abeaaaaaaaaaiadobjaaaaafbcaabaaaahaaaaaadkaabaaaafaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaadaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaoaaaaahecaabaaaaaaaaaaackaabaaaabaaaaaackaabaaa
aaaaaaaaaaaaaaahccaabaaaahaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadp
diaaaaahecaabaaaaaaaaaaadkaabaaaadaaaaaaabeaaaaamnmmmmdncpaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadobjaaaaafecaabaaaahaaaaaackaabaaaaaaaaaaa
efaaaaajpcaabaaaahaaaaaaegacbaaaahaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaaiecaabaaaaaaaaaaaakaabaaaahaaaaaabkiacaaaaaaaaaaa
cmaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaakmmfkhdh
diaaaaaincaabaaaahaaaaaapgaebaaaabaaaaaafgifcaaaaaaaaaaaabaaaaaa
baaaaaahecaabaaaabaaaaaaigadbaaaahaaaaaaigadbaaaahaaaaaaelaaaaaf
bcaabaaaaiaaaaaackaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaackiacaaa
aaaaaaaaabaaaaaaabeaaaaaggggggdpdbaaaaahicaabaaaadaaaaaaakaabaaa
aiaaaaaackaabaaaabaaaaaadcaaaaalccaabaaaahaaaaaadkaabaaaabaaaaaa
bkiacaaaaaaaaaaaabaaaaaackiacaaaaaaaaaaaabaaaaaabaaaaaahicaabaaa
afaaaaaajgahbaaaahaaaaaajgahbaaaahaaaaaaelaaaaafccaabaaaajaaaaaa
dkaabaaaafaaaaaadgaaaaafecaabaaaajaaaaaabkaabaaaahaaaaaadgaaaaaf
icaabaaaaiaaaaaaakaabaaaahaaaaaadhaaaaajdcaabaaaahaaaaaapgapbaaa
adaaaaaaggakbaaaajaaaaaadgapbaaaaiaaaaaaaoaaaaahhcaabaaaakaaaaaa
ogaibaaaahaaaaaafgafbaaaahaaaaaabaaaaaaiicaabaaaadaaaaaaegacbaaa
akaaaaaaegiccaaaaaaaaaaachaaaaaaaoaaaaaiicaabaaaafaaaaaackiacaaa
aaaaaaaaabaaaaaabkaabaaaahaaaaaadcaaaaakicaabaaaafaaaaaadkaabaia
ebaaaaaaafaaaaaadkaabaaaafaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaa
afaaaaaadkaabaaaafaaaaaadbaaaaaiicaabaaaafaaaaaadkaabaaaadaaaaaa
dkaabaiaebaaaaaaafaaaaaaaaaaaaajbcaabaaaahaaaaaabkaabaaaahaaaaaa
ckiacaiaebaaaaaaaaaaaaaaabaaaaaaaaaaaaakccaabaaaahaaaaaackiacaia
ebaaaaaaaaaaaaaaabaaaaaadkiacaaaaaaaaaaaabaaaaaaaoaaaaahecaabaaa
alaaaaaaakaabaaaahaaaaaabkaabaaaahaaaaaaelaaaaafccaabaaaamaaaaaa
ckaabaaaalaaaaaaaaaaaaakmcaabaaaamaaaaaapgapbaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaajkjjbjdomnmmemdodiaaaaakdcaabaaaalaaaaaaogakbaaa
amaaaaaaaceaaaaajfdbeeebffffffdpaaaaaaaaaaaaaaaaddaaaaaiicaabaaa
adaaaaaaakaabaiaibaaaaaaalaaaaaaabeaaaaaaaaaiadpdeaaaaaibcaabaaa
ahaaaaaaakaabaiaibaaaaaaalaaaaaaabeaaaaaaaaaiadpaoaaaaakbcaabaaa
ahaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaahaaaaaa
diaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaaahaaaaaadiaaaaah
bcaabaaaahaaaaaadkaabaaaadaaaaaadkaabaaaadaaaaaadcaaaaajccaabaaa
ajaaaaaaakaabaaaahaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ccaabaaaajaaaaaaakaabaaaahaaaaaabkaabaaaajaaaaaaabeaaaaaochgdido
dcaaaaajccaabaaaajaaaaaaakaabaaaahaaaaaabkaabaaaajaaaaaaabeaaaaa
aebnkjlodcaaaaajbcaabaaaahaaaaaaakaabaaaahaaaaaabkaabaaaajaaaaaa
abeaaaaadiphhpdpdiaaaaahccaabaaaajaaaaaadkaabaaaadaaaaaaakaabaaa
ahaaaaaadbaaaaaiicaabaaaakaaaaaaabeaaaaaaaaaiadpakaabaiaibaaaaaa
alaaaaaadcaaaaajccaabaaaajaaaaaabkaabaaaajaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpabaaaaahccaabaaaajaaaaaadkaabaaaakaaaaaabkaabaaa
ajaaaaaadcaaaaajicaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaaahaaaaaa
bkaabaaaajaaaaaaddaaaaahbcaabaaaahaaaaaaakaabaaaalaaaaaaabeaaaaa
aaaaiadpdbaaaaaibcaabaaaahaaaaaaakaabaaaahaaaaaaakaabaiaebaaaaaa
ahaaaaaadhaaaaakicaabaaaadaaaaaaakaabaaaahaaaaaadkaabaiaebaaaaaa
adaaaaaadkaabaaaadaaaaaadiaaaaahbcaabaaaamaaaaaadkaabaaaadaaaaaa
abeaaaaaklkkckdpeiaaaaalpcaabaaaamaaaaaaegaabaaaamaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaamaaaaaa
egacbaaaamaaaaaaagiacaaaaaaaaaaaaiaaaaaadhaaaaamhcaabaaaamaaaaaa
pgapbaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaa
amaaaaaabaaaaaahicaabaaaadaaaaaaegacbaaaakaaaaaaegacbaaaafaaaaaa
aaaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaadpeiaaaaalpcaabaaa
akaaaaaajgafbaaaalaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaaihcaabaaaakaaaaaaegacbaaaakaaaaaaagiacaaaaaaaaaaa
aiaaaaaadiaaaaahhcaabaaaakaaaaaapgapbaaaadaaaaaaegacbaaaakaaaaaa
aaaaaaahhcaabaaaakaaaaaaegacbaaaakaaaaaaegacbaaaakaaaaaabaaaaaah
icaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaaelaaaaaficaabaaa
afaaaaaackaabaaaaaaaaaaaaaaaaaaibcaabaaaahaaaaaadkaabaiaebaaaaaa
adaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaajaaaaaadkaabaaaafaaaaaa
abeaaaaanifphimabjaaaaafccaabaaaajaaaaaabkaabaaaajaaaaaadiaaaaah
ccaabaaaajaaaaaabkaabaaaajaaaaaaabeaaaaaaaaakaeacpaaaaafbcaabaaa
ahaaaaaaakaabaaaahaaaaaadiaaaaahbcaabaaaahaaaaaaakaabaaaahaaaaaa
bkaabaaaajaaaaaabjaaaaafbcaabaaaahaaaaaaakaabaaaahaaaaaacpaaaaaf
icaabaaaafaaaaaadkaabaaaafaaaaaadiaaaaahicaabaaaafaaaaaadkaabaaa
afaaaaaaabeaaaaaaaaamadpbjaaaaaficaabaaaafaaaaaadkaabaaaafaaaaaa
dcaaaaajicaabaaaafaaaaaadkaabaaaafaaaaaaabeaaaaajkjjlfebabeaaaaa
aaaaiadpaoaaaaahicaabaaaafaaaaaaakaabaaaahaaaaaadkaabaaaafaaaaaa
diaaaaahhcaabaaaalaaaaaaegacbaaaakaaaaaapgapbaaaafaaaaaadiaaaaai
hcaabaaaalaaaaaaegacbaaaalaaaaaapgipcaaaaaaaaaaaclaaaaaadcaaaaak
hcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaaegiccaaaaaaaaaaa
chaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaafaaaaaadcaaaaakbcaabaaaahaaaaaadkaabaiaebaaaaaa
acaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpaoaaaaahbcaabaaaahaaaaaa
akaabaaaahaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaahaaaaaaakaabaaa
ahaaaaaaabeaaaaaaaaaaamaaaaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaiadpaoaaaaahicaabaaaacaaaaaaakaabaaaahaaaaaadkaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaadlkklidp
bjaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaniapejebaoaaaaahecaabaaaaaaaaaaadkaabaaa
acaaaaaackaabaaaaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaiadpdiaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaaj
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaeiobhkdpabeaaaaaaknhkddm
baaaaaaiccaabaaaacaaaaaaegiccaaaaaaaaaaachaaaaaaegacbaaaafaaaaaa
deaaaaakgcaabaaaacaaaaaafgafbaaaacaaaaaaaceaaaaaaaaaaaaaaknhcddm
aaaaaaaaaaaaaaaadeaaaaahicaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaa
aknhcddmdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaa
aoaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaadkaabaaaacaaaaaaelaaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaacaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahlcaabaaaacaaaaaaegaibaaaamaaaaaakgakbaaa
aaaaaaaaaaaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaaafaaaaaaabeaaaaa
aaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaeiobhkdp
diaaaaaihcaabaaaadaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaciaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaakaaaaaaegacbaaaadaaaaaadiaaaaai
hcaabaaaadaaaaaaegacbaaaadaaaaaaagiacaaaaaaaaaaacmaaaaaaefaaaaaj
pcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaa
efaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaafaaaaaaaagabaaa
afaaaaaaefaaaaajpcaabaaaanaaaaaaegaabaaaagaaaaaaeghobaaaagaaaaaa
aagabaaaagaaaaaaefaaaaajpcaabaaaagaaaaaaogakbaaaagaaaaaaeghobaaa
agaaaaaaaagabaaaagaaaaaaaaaaaaahdcaabaaaaeaaaaaaogakbaaaaeaaaaaa
egaabaaaafaaaaaaaaaaaaahdcaabaaaaeaaaaaaegaabaaaanaaaaaaegaabaaa
aeaaaaaaaaaaaaahdcaabaaaaeaaaaaaogakbaaaagaaaaaaegaabaaaaeaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaeaaaaaackaabaaaaeaaaaaadcaaaaaj
ecaabaaaaaaaaaaaakaabaaaafaaaaaaakaabaaaafaaaaaackaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaaakaabaaaanaaaaaaakaabaaaanaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaagaaaaaackaabaaaagaaaaaa
ckaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaaeaaaaaadeaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaiaebaaaaaa
aeaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaapdaedfdp
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaakecaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahicaabaaaadaaaaaa
abeaaaaaaaaaaaaackaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaaboaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaa
adaaaaaackaabaaaaaaaaaaaclaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaapdcaabaaaaeaaaaaapgapbaaaaaaaaaaaaceaaaaaeofpapdoeofpapdo
aaaaaaaaaaaaaaaaaceaaaaaigpjkcdpaaaaiadpaaaaaaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaakaabaaaaeaaaaaaaoaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaeaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadpdcaaaaaj
hcaabaaaaeaaaaaaegacbaaaamaaaaaakgakbaaaacaaaaaaegacbaaaakaaaaaa
diaaaaahhcaabaaaaeaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaak
hcaabaaaafaaaaaaegacbaaaalaaaaaaaceaaaaaigpjkcdoigpjkcdoigpjkcdo
aaaaaaaadcaaaaakhcaabaaaacaaaaaakgikcaaaaaaaaaaaclaaaaaaegadbaaa
acaaaaaaegacbaaaafaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaadaaaaaa
aceaaaaaigpjkcdoigpjkcdoigpjkcdoaaaaaaaaegacbaaaacaaaaaadcaaaaam
hcaabaaaacaaaaaaegacbaaaaeaaaaaaaceaaaaadigbacdodigbacdodigbacdo
aaaaaaaaegacbaaaacaaaaaadiaaaaaidcaabaaaaiaaaaaaegaabaaaaaaaaaaa
fgifcaaaaaaaaaaaabaaaaaadcaaaaalncaabaaaaaaaaaaaaganbaaaabaaaaaa
fgifcaaaaaaaaaaaabaaaaaaagaebaiaebaaaaaaaiaaaaaabaaaaaahbcaabaaa
abaaaaaaigadbaaaaaaaaaaaigadbaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaaaoaaaaahncaabaaaaaaaaaaaagaobaaaaaaaaaaaagaabaaa
abaaaaaadgaaaaagecaabaaaaiaaaaaabkaabaiaibaaaaaaaiaaaaaadbaaaaah
ccaabaaaabaaaaaackaabaaaaiaaaaaackaabaaaabaaaaaadcaaaaalbcaabaaa
ajaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaackiacaaaaaaaaaaa
abaaaaaadgaaaaagicaabaaaajaaaaaaakaabaiaibaaaaaaajaaaaaadhaaaaaj
hcaabaaaadaaaaaafgafbaaaabaaaaaamgacbaaaajaaaaaajgahbaaaaiaaaaaa
diaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaadaaaaaaaoaaaaah
icaabaaaadaaaaaabkaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaakccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaal
ccaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaadkiacaaaaaaaaaaaabaaaaaa
bkaabaaaaaaaaaaabnaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakccaabaaa
aaaaaaaabkaabaaaabaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaamkpcejpb
dcaaaaakccaabaaaaaaaaaaaakaabaiaebaaaaaaadaaaaaadkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaaabaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaajccaabaaa
aaaaaaaaakaabaaaadaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaai
ccaabaaaaeaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaadgaaaaag
bcaabaaaaeaaaaaadkiacaaaaaaaaaaaabaaaaaadhaaaaajdcaabaaaabaaaaaa
agaabaaaabaaaaaaegaabaaaaeaaaaaangafbaaaadaaaaaabnaaaaaiccaabaaa
aaaaaaaadkiacaaaaaaaaaaaabaaaaaaakaabaaaabaaaaaabpaaaeadbkaabaaa
aaaaaaaaaaaaaaaiccaabaaaaaaaaaaackiacaaaaaaaaaaaabaaaaaaabeaaaaa
aaaapkeedbaaaaahecaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaaaaaaaaa
aoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaaf
dcaabaaaadaaaaaaogakbaaaahaaaaaadiaaaaahhcaabaaaaeaaaaaafgafbaaa
aaaaaaaaegacbaaaadaaaaaaaaaaaaaiicaabaaaaeaaaaaackiacaaaaaaaaaaa
abaaaaaaabeaaaaaaaaapkeedgaaaaaficaabaaaadaaaaaaakaabaaaabaaaaaa
dhaaaaajpcaabaaaadaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaaegaobaaa
adaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaadaaaaaaigadbaaaaaaaaaaaaoaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaa
bkaabaaaabaaaaaabpaaaeadckaabaaaaaaaaaaaaaaaaaajecaabaaaaaaaaaaa
dkaabaaaadaaaaaackiacaiaebaaaaaaaaaaaaaaabaaaaaaaoaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaahaaaaaaelaaaaafccaabaaaadaaaaaa
ckaabaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaaabeaaaaa
jkjjbjdodiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaajfdbeeeb
ddaaaaaiicaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadp
deaaaaaibcaabaaaabaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadp
aoaaaaakbcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaajecaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaa
dgfkkolndcaaaaajecaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaochgdidodcaaaaajecaabaaaabaaaaaaakaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaebnkjlodcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaabaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadbaaaaaiicaabaaaabaaaaaaabeaaaaaaaaaiadp
ckaabaiaibaaaaaaaaaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahecaabaaaabaaaaaadkaabaaa
abaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaackaabaaaabaaaaaaddaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaadhaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaadaaaaaa
ckaabaaaaaaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaj
ecaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaabaaaaaa
aoaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaahaaaaaaelaaaaaf
ccaabaaaadaaaaaackaabaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaajkjjbjdodiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaajfdbeeebddaaaaaiicaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaaibcaabaaaabaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaaaaaaiadpaoaaaaakbcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajecaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaa
abaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadbaaaaaiicaabaaaabaaaaaa
abeaaaaaaaaaiadpckaabaiaibaaaaaaaaaaaaaadcaaaaajecaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahecaabaaa
abaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaaddaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadhaaaaakecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaadaaaaaackaabaaaaaaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaa
afaaaaaaegaabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaaaoaaaaahncaabaaaabaaaaaaagajbaaaaeaaaaaaagajbaaaafaaaaaa
ddaaaaakncaabaaaabaaaaaaagaobaaaabaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaiadpaaaaiadpbcaaaaabaaaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaabaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaahaaaaaaelaaaaafccaabaaaadaaaaaabkaabaaaaaaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaajkjjbjdo
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaajfdbeeebddaaaaai
ccaabaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaai
ecaabaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaak
ecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaaj
icaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajicaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
ochgdidodcaaaaajicaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaebnkjlodcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadbaaaaaiicaabaaaacaaaaaaabeaaaaaaaaaiadpakaabaia
ibaaaaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpabaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaa
dkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpdbaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaa
aaaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaaaaaaaaaaegaabaaaadaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaajicaabaaa
aaaaaaaadkaabaaaadaaaaaackiacaiaebaaaaaaaaaaaaaaabaaaaaaaoaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaahaaaaaaelaaaaafccaabaaa
adaaaaaadkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaiaebaaaaaa
abaaaaaaabeaaaaajkjjbjdodiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaajfdbeeebddaaaaaiccaabaaaabaaaaaadkaabaiaibaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaaiicaabaaaacaaaaaadkaabaiaibaaaaaaaaaaaaaa
abeaaaaaaaaaiadpaoaaaaakicaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaacaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaajecaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaadaaaaaadkaabaaaacaaaaaa
ckaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaadaaaaaadkaabaaa
acaaaaaackaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaacaaaaaa
dkaabaaaacaaaaaackaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaa
adaaaaaabkaabaaaabaaaaaadkaabaaaacaaaaaadbaaaaaiicaabaaaadaaaaaa
abeaaaaaaaaaiadpdkaabaiaibaaaaaaaaaaaaaadcaaaaajecaabaaaadaaaaaa
ckaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahecaabaaa
adaaaaaadkaabaaaadaaaaaackaabaaaadaaaaaadcaaaaajccaabaaaabaaaaaa
bkaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadhaaaaakicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
bcaabaaaadaaaaaadkaabaaaaaaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaa
adaaaaaaegaabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaa
ddaaaaakncaabaaaabaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaiadpaaaaiadpbfaaaaabbcaaaaabdgaaaaaincaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaaaaaaaaaiadpaaaaiadpbfaaaaabdiaaaaahhcaabaaaaaaaaaaa
igadbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaabaaaaaadbaaaaakhcaabaaaabaaaaaaegacbaaa
aaaaaaaaaceaaaaacpnnledpcpnnledpcpnnledpaaaaaaaadiaaaaakpcaabaaa
acaaaaaaagafbaaaaaaaaaaaaceaaaaanmcomedodlkklilpnmcomedodlkklilp
cpaaaaafdcaabaaaaaaaaaaaigaabaaaacaaaaaadiaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaacplkoidocplkoidoaaaaaaaaaaaaaaaabjaaaaaf
dcaabaaaaaaaaaaaegaabaaaaaaaaaaabjaaaaafdcaabaaaacaaaaaangafbaaa
acaaaaaaaaaaaaaldcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadhaaaaajdccabaaaaaaaaaaaegaabaaa
abaaaaaaegaabaaaaaaaaaaaegaabaaaacaaaaaadiaaaaakdcaabaaaaaaaaaaa
kgakbaaaaaaaaaaaaceaaaaanmcomedodlkklilpaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaacplkoidobjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdhaaaaajeccabaaaaaaaaaaa
ckaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadoaaaaab"
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