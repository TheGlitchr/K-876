// Compiled shader for all platforms, uncompressed size: 227.3KB

Shader "Sky/AtmosphereGhoss" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _SkyDome ("SkyDome", 2D) = "white" {}
 _Scale ("Scale", Vector) = (1,1,1,1)
}
SubShader { 
 Tags { "QUEUE"="Transparent-5" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }


 // Stats for Vertex shader:
 //       d3d11 : 15 math
 //        d3d9 : 20 math, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 686 math, 1 texture, 14 branch
 //        d3d9 : 1014 math, 61 texture, 9 branch
 Pass {
  Tags { "QUEUE"="Transparent-5" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;


varying vec4 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _ZBufferParams;
uniform sampler2D _Transmittance;
uniform sampler2D _Inscatter;
uniform sampler2D _Irradiance;
uniform float M_PI;
uniform float Rg;
uniform float Rt;
uniform float RES_R;
uniform float RES_MU;
uniform float RES_MU_S;
uniform float RES_NU;
uniform vec3 SUN_DIR;
uniform float SUN_INTENSITY;
uniform vec3 betaR;
uniform float mieG;
uniform mat4 _ViewProjInv;
uniform float _viewdirOffset;
uniform float _experimentalAtmoScale;
uniform float _global_alpha;
uniform float _Exposure;
uniform float _global_depth;
uniform float _Ocean_Sigma;
uniform float fakeOcean;
uniform float _fade;
uniform vec3 _Ocean_Color;
uniform vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform float _openglThreshold;
uniform float _edgeThreshold;
varying vec2 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  float visib_2;
  vec3 oceanColor_3;
  vec3 worldPos_4;
  float dpth_5;
  dpth_5 = (1.0/(((_ZBufferParams.x * texture2D (_customDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.y)));
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_6.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_6.z = ((texture2D (_customDepthTexture, xlv_TEXCOORD2).x * 2.0) - 1.0);
  vec4 tmpvar_7;
  tmpvar_7 = (_ViewProjInv * tmpvar_6);
  vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 / tmpvar_7.w).xyz;
  worldPos_4 = tmpvar_8;
  float tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_8 - _camPos);
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, tmpvar_10);
  float tmpvar_12;
  tmpvar_12 = (2.0 * dot (tmpvar_10, _camPos));
  float tmpvar_13;
  tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_13 < 0.0)) {
    tmpvar_9 = -1.0;
  } else {
    tmpvar_9 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
  };
  bool tmpvar_14;
  tmpvar_14 = (tmpvar_9 > 0.0);
  if (((dpth_5 >= _edgeThreshold) && !(tmpvar_14))) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    vec3 tmpvar_15;
    tmpvar_15 = (_camPos + (tmpvar_9 * (tmpvar_8 - _camPos)));
    vec3 arg0_16;
    arg0_16 = (tmpvar_15 - _camPos);
    vec3 arg0_17;
    arg0_17 = (tmpvar_8 - _camPos);
    bool tmpvar_18;
    tmpvar_18 = (sqrt(dot (arg0_16, arg0_16)) < sqrt(dot (arg0_17, arg0_17)));
    oceanColor_3 = vec3(1.0, 1.0, 1.0);
    if ((tmpvar_14 && tmpvar_18)) {
      worldPos_4 = tmpvar_15;
      if ((fakeOcean == 1.0)) {
        vec3 tmpvar_19;
        tmpvar_19 = normalize(tmpvar_15);
        vec3 tmpvar_20;
        tmpvar_20 = (tmpvar_19 * max (sqrt(dot (tmpvar_15, tmpvar_15)), (Rg + 10.0)));
        vec3 tmpvar_21;
        tmpvar_21 = normalize((tmpvar_20 - _camPos));
        vec3 worldP_22;
        worldP_22 = tmpvar_20;
        float r_23;
        float tmpvar_24;
        tmpvar_24 = sqrt(dot (tmpvar_20, tmpvar_20));
        r_23 = tmpvar_24;
        if ((tmpvar_24 < (0.9 * Rg))) {
          worldP_22.z = (tmpvar_20.z + Rg);
          r_23 = sqrt(dot (worldP_22, worldP_22));
        };
        vec3 tmpvar_25;
        tmpvar_25 = (worldP_22 / r_23);
        float tmpvar_26;
        tmpvar_26 = dot (tmpvar_25, SUN_DIR);
        float tmpvar_27;
        tmpvar_27 = sqrt((1.0 - ((Rg / r_23) * (Rg / r_23))));
        vec3 tmpvar_28;
        if ((tmpvar_26 < -(tmpvar_27))) {
          tmpvar_28 = vec3(0.0, 0.0, 0.0);
        } else {
          float y_over_x_29;
          y_over_x_29 = (((tmpvar_26 + 0.15) / 1.15) * 14.1014);
          float x_30;
          x_30 = (y_over_x_29 * inversesqrt(((y_over_x_29 * y_over_x_29) + 1.0)));
          vec4 tmpvar_31;
          tmpvar_31.zw = vec2(0.0, 0.0);
          tmpvar_31.x = ((sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296))))))))) / 1.5);
          tmpvar_31.y = sqrt(((r_23 - Rg) / (Rt - Rg)));
          tmpvar_28 = texture2DLod (_Transmittance, tmpvar_31.xy, 0.0).xyz;
        };
        vec3 tmpvar_32;
        tmpvar_32 = (tmpvar_28 * SUN_INTENSITY);
        vec2 tmpvar_33;
        tmpvar_33.x = ((tmpvar_26 + 0.2) / 1.2);
        tmpvar_33.y = ((r_23 - Rg) / (Rt - Rg));
        vec3 tmpvar_34;
        tmpvar_34 = (((2.0 * texture2DLod (_Irradiance, tmpvar_33, 0.0).xyz) * SUN_INTENSITY) * ((1.0 + tmpvar_25.z) * 0.5));
        vec3 V_35;
        V_35 = -(tmpvar_21);
        vec3 seaColor_36;
        seaColor_36 = (_Ocean_Color * 10.0);
        float tmpvar_37;
        tmpvar_37 = sqrt(_Ocean_Sigma);
        float tmpvar_38;
        tmpvar_38 = (pow ((1.0 - dot (V_35, tmpvar_19)), (5.0 * exp((-2.69 * tmpvar_37)))) / (1.0 + (22.7 * pow (tmpvar_37, 1.5))));
        vec3 tmpvar_39;
        tmpvar_39 = normalize((SUN_DIR + V_35));
        float tmpvar_40;
        tmpvar_40 = dot (tmpvar_39, tmpvar_19);
        float tmpvar_41;
        tmpvar_41 = (exp(((-2.0 * ((1.0 - (tmpvar_40 * tmpvar_40)) / _Ocean_Sigma)) / (1.0 + tmpvar_40))) / ((4.0 * M_PI) * _Ocean_Sigma));
        float tmpvar_42;
        tmpvar_42 = (1.0 - dot (V_35, tmpvar_39));
        float tmpvar_43;
        tmpvar_43 = (tmpvar_42 * tmpvar_42);
        float tmpvar_44;
        tmpvar_44 = (0.02 + (((0.98 * tmpvar_43) * tmpvar_43) * tmpvar_42));
        float tmpvar_45;
        tmpvar_45 = max (dot (SUN_DIR, tmpvar_19), 0.01);
        float tmpvar_46;
        tmpvar_46 = max (dot (V_35, tmpvar_19), 0.01);
        float tmpvar_47;
        if ((tmpvar_45 <= 0.0)) {
          tmpvar_47 = 0.0;
        } else {
          tmpvar_47 = max (((tmpvar_44 * tmpvar_41) * sqrt(abs((tmpvar_45 / tmpvar_46)))), 0.0);
        };
        oceanColor_3 = (((tmpvar_47 * tmpvar_32) + ((tmpvar_34 * tmpvar_38) / M_PI)) + ((((1.0 - tmpvar_38) * seaColor_36) * tmpvar_34) / M_PI));
      };
    };
    float tmpvar_48;
    tmpvar_48 = sqrt(dot (worldPos_4, worldPos_4));
    if ((tmpvar_48 < (Rg + _openglThreshold))) {
      worldPos_4 = ((Rg + _openglThreshold) * normalize(worldPos_4));
    };
    vec3 tmpvar_49;
    vec3 camera_50;
    camera_50 = _camPos;
    vec3 _point_51;
    _point_51 = worldPos_4;
    vec3 extinction_52;
    float mu_53;
    float rMu_54;
    float r_55;
    float d_56;
    vec3 viewdir_57;
    vec3 result_58;
    result_58 = vec3(0.0, 0.0, 0.0);
    extinction_52 = vec3(1.0, 1.0, 1.0);
    vec3 tmpvar_59;
    tmpvar_59 = (worldPos_4 - _camPos);
    float tmpvar_60;
    tmpvar_60 = sqrt(dot (tmpvar_59, tmpvar_59));
    d_56 = tmpvar_60;
    vec3 tmpvar_61;
    tmpvar_61 = (tmpvar_59 / tmpvar_60);
    viewdir_57.yz = tmpvar_61.yz;
    float tmpvar_62;
    tmpvar_62 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    viewdir_57.x = (tmpvar_61.x + _viewdirOffset);
    vec3 tmpvar_63;
    tmpvar_63 = normalize(viewdir_57);
    viewdir_57 = tmpvar_63;
    float tmpvar_64;
    tmpvar_64 = sqrt(dot (_camPos, _camPos));
    r_55 = tmpvar_64;
    if ((tmpvar_64 < (0.9 * Rg))) {
      camera_50.y = (_camPos.y + Rg);
      _point_51.y = (worldPos_4.y + Rg);
      r_55 = sqrt(dot (camera_50, camera_50));
    };
    float tmpvar_65;
    tmpvar_65 = dot (camera_50, tmpvar_63);
    rMu_54 = tmpvar_65;
    mu_53 = (tmpvar_65 / r_55);
    vec3 tmpvar_66;
    tmpvar_66 = (_point_51 - (tmpvar_63 * clamp (1.0, 0.0, tmpvar_60)));
    _point_51 = tmpvar_66;
    float tmpvar_67;
    tmpvar_67 = max ((-(tmpvar_65) - sqrt((((tmpvar_65 * tmpvar_65) - (r_55 * r_55)) + (tmpvar_62 * tmpvar_62)))), 0.0);
    if (((tmpvar_67 > 0.0) && (tmpvar_67 < tmpvar_60))) {
      camera_50 = (camera_50 + (tmpvar_67 * tmpvar_63));
      float tmpvar_68;
      tmpvar_68 = (tmpvar_65 + tmpvar_67);
      rMu_54 = tmpvar_68;
      mu_53 = (tmpvar_68 / tmpvar_62);
      r_55 = tmpvar_62;
      d_56 = (tmpvar_60 - tmpvar_67);
    };
    if ((r_55 <= tmpvar_62)) {
      float muS1_69;
      float mu1_70;
      float r1_71;
      vec4 inScatter_72;
      float tmpvar_73;
      tmpvar_73 = dot (tmpvar_63, SUN_DIR);
      float tmpvar_74;
      tmpvar_74 = (dot (camera_50, SUN_DIR) / r_55);
      if ((r_55 < (Rg + 600.0))) {
        float tmpvar_75;
        tmpvar_75 = ((Rg + 600.0) / r_55);
        r_55 = (r_55 * tmpvar_75);
        rMu_54 = (rMu_54 * tmpvar_75);
        _point_51 = (tmpvar_66 * tmpvar_75);
      };
      float tmpvar_76;
      tmpvar_76 = sqrt(dot (_point_51, _point_51));
      r1_71 = tmpvar_76;
      float tmpvar_77;
      tmpvar_77 = (dot (_point_51, tmpvar_63) / tmpvar_76);
      mu1_70 = tmpvar_77;
      muS1_69 = (dot (_point_51, SUN_DIR) / tmpvar_76);
      if ((mu_53 > 0.0)) {
        float y_over_x_78;
        y_over_x_78 = (((mu_53 + 0.15) / 1.15) * 14.1014);
        float x_79;
        x_79 = (y_over_x_78 * inversesqrt(((y_over_x_78 * y_over_x_78) + 1.0)));
        vec4 tmpvar_80;
        tmpvar_80.zw = vec2(0.0, 0.0);
        tmpvar_80.x = ((sign(x_79) * (1.5708 - (sqrt((1.0 - abs(x_79))) * (1.5708 + (abs(x_79) * (-0.214602 + (abs(x_79) * (0.0865667 + (abs(x_79) * -0.0310296))))))))) / 1.5);
        tmpvar_80.y = sqrt(((r_55 - Rg) / (tmpvar_62 - Rg)));
        float y_over_x_81;
        y_over_x_81 = (((tmpvar_77 + 0.15) / 1.15) * 14.1014);
        float x_82;
        x_82 = (y_over_x_81 * inversesqrt(((y_over_x_81 * y_over_x_81) + 1.0)));
        vec4 tmpvar_83;
        tmpvar_83.zw = vec2(0.0, 0.0);
        tmpvar_83.x = ((sign(x_82) * (1.5708 - (sqrt((1.0 - abs(x_82))) * (1.5708 + (abs(x_82) * (-0.214602 + (abs(x_82) * (0.0865667 + (abs(x_82) * -0.0310296))))))))) / 1.5);
        tmpvar_83.y = sqrt(((tmpvar_76 - Rg) / (tmpvar_62 - Rg)));
        extinction_52 = min ((texture2DLod (_Transmittance, tmpvar_80.xy, 0.0).xyz / texture2DLod (_Transmittance, tmpvar_83.xy, 0.0).xyz), vec3(1.0, 1.0, 1.0));
      } else {
        float y_over_x_84;
        y_over_x_84 = (((-(tmpvar_77) + 0.15) / 1.15) * 14.1014);
        float x_85;
        x_85 = (y_over_x_84 * inversesqrt(((y_over_x_84 * y_over_x_84) + 1.0)));
        vec4 tmpvar_86;
        tmpvar_86.zw = vec2(0.0, 0.0);
        tmpvar_86.x = ((sign(x_85) * (1.5708 - (sqrt((1.0 - abs(x_85))) * (1.5708 + (abs(x_85) * (-0.214602 + (abs(x_85) * (0.0865667 + (abs(x_85) * -0.0310296))))))))) / 1.5);
        tmpvar_86.y = sqrt(((tmpvar_76 - Rg) / (tmpvar_62 - Rg)));
        float y_over_x_87;
        y_over_x_87 = (((-(mu_53) + 0.15) / 1.15) * 14.1014);
        float x_88;
        x_88 = (y_over_x_87 * inversesqrt(((y_over_x_87 * y_over_x_87) + 1.0)));
        vec4 tmpvar_89;
        tmpvar_89.zw = vec2(0.0, 0.0);
        tmpvar_89.x = ((sign(x_88) * (1.5708 - (sqrt((1.0 - abs(x_88))) * (1.5708 + (abs(x_88) * (-0.214602 + (abs(x_88) * (0.0865667 + (abs(x_88) * -0.0310296))))))))) / 1.5);
        tmpvar_89.y = sqrt(((r_55 - Rg) / (tmpvar_62 - Rg)));
        extinction_52 = min ((texture2DLod (_Transmittance, tmpvar_86.xy, 0.0).xyz / texture2DLod (_Transmittance, tmpvar_89.xy, 0.0).xyz), vec3(1.0, 1.0, 1.0));
      };
      float tmpvar_90;
      tmpvar_90 = -(sqrt((1.0 - ((Rg / r_55) * (Rg / r_55)))));
      float tmpvar_91;
      tmpvar_91 = abs((mu_53 - tmpvar_90));
      if ((tmpvar_91 < 0.004)) {
        vec4 inScatterA_92;
        vec4 inScatter0_93;
        float a_94;
        a_94 = (((mu_53 - tmpvar_90) + 0.004) / 0.008);
        float tmpvar_95;
        tmpvar_95 = (tmpvar_90 - 0.004);
        mu_53 = tmpvar_95;
        float tmpvar_96;
        tmpvar_96 = sqrt((((r_55 * r_55) + (d_56 * d_56)) + (((2.0 * r_55) * d_56) * tmpvar_95)));
        r1_71 = tmpvar_96;
        mu1_70 = (((r_55 * tmpvar_95) + d_56) / tmpvar_96);
        float uMu_97;
        float uR_98;
        float tmpvar_99;
        tmpvar_99 = sqrt(((tmpvar_62 * tmpvar_62) - (Rg * Rg)));
        float tmpvar_100;
        tmpvar_100 = sqrt(((r_55 * r_55) - (Rg * Rg)));
        float tmpvar_101;
        tmpvar_101 = (r_55 * tmpvar_95);
        float tmpvar_102;
        tmpvar_102 = (((tmpvar_101 * tmpvar_101) - (r_55 * r_55)) + (Rg * Rg));
        vec4 tmpvar_103;
        if (((tmpvar_101 < 0.0) && (tmpvar_102 > 0.0))) {
          vec4 tmpvar_104;
          tmpvar_104.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_104.w = (0.5 - (0.5 / RES_MU));
          tmpvar_103 = tmpvar_104;
        } else {
          vec4 tmpvar_105;
          tmpvar_105.x = -1.0;
          tmpvar_105.y = (tmpvar_99 * tmpvar_99);
          tmpvar_105.z = tmpvar_99;
          tmpvar_105.w = (0.5 + (0.5 / RES_MU));
          tmpvar_103 = tmpvar_105;
        };
        uR_98 = ((0.5 / RES_R) + ((tmpvar_100 / tmpvar_99) * (1.0 - (1.0/(RES_R)))));
        uMu_97 = (tmpvar_103.w + ((((tmpvar_101 * tmpvar_103.x) + sqrt((tmpvar_102 + tmpvar_103.y))) / (tmpvar_100 + tmpvar_103.z)) * (0.5 - (1.0/(RES_MU)))));
        float y_over_x_106;
        y_over_x_106 = (max (tmpvar_74, -0.1975) * 5.34962);
        float x_107;
        x_107 = (y_over_x_106 * inversesqrt(((y_over_x_106 * y_over_x_106) + 1.0)));
        float tmpvar_108;
        tmpvar_108 = ((0.5 / RES_MU_S) + (((((sign(x_107) * (1.5708 - (sqrt((1.0 - abs(x_107))) * (1.5708 + (abs(x_107) * (-0.214602 + (abs(x_107) * (0.0865667 + (abs(x_107) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        float tmpvar_109;
        tmpvar_109 = (((tmpvar_73 + 1.0) / 2.0) * (RES_NU - 1.0));
        float tmpvar_110;
        tmpvar_110 = floor(tmpvar_109);
        float tmpvar_111;
        tmpvar_111 = (tmpvar_109 - tmpvar_110);
        float tmpvar_112;
        tmpvar_112 = (floor(((uR_98 * RES_R) - 1.0)) / RES_R);
        float tmpvar_113;
        tmpvar_113 = (floor((uR_98 * RES_R)) / RES_R);
        float tmpvar_114;
        tmpvar_114 = fract((uR_98 * RES_R));
        vec4 tmpvar_115;
        tmpvar_115.zw = vec2(0.0, 0.0);
        tmpvar_115.x = ((tmpvar_110 + tmpvar_108) / RES_NU);
        tmpvar_115.y = ((uMu_97 / RES_R) + tmpvar_112);
        vec4 tmpvar_116;
        tmpvar_116.zw = vec2(0.0, 0.0);
        tmpvar_116.x = (((tmpvar_110 + tmpvar_108) + 1.0) / RES_NU);
        tmpvar_116.y = ((uMu_97 / RES_R) + tmpvar_112);
        vec4 tmpvar_117;
        tmpvar_117.zw = vec2(0.0, 0.0);
        tmpvar_117.x = ((tmpvar_110 + tmpvar_108) / RES_NU);
        tmpvar_117.y = ((uMu_97 / RES_R) + tmpvar_113);
        vec4 tmpvar_118;
        tmpvar_118.zw = vec2(0.0, 0.0);
        tmpvar_118.x = (((tmpvar_110 + tmpvar_108) + 1.0) / RES_NU);
        tmpvar_118.y = ((uMu_97 / RES_R) + tmpvar_113);
        inScatter0_93 = ((((texture2DLod (_Inscatter, tmpvar_115.xy, 0.0) * (1.0 - tmpvar_111)) + (texture2DLod (_Inscatter, tmpvar_116.xy, 0.0) * tmpvar_111)) * (1.0 - tmpvar_114)) + (((texture2DLod (_Inscatter, tmpvar_117.xy, 0.0) * (1.0 - tmpvar_111)) + (texture2DLod (_Inscatter, tmpvar_118.xy, 0.0) * tmpvar_111)) * tmpvar_114));
        float uMu_119;
        float uR_120;
        float tmpvar_121;
        tmpvar_121 = sqrt(((tmpvar_62 * tmpvar_62) - (Rg * Rg)));
        float tmpvar_122;
        tmpvar_122 = sqrt(((tmpvar_96 * tmpvar_96) - (Rg * Rg)));
        float tmpvar_123;
        tmpvar_123 = (tmpvar_96 * mu1_70);
        float tmpvar_124;
        tmpvar_124 = (((tmpvar_123 * tmpvar_123) - (tmpvar_96 * tmpvar_96)) + (Rg * Rg));
        vec4 tmpvar_125;
        if (((tmpvar_123 < 0.0) && (tmpvar_124 > 0.0))) {
          vec4 tmpvar_126;
          tmpvar_126.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_126.w = (0.5 - (0.5 / RES_MU));
          tmpvar_125 = tmpvar_126;
        } else {
          vec4 tmpvar_127;
          tmpvar_127.x = -1.0;
          tmpvar_127.y = (tmpvar_121 * tmpvar_121);
          tmpvar_127.z = tmpvar_121;
          tmpvar_127.w = (0.5 + (0.5 / RES_MU));
          tmpvar_125 = tmpvar_127;
        };
        uR_120 = ((0.5 / RES_R) + ((tmpvar_122 / tmpvar_121) * (1.0 - (1.0/(RES_R)))));
        uMu_119 = (tmpvar_125.w + ((((tmpvar_123 * tmpvar_125.x) + sqrt((tmpvar_124 + tmpvar_125.y))) / (tmpvar_122 + tmpvar_125.z)) * (0.5 - (1.0/(RES_MU)))));
        float y_over_x_128;
        y_over_x_128 = (max (muS1_69, -0.1975) * 5.34962);
        float x_129;
        x_129 = (y_over_x_128 * inversesqrt(((y_over_x_128 * y_over_x_128) + 1.0)));
        float tmpvar_130;
        tmpvar_130 = ((0.5 / RES_MU_S) + (((((sign(x_129) * (1.5708 - (sqrt((1.0 - abs(x_129))) * (1.5708 + (abs(x_129) * (-0.214602 + (abs(x_129) * (0.0865667 + (abs(x_129) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        float tmpvar_131;
        tmpvar_131 = (((tmpvar_73 + 1.0) / 2.0) * (RES_NU - 1.0));
        float tmpvar_132;
        tmpvar_132 = floor(tmpvar_131);
        float tmpvar_133;
        tmpvar_133 = (tmpvar_131 - tmpvar_132);
        float tmpvar_134;
        tmpvar_134 = (floor(((uR_120 * RES_R) - 1.0)) / RES_R);
        float tmpvar_135;
        tmpvar_135 = (floor((uR_120 * RES_R)) / RES_R);
        float tmpvar_136;
        tmpvar_136 = fract((uR_120 * RES_R));
        vec4 tmpvar_137;
        tmpvar_137.zw = vec2(0.0, 0.0);
        tmpvar_137.x = ((tmpvar_132 + tmpvar_130) / RES_NU);
        tmpvar_137.y = ((uMu_119 / RES_R) + tmpvar_134);
        vec4 tmpvar_138;
        tmpvar_138.zw = vec2(0.0, 0.0);
        tmpvar_138.x = (((tmpvar_132 + tmpvar_130) + 1.0) / RES_NU);
        tmpvar_138.y = ((uMu_119 / RES_R) + tmpvar_134);
        vec4 tmpvar_139;
        tmpvar_139.zw = vec2(0.0, 0.0);
        tmpvar_139.x = ((tmpvar_132 + tmpvar_130) / RES_NU);
        tmpvar_139.y = ((uMu_119 / RES_R) + tmpvar_135);
        vec4 tmpvar_140;
        tmpvar_140.zw = vec2(0.0, 0.0);
        tmpvar_140.x = (((tmpvar_132 + tmpvar_130) + 1.0) / RES_NU);
        tmpvar_140.y = ((uMu_119 / RES_R) + tmpvar_135);
        inScatterA_92 = max ((inScatter0_93 - (((((texture2DLod (_Inscatter, tmpvar_137.xy, 0.0) * (1.0 - tmpvar_133)) + (texture2DLod (_Inscatter, tmpvar_138.xy, 0.0) * tmpvar_133)) * (1.0 - tmpvar_136)) + (((texture2DLod (_Inscatter, tmpvar_139.xy, 0.0) * (1.0 - tmpvar_133)) + (texture2DLod (_Inscatter, tmpvar_140.xy, 0.0) * tmpvar_133)) * tmpvar_136)) * extinction_52.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
        float tmpvar_141;
        tmpvar_141 = (tmpvar_90 + 0.004);
        mu_53 = tmpvar_141;
        float tmpvar_142;
        tmpvar_142 = sqrt((((r_55 * r_55) + (d_56 * d_56)) + (((2.0 * r_55) * d_56) * tmpvar_141)));
        r1_71 = tmpvar_142;
        mu1_70 = (((r_55 * tmpvar_141) + d_56) / tmpvar_142);
        float uMu_143;
        float uR_144;
        float tmpvar_145;
        tmpvar_145 = sqrt(((tmpvar_62 * tmpvar_62) - (Rg * Rg)));
        float tmpvar_146;
        tmpvar_146 = sqrt(((r_55 * r_55) - (Rg * Rg)));
        float tmpvar_147;
        tmpvar_147 = (r_55 * tmpvar_141);
        float tmpvar_148;
        tmpvar_148 = (((tmpvar_147 * tmpvar_147) - (r_55 * r_55)) + (Rg * Rg));
        vec4 tmpvar_149;
        if (((tmpvar_147 < 0.0) && (tmpvar_148 > 0.0))) {
          vec4 tmpvar_150;
          tmpvar_150.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_150.w = (0.5 - (0.5 / RES_MU));
          tmpvar_149 = tmpvar_150;
        } else {
          vec4 tmpvar_151;
          tmpvar_151.x = -1.0;
          tmpvar_151.y = (tmpvar_145 * tmpvar_145);
          tmpvar_151.z = tmpvar_145;
          tmpvar_151.w = (0.5 + (0.5 / RES_MU));
          tmpvar_149 = tmpvar_151;
        };
        uR_144 = ((0.5 / RES_R) + ((tmpvar_146 / tmpvar_145) * (1.0 - (1.0/(RES_R)))));
        uMu_143 = (tmpvar_149.w + ((((tmpvar_147 * tmpvar_149.x) + sqrt((tmpvar_148 + tmpvar_149.y))) / (tmpvar_146 + tmpvar_149.z)) * (0.5 - (1.0/(RES_MU)))));
        float y_over_x_152;
        y_over_x_152 = (max (tmpvar_74, -0.1975) * 5.34962);
        float x_153;
        x_153 = (y_over_x_152 * inversesqrt(((y_over_x_152 * y_over_x_152) + 1.0)));
        float tmpvar_154;
        tmpvar_154 = ((0.5 / RES_MU_S) + (((((sign(x_153) * (1.5708 - (sqrt((1.0 - abs(x_153))) * (1.5708 + (abs(x_153) * (-0.214602 + (abs(x_153) * (0.0865667 + (abs(x_153) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        float tmpvar_155;
        tmpvar_155 = (((tmpvar_73 + 1.0) / 2.0) * (RES_NU - 1.0));
        float tmpvar_156;
        tmpvar_156 = floor(tmpvar_155);
        float tmpvar_157;
        tmpvar_157 = (tmpvar_155 - tmpvar_156);
        float tmpvar_158;
        tmpvar_158 = (floor(((uR_144 * RES_R) - 1.0)) / RES_R);
        float tmpvar_159;
        tmpvar_159 = (floor((uR_144 * RES_R)) / RES_R);
        float tmpvar_160;
        tmpvar_160 = fract((uR_144 * RES_R));
        vec4 tmpvar_161;
        tmpvar_161.zw = vec2(0.0, 0.0);
        tmpvar_161.x = ((tmpvar_156 + tmpvar_154) / RES_NU);
        tmpvar_161.y = ((uMu_143 / RES_R) + tmpvar_158);
        vec4 tmpvar_162;
        tmpvar_162.zw = vec2(0.0, 0.0);
        tmpvar_162.x = (((tmpvar_156 + tmpvar_154) + 1.0) / RES_NU);
        tmpvar_162.y = ((uMu_143 / RES_R) + tmpvar_158);
        vec4 tmpvar_163;
        tmpvar_163.zw = vec2(0.0, 0.0);
        tmpvar_163.x = ((tmpvar_156 + tmpvar_154) / RES_NU);
        tmpvar_163.y = ((uMu_143 / RES_R) + tmpvar_159);
        vec4 tmpvar_164;
        tmpvar_164.zw = vec2(0.0, 0.0);
        tmpvar_164.x = (((tmpvar_156 + tmpvar_154) + 1.0) / RES_NU);
        tmpvar_164.y = ((uMu_143 / RES_R) + tmpvar_159);
        inScatter0_93 = ((((texture2DLod (_Inscatter, tmpvar_161.xy, 0.0) * (1.0 - tmpvar_157)) + (texture2DLod (_Inscatter, tmpvar_162.xy, 0.0) * tmpvar_157)) * (1.0 - tmpvar_160)) + (((texture2DLod (_Inscatter, tmpvar_163.xy, 0.0) * (1.0 - tmpvar_157)) + (texture2DLod (_Inscatter, tmpvar_164.xy, 0.0) * tmpvar_157)) * tmpvar_160));
        float uMu_165;
        float uR_166;
        float tmpvar_167;
        tmpvar_167 = sqrt(((tmpvar_62 * tmpvar_62) - (Rg * Rg)));
        float tmpvar_168;
        tmpvar_168 = sqrt(((tmpvar_142 * tmpvar_142) - (Rg * Rg)));
        float tmpvar_169;
        tmpvar_169 = (tmpvar_142 * mu1_70);
        float tmpvar_170;
        tmpvar_170 = (((tmpvar_169 * tmpvar_169) - (tmpvar_142 * tmpvar_142)) + (Rg * Rg));
        vec4 tmpvar_171;
        if (((tmpvar_169 < 0.0) && (tmpvar_170 > 0.0))) {
          vec4 tmpvar_172;
          tmpvar_172.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_172.w = (0.5 - (0.5 / RES_MU));
          tmpvar_171 = tmpvar_172;
        } else {
          vec4 tmpvar_173;
          tmpvar_173.x = -1.0;
          tmpvar_173.y = (tmpvar_167 * tmpvar_167);
          tmpvar_173.z = tmpvar_167;
          tmpvar_173.w = (0.5 + (0.5 / RES_MU));
          tmpvar_171 = tmpvar_173;
        };
        uR_166 = ((0.5 / RES_R) + ((tmpvar_168 / tmpvar_167) * (1.0 - (1.0/(RES_R)))));
        uMu_165 = (tmpvar_171.w + ((((tmpvar_169 * tmpvar_171.x) + sqrt((tmpvar_170 + tmpvar_171.y))) / (tmpvar_168 + tmpvar_171.z)) * (0.5 - (1.0/(RES_MU)))));
        float y_over_x_174;
        y_over_x_174 = (max (muS1_69, -0.1975) * 5.34962);
        float x_175;
        x_175 = (y_over_x_174 * inversesqrt(((y_over_x_174 * y_over_x_174) + 1.0)));
        float tmpvar_176;
        tmpvar_176 = ((0.5 / RES_MU_S) + (((((sign(x_175) * (1.5708 - (sqrt((1.0 - abs(x_175))) * (1.5708 + (abs(x_175) * (-0.214602 + (abs(x_175) * (0.0865667 + (abs(x_175) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        float tmpvar_177;
        tmpvar_177 = (((tmpvar_73 + 1.0) / 2.0) * (RES_NU - 1.0));
        float tmpvar_178;
        tmpvar_178 = floor(tmpvar_177);
        float tmpvar_179;
        tmpvar_179 = (tmpvar_177 - tmpvar_178);
        float tmpvar_180;
        tmpvar_180 = (floor(((uR_166 * RES_R) - 1.0)) / RES_R);
        float tmpvar_181;
        tmpvar_181 = (floor((uR_166 * RES_R)) / RES_R);
        float tmpvar_182;
        tmpvar_182 = fract((uR_166 * RES_R));
        vec4 tmpvar_183;
        tmpvar_183.zw = vec2(0.0, 0.0);
        tmpvar_183.x = ((tmpvar_178 + tmpvar_176) / RES_NU);
        tmpvar_183.y = ((uMu_165 / RES_R) + tmpvar_180);
        vec4 tmpvar_184;
        tmpvar_184.zw = vec2(0.0, 0.0);
        tmpvar_184.x = (((tmpvar_178 + tmpvar_176) + 1.0) / RES_NU);
        tmpvar_184.y = ((uMu_165 / RES_R) + tmpvar_180);
        vec4 tmpvar_185;
        tmpvar_185.zw = vec2(0.0, 0.0);
        tmpvar_185.x = ((tmpvar_178 + tmpvar_176) / RES_NU);
        tmpvar_185.y = ((uMu_165 / RES_R) + tmpvar_181);
        vec4 tmpvar_186;
        tmpvar_186.zw = vec2(0.0, 0.0);
        tmpvar_186.x = (((tmpvar_178 + tmpvar_176) + 1.0) / RES_NU);
        tmpvar_186.y = ((uMu_165 / RES_R) + tmpvar_181);
        inScatter_72 = mix (inScatterA_92, max ((inScatter0_93 - (((((texture2DLod (_Inscatter, tmpvar_183.xy, 0.0) * (1.0 - tmpvar_179)) + (texture2DLod (_Inscatter, tmpvar_184.xy, 0.0) * tmpvar_179)) * (1.0 - tmpvar_182)) + (((texture2DLod (_Inscatter, tmpvar_185.xy, 0.0) * (1.0 - tmpvar_179)) + (texture2DLod (_Inscatter, tmpvar_186.xy, 0.0) * tmpvar_179)) * tmpvar_182)) * extinction_52.xyzx)), vec4(0.0, 0.0, 0.0, 0.0)), vec4(a_94));
      } else {
        vec4 inScatter0_1_187;
        float uMu_188;
        float uR_189;
        float tmpvar_190;
        tmpvar_190 = sqrt(((tmpvar_62 * tmpvar_62) - (Rg * Rg)));
        float tmpvar_191;
        tmpvar_191 = sqrt(((r_55 * r_55) - (Rg * Rg)));
        float tmpvar_192;
        tmpvar_192 = (r_55 * mu_53);
        float tmpvar_193;
        tmpvar_193 = (((tmpvar_192 * tmpvar_192) - (r_55 * r_55)) + (Rg * Rg));
        vec4 tmpvar_194;
        if (((tmpvar_192 < 0.0) && (tmpvar_193 > 0.0))) {
          vec4 tmpvar_195;
          tmpvar_195.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_195.w = (0.5 - (0.5 / RES_MU));
          tmpvar_194 = tmpvar_195;
        } else {
          vec4 tmpvar_196;
          tmpvar_196.x = -1.0;
          tmpvar_196.y = (tmpvar_190 * tmpvar_190);
          tmpvar_196.z = tmpvar_190;
          tmpvar_196.w = (0.5 + (0.5 / RES_MU));
          tmpvar_194 = tmpvar_196;
        };
        uR_189 = ((0.5 / RES_R) + ((tmpvar_191 / tmpvar_190) * (1.0 - (1.0/(RES_R)))));
        uMu_188 = (tmpvar_194.w + ((((tmpvar_192 * tmpvar_194.x) + sqrt((tmpvar_193 + tmpvar_194.y))) / (tmpvar_191 + tmpvar_194.z)) * (0.5 - (1.0/(RES_MU)))));
        float y_over_x_197;
        y_over_x_197 = (max (tmpvar_74, -0.1975) * 5.34962);
        float x_198;
        x_198 = (y_over_x_197 * inversesqrt(((y_over_x_197 * y_over_x_197) + 1.0)));
        float tmpvar_199;
        tmpvar_199 = ((0.5 / RES_MU_S) + (((((sign(x_198) * (1.5708 - (sqrt((1.0 - abs(x_198))) * (1.5708 + (abs(x_198) * (-0.214602 + (abs(x_198) * (0.0865667 + (abs(x_198) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        float tmpvar_200;
        tmpvar_200 = (((tmpvar_73 + 1.0) / 2.0) * (RES_NU - 1.0));
        float tmpvar_201;
        tmpvar_201 = floor(tmpvar_200);
        float tmpvar_202;
        tmpvar_202 = (tmpvar_200 - tmpvar_201);
        float tmpvar_203;
        tmpvar_203 = (floor(((uR_189 * RES_R) - 1.0)) / RES_R);
        float tmpvar_204;
        tmpvar_204 = (floor((uR_189 * RES_R)) / RES_R);
        float tmpvar_205;
        tmpvar_205 = fract((uR_189 * RES_R));
        vec4 tmpvar_206;
        tmpvar_206.zw = vec2(0.0, 0.0);
        tmpvar_206.x = ((tmpvar_201 + tmpvar_199) / RES_NU);
        tmpvar_206.y = ((uMu_188 / RES_R) + tmpvar_203);
        vec4 tmpvar_207;
        tmpvar_207.zw = vec2(0.0, 0.0);
        tmpvar_207.x = (((tmpvar_201 + tmpvar_199) + 1.0) / RES_NU);
        tmpvar_207.y = ((uMu_188 / RES_R) + tmpvar_203);
        vec4 tmpvar_208;
        tmpvar_208.zw = vec2(0.0, 0.0);
        tmpvar_208.x = ((tmpvar_201 + tmpvar_199) / RES_NU);
        tmpvar_208.y = ((uMu_188 / RES_R) + tmpvar_204);
        vec4 tmpvar_209;
        tmpvar_209.zw = vec2(0.0, 0.0);
        tmpvar_209.x = (((tmpvar_201 + tmpvar_199) + 1.0) / RES_NU);
        tmpvar_209.y = ((uMu_188 / RES_R) + tmpvar_204);
        inScatter0_1_187 = ((((texture2DLod (_Inscatter, tmpvar_206.xy, 0.0) * (1.0 - tmpvar_202)) + (texture2DLod (_Inscatter, tmpvar_207.xy, 0.0) * tmpvar_202)) * (1.0 - tmpvar_205)) + (((texture2DLod (_Inscatter, tmpvar_208.xy, 0.0) * (1.0 - tmpvar_202)) + (texture2DLod (_Inscatter, tmpvar_209.xy, 0.0) * tmpvar_202)) * tmpvar_205));
        float uMu_210;
        float uR_211;
        float tmpvar_212;
        tmpvar_212 = sqrt(((tmpvar_62 * tmpvar_62) - (Rg * Rg)));
        float tmpvar_213;
        tmpvar_213 = sqrt(((r1_71 * r1_71) - (Rg * Rg)));
        float tmpvar_214;
        tmpvar_214 = (r1_71 * mu1_70);
        float tmpvar_215;
        tmpvar_215 = (((tmpvar_214 * tmpvar_214) - (r1_71 * r1_71)) + (Rg * Rg));
        vec4 tmpvar_216;
        if (((tmpvar_214 < 0.0) && (tmpvar_215 > 0.0))) {
          vec4 tmpvar_217;
          tmpvar_217.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_217.w = (0.5 - (0.5 / RES_MU));
          tmpvar_216 = tmpvar_217;
        } else {
          vec4 tmpvar_218;
          tmpvar_218.x = -1.0;
          tmpvar_218.y = (tmpvar_212 * tmpvar_212);
          tmpvar_218.z = tmpvar_212;
          tmpvar_218.w = (0.5 + (0.5 / RES_MU));
          tmpvar_216 = tmpvar_218;
        };
        uR_211 = ((0.5 / RES_R) + ((tmpvar_213 / tmpvar_212) * (1.0 - (1.0/(RES_R)))));
        uMu_210 = (tmpvar_216.w + ((((tmpvar_214 * tmpvar_216.x) + sqrt((tmpvar_215 + tmpvar_216.y))) / (tmpvar_213 + tmpvar_216.z)) * (0.5 - (1.0/(RES_MU)))));
        float y_over_x_219;
        y_over_x_219 = (max (muS1_69, -0.1975) * 5.34962);
        float x_220;
        x_220 = (y_over_x_219 * inversesqrt(((y_over_x_219 * y_over_x_219) + 1.0)));
        float tmpvar_221;
        tmpvar_221 = ((0.5 / RES_MU_S) + (((((sign(x_220) * (1.5708 - (sqrt((1.0 - abs(x_220))) * (1.5708 + (abs(x_220) * (-0.214602 + (abs(x_220) * (0.0865667 + (abs(x_220) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        float tmpvar_222;
        tmpvar_222 = (((tmpvar_73 + 1.0) / 2.0) * (RES_NU - 1.0));
        float tmpvar_223;
        tmpvar_223 = floor(tmpvar_222);
        float tmpvar_224;
        tmpvar_224 = (tmpvar_222 - tmpvar_223);
        float tmpvar_225;
        tmpvar_225 = (floor(((uR_211 * RES_R) - 1.0)) / RES_R);
        float tmpvar_226;
        tmpvar_226 = (floor((uR_211 * RES_R)) / RES_R);
        float tmpvar_227;
        tmpvar_227 = fract((uR_211 * RES_R));
        vec4 tmpvar_228;
        tmpvar_228.zw = vec2(0.0, 0.0);
        tmpvar_228.x = ((tmpvar_223 + tmpvar_221) / RES_NU);
        tmpvar_228.y = ((uMu_210 / RES_R) + tmpvar_225);
        vec4 tmpvar_229;
        tmpvar_229.zw = vec2(0.0, 0.0);
        tmpvar_229.x = (((tmpvar_223 + tmpvar_221) + 1.0) / RES_NU);
        tmpvar_229.y = ((uMu_210 / RES_R) + tmpvar_225);
        vec4 tmpvar_230;
        tmpvar_230.zw = vec2(0.0, 0.0);
        tmpvar_230.x = ((tmpvar_223 + tmpvar_221) / RES_NU);
        tmpvar_230.y = ((uMu_210 / RES_R) + tmpvar_226);
        vec4 tmpvar_231;
        tmpvar_231.zw = vec2(0.0, 0.0);
        tmpvar_231.x = (((tmpvar_223 + tmpvar_221) + 1.0) / RES_NU);
        tmpvar_231.y = ((uMu_210 / RES_R) + tmpvar_226);
        inScatter_72 = max ((inScatter0_1_187 - (((((texture2DLod (_Inscatter, tmpvar_228.xy, 0.0) * (1.0 - tmpvar_224)) + (texture2DLod (_Inscatter, tmpvar_229.xy, 0.0) * tmpvar_224)) * (1.0 - tmpvar_227)) + (((texture2DLod (_Inscatter, tmpvar_230.xy, 0.0) * (1.0 - tmpvar_224)) + (texture2DLod (_Inscatter, tmpvar_231.xy, 0.0) * tmpvar_224)) * tmpvar_227)) * extinction_52.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      };
      float t_232;
      t_232 = max (min ((tmpvar_74 / 0.02), 1.0), 0.0);
      inScatter_72.w = (inScatter_72.w * (t_232 * (t_232 * (3.0 - (2.0 * t_232)))));
      result_58 = ((inScatter_72.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_73 * tmpvar_73)))) + ((((inScatter_72.xyz * inScatter_72.w) / max (inScatter_72.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_73)), -1.5)) * (1.0 + (tmpvar_73 * tmpvar_73))) / (2.0 + (mieG * mieG)))));
    };
    tmpvar_49 = (result_58 * SUN_INTENSITY);
    visib_2 = 1.0;
    float tmpvar_233;
    vec3 arg0_234;
    arg0_234 = (worldPos_4 - _camPos);
    tmpvar_233 = sqrt(dot (arg0_234, arg0_234));
    dpth_5 = tmpvar_233;
    if ((tmpvar_233 <= _global_depth)) {
      visib_2 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_233) / _global_depth))));
    };
    if (((tmpvar_14 && tmpvar_18) && (fakeOcean == 1.0))) {
      vec3 L_235;
      L_235 = (oceanColor_3 * extinction_52);
      vec3 tmpvar_236;
      tmpvar_236 = (L_235 * _Exposure);
      L_235 = tmpvar_236;
      float tmpvar_237;
      if ((tmpvar_236.x < 1.413)) {
        tmpvar_237 = pow ((tmpvar_236.x * 0.38317), 0.454545);
      } else {
        tmpvar_237 = (1.0 - exp(-(tmpvar_236.x)));
      };
      L_235.x = tmpvar_237;
      float tmpvar_238;
      if ((tmpvar_236.y < 1.413)) {
        tmpvar_238 = pow ((tmpvar_236.y * 0.38317), 0.454545);
      } else {
        tmpvar_238 = (1.0 - exp(-(tmpvar_236.y)));
      };
      L_235.y = tmpvar_238;
      float tmpvar_239;
      if ((tmpvar_236.z < 1.413)) {
        tmpvar_239 = pow ((tmpvar_236.z * 0.38317), 0.454545);
      } else {
        tmpvar_239 = (1.0 - exp(-(tmpvar_236.z)));
      };
      L_235.z = tmpvar_239;
      vec3 L_240;
      vec3 tmpvar_241;
      tmpvar_241 = (tmpvar_49 * _Exposure);
      L_240 = tmpvar_241;
      float tmpvar_242;
      if ((tmpvar_241.x < 1.413)) {
        tmpvar_242 = pow ((tmpvar_241.x * 0.38317), 0.454545);
      } else {
        tmpvar_242 = (1.0 - exp(-(tmpvar_241.x)));
      };
      L_240.x = tmpvar_242;
      float tmpvar_243;
      if ((tmpvar_241.y < 1.413)) {
        tmpvar_243 = pow ((tmpvar_241.y * 0.38317), 0.454545);
      } else {
        tmpvar_243 = (1.0 - exp(-(tmpvar_241.y)));
      };
      L_240.y = tmpvar_243;
      float tmpvar_244;
      if ((tmpvar_241.z < 1.413)) {
        tmpvar_244 = pow ((tmpvar_241.z * 0.38317), 0.454545);
      } else {
        tmpvar_244 = (1.0 - exp(-(tmpvar_241.z)));
      };
      L_240.z = tmpvar_244;
      vec4 tmpvar_245;
      tmpvar_245.xyz = mix (L_235, L_240, vec3((_global_alpha * visib_2)));
      tmpvar_245.w = _fade;
      tmpvar_1 = tmpvar_245;
    } else {
      vec3 L_246;
      vec3 tmpvar_247;
      tmpvar_247 = (tmpvar_49 * _Exposure);
      L_246 = tmpvar_247;
      float tmpvar_248;
      if ((tmpvar_247.x < 1.413)) {
        tmpvar_248 = pow ((tmpvar_247.x * 0.38317), 0.454545);
      } else {
        tmpvar_248 = (1.0 - exp(-(tmpvar_247.x)));
      };
      L_246.x = tmpvar_248;
      float tmpvar_249;
      if ((tmpvar_247.y < 1.413)) {
        tmpvar_249 = pow ((tmpvar_247.y * 0.38317), 0.454545);
      } else {
        tmpvar_249 = (1.0 - exp(-(tmpvar_247.y)));
      };
      L_246.y = tmpvar_249;
      float tmpvar_250;
      if ((tmpvar_247.z < 1.413)) {
        tmpvar_250 = pow ((tmpvar_247.z * 0.38317), 0.454545);
      } else {
        tmpvar_250 = (1.0 - exp(-(tmpvar_247.z)));
      };
      L_246.z = tmpvar_250;
      vec4 tmpvar_251;
      tmpvar_251.xyz = L_246;
      tmpvar_251.w = ((_global_alpha * visib_2) * _fade);
      tmpvar_1 = tmpvar_251;
    };
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 20 math, 1 branches
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_TexelSize]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c11, 0.50000000, 0.00000000, 1.00000000, 0
dcl_position0 v0
dp4 r1.z, v0, c7
dp4 r0.x, v0, c4
rcp r0.z, r1.z
mov r0.w, r1.z
dp4 r0.y, v0, c5
mul r2.xyz, r0.xyww, c11.x
mov r1.w, c11.y
mov r1.x, r2
mul r1.y, r2, c8.x
mad r1.xy, r2.z, c9.zwzw, r1
mul r2.zw, r1.xyxy, r0.z
mov r2.xy, r2.zwzw
dp4 r0.z, v0, c6
if_lt c10.y, r1.w
add r2.y, -r2, c11.z
endif
mov o0, r0
dp4 r0.x, v0, c2
mov o1.xyw, r1.xyzz
mov o2.xy, r2
mov o3.xy, r2.zwzw
mov o1.z, -r0.x
"
}
SubProgram "d3d11 " {
// Stats: 15 math
Bind "vertex" Vertex
ConstBuffer "$Globals" 336
Vector 240 [_MainTex_TexelSize]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmgbdogkfpepfnfpeahipjeiboghdobaeabaaaaaabmaeaaaaadaaaaaa
cmaaaaaakaaaaaaaciabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcomacaaaaeaaaabaallaaaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
mccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
ecaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaackaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpaaaaaaahdcaabaaaaaaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaflccabaaaabaaaaaaegambaaa
aaaaaaaaaoaaaaahhcaabaaaaaaaaaaaagabbaaaaaaaaaaapgapbaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dbaaaaaibcaabaaaabaaaaaabkiacaaaaaaaaaaaapaaaaaaabeaaaaaaaaaaaaa
dhaaaaajcccabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadgaaaaafnccabaaaacaaaaaaagajbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform highp vec4 _ZBufferParams;
uniform sampler2D _Transmittance;
uniform sampler2D _Inscatter;
uniform sampler2D _Irradiance;
uniform highp float M_PI;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp mat4 _ViewProjInv;
uniform highp float _viewdirOffset;
uniform highp float _experimentalAtmoScale;
uniform highp float _global_alpha;
uniform highp float _Exposure;
uniform highp float _global_depth;
uniform highp float _Ocean_Sigma;
uniform highp float fakeOcean;
uniform highp float _fade;
uniform highp vec3 _Ocean_Color;
uniform highp vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform highp float _openglThreshold;
uniform highp float _edgeThreshold;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp float visib_2;
  highp vec3 oceanColor_3;
  highp vec3 worldPos_4;
  highp float depth_5;
  highp float dpth_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_customDepthTexture, xlv_TEXCOORD2);
  highp float z_8;
  z_8 = tmpvar_7.x;
  dpth_6 = (1.0/(((_ZBufferParams.x * z_8) + _ZBufferParams.y)));
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_10.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_10.z = depth_5;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_ViewProjInv * tmpvar_10);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 / tmpvar_11.w).xyz;
  worldPos_4 = tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 - _camPos);
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = (2.0 * dot (tmpvar_14, _camPos));
  highp float tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_17 < 0.0)) {
    tmpvar_13 = -1.0;
  } else {
    tmpvar_13 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
  };
  bool tmpvar_18;
  tmpvar_18 = (tmpvar_13 > 0.0);
  if (((dpth_6 >= _edgeThreshold) && !(tmpvar_18))) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_19;
    tmpvar_19 = (_camPos + (tmpvar_13 * (tmpvar_12 - _camPos)));
    highp vec3 arg0_20;
    arg0_20 = (tmpvar_19 - _camPos);
    highp vec3 arg0_21;
    arg0_21 = (tmpvar_12 - _camPos);
    bool tmpvar_22;
    tmpvar_22 = (sqrt(dot (arg0_20, arg0_20)) < sqrt(dot (arg0_21, arg0_21)));
    oceanColor_3 = vec3(1.0, 1.0, 1.0);
    if ((tmpvar_18 && tmpvar_22)) {
      worldPos_4 = tmpvar_19;
      if ((fakeOcean == 1.0)) {
        highp vec3 tmpvar_23;
        tmpvar_23 = normalize(tmpvar_19);
        highp vec3 tmpvar_24;
        tmpvar_24 = (tmpvar_23 * max (sqrt(dot (tmpvar_19, tmpvar_19)), (Rg + 10.0)));
        highp vec3 tmpvar_25;
        tmpvar_25 = normalize((tmpvar_24 - _camPos));
        highp vec3 worldP_26;
        worldP_26 = tmpvar_24;
        highp float r_27;
        highp float tmpvar_28;
        tmpvar_28 = sqrt(dot (tmpvar_24, tmpvar_24));
        r_27 = tmpvar_28;
        if ((tmpvar_28 < (0.9 * Rg))) {
          worldP_26.z = (tmpvar_24.z + Rg);
          r_27 = sqrt(dot (worldP_26, worldP_26));
        };
        highp vec3 tmpvar_29;
        tmpvar_29 = (worldP_26 / r_27);
        highp float tmpvar_30;
        tmpvar_30 = dot (tmpvar_29, SUN_DIR);
        highp float tmpvar_31;
        tmpvar_31 = sqrt((1.0 - ((Rg / r_27) * (Rg / r_27))));
        highp vec3 tmpvar_32;
        if ((tmpvar_30 < -(tmpvar_31))) {
          tmpvar_32 = vec3(0.0, 0.0, 0.0);
        } else {
          highp vec3 tmpvar_33;
          highp float y_over_x_34;
          y_over_x_34 = (((tmpvar_30 + 0.15) / 1.15) * 14.1014);
          highp float x_35;
          x_35 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
          highp vec4 tmpvar_36;
          tmpvar_36.zw = vec2(0.0, 0.0);
          tmpvar_36.x = ((sign(x_35) * (1.5708 - (sqrt((1.0 - abs(x_35))) * (1.5708 + (abs(x_35) * (-0.214602 + (abs(x_35) * (0.0865667 + (abs(x_35) * -0.0310296))))))))) / 1.5);
          tmpvar_36.y = sqrt(((r_27 - Rg) / (Rt - Rg)));
          lowp vec4 tmpvar_37;
          tmpvar_37 = texture2DLodEXT (_Transmittance, tmpvar_36.xy, 0.0);
          tmpvar_33 = tmpvar_37.xyz;
          tmpvar_32 = tmpvar_33;
        };
        highp vec3 tmpvar_38;
        tmpvar_38 = (tmpvar_32 * SUN_INTENSITY);
        highp vec3 tmpvar_39;
        highp vec2 tmpvar_40;
        tmpvar_40.x = ((tmpvar_30 + 0.2) / 1.2);
        tmpvar_40.y = ((r_27 - Rg) / (Rt - Rg));
        lowp vec4 tmpvar_41;
        tmpvar_41 = texture2DLodEXT (_Irradiance, tmpvar_40, 0.0);
        tmpvar_39 = tmpvar_41.xyz;
        highp vec3 tmpvar_42;
        tmpvar_42 = (((2.0 * tmpvar_39) * SUN_INTENSITY) * ((1.0 + tmpvar_29.z) * 0.5));
        highp vec3 V_43;
        V_43 = -(tmpvar_25);
        highp vec3 seaColor_44;
        seaColor_44 = (_Ocean_Color * 10.0);
        highp float tmpvar_45;
        tmpvar_45 = sqrt(_Ocean_Sigma);
        highp float tmpvar_46;
        tmpvar_46 = (pow ((1.0 - dot (V_43, tmpvar_23)), (5.0 * exp((-2.69 * tmpvar_45)))) / (1.0 + (22.7 * pow (tmpvar_45, 1.5))));
        highp vec3 tmpvar_47;
        tmpvar_47 = normalize((SUN_DIR + V_43));
        highp float tmpvar_48;
        tmpvar_48 = dot (tmpvar_47, tmpvar_23);
        highp float tmpvar_49;
        tmpvar_49 = (exp(((-2.0 * ((1.0 - (tmpvar_48 * tmpvar_48)) / _Ocean_Sigma)) / (1.0 + tmpvar_48))) / ((4.0 * M_PI) * _Ocean_Sigma));
        highp float tmpvar_50;
        tmpvar_50 = (1.0 - dot (V_43, tmpvar_47));
        highp float tmpvar_51;
        tmpvar_51 = (tmpvar_50 * tmpvar_50);
        highp float tmpvar_52;
        tmpvar_52 = (0.02 + (((0.98 * tmpvar_51) * tmpvar_51) * tmpvar_50));
        highp float tmpvar_53;
        tmpvar_53 = max (dot (SUN_DIR, tmpvar_23), 0.01);
        highp float tmpvar_54;
        tmpvar_54 = max (dot (V_43, tmpvar_23), 0.01);
        highp float tmpvar_55;
        if ((tmpvar_53 <= 0.0)) {
          tmpvar_55 = 0.0;
        } else {
          tmpvar_55 = max (((tmpvar_52 * tmpvar_49) * sqrt(abs((tmpvar_53 / tmpvar_54)))), 0.0);
        };
        oceanColor_3 = (((tmpvar_55 * tmpvar_38) + ((tmpvar_42 * tmpvar_46) / M_PI)) + ((((1.0 - tmpvar_46) * seaColor_44) * tmpvar_42) / M_PI));
      };
    };
    highp float tmpvar_56;
    tmpvar_56 = sqrt(dot (worldPos_4, worldPos_4));
    if ((tmpvar_56 < (Rg + _openglThreshold))) {
      worldPos_4 = ((Rg + _openglThreshold) * normalize(worldPos_4));
    };
    highp vec3 tmpvar_57;
    highp vec3 camera_58;
    camera_58 = _camPos;
    highp vec3 _point_59;
    _point_59 = worldPos_4;
    highp vec3 extinction_60;
    highp float mu_61;
    highp float rMu_62;
    highp float r_63;
    highp float d_64;
    highp vec3 viewdir_65;
    highp vec3 result_66;
    result_66 = vec3(0.0, 0.0, 0.0);
    extinction_60 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_67;
    tmpvar_67 = (worldPos_4 - _camPos);
    highp float tmpvar_68;
    tmpvar_68 = sqrt(dot (tmpvar_67, tmpvar_67));
    d_64 = tmpvar_68;
    highp vec3 tmpvar_69;
    tmpvar_69 = (tmpvar_67 / tmpvar_68);
    viewdir_65.yz = tmpvar_69.yz;
    highp float tmpvar_70;
    tmpvar_70 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    viewdir_65.x = (tmpvar_69.x + _viewdirOffset);
    highp vec3 tmpvar_71;
    tmpvar_71 = normalize(viewdir_65);
    viewdir_65 = tmpvar_71;
    highp float tmpvar_72;
    tmpvar_72 = sqrt(dot (_camPos, _camPos));
    r_63 = tmpvar_72;
    if ((tmpvar_72 < (0.9 * Rg))) {
      camera_58.y = (_camPos.y + Rg);
      _point_59.y = (worldPos_4.y + Rg);
      r_63 = sqrt(dot (camera_58, camera_58));
    };
    highp float tmpvar_73;
    tmpvar_73 = dot (camera_58, tmpvar_71);
    rMu_62 = tmpvar_73;
    mu_61 = (tmpvar_73 / r_63);
    highp vec3 tmpvar_74;
    tmpvar_74 = (_point_59 - (tmpvar_71 * clamp (1.0, 0.0, tmpvar_68)));
    _point_59 = tmpvar_74;
    highp float tmpvar_75;
    tmpvar_75 = max ((-(tmpvar_73) - sqrt((((tmpvar_73 * tmpvar_73) - (r_63 * r_63)) + (tmpvar_70 * tmpvar_70)))), 0.0);
    if (((tmpvar_75 > 0.0) && (tmpvar_75 < tmpvar_68))) {
      camera_58 = (camera_58 + (tmpvar_75 * tmpvar_71));
      highp float tmpvar_76;
      tmpvar_76 = (tmpvar_73 + tmpvar_75);
      rMu_62 = tmpvar_76;
      mu_61 = (tmpvar_76 / tmpvar_70);
      r_63 = tmpvar_70;
      d_64 = (tmpvar_68 - tmpvar_75);
    };
    if ((r_63 <= tmpvar_70)) {
      highp float muS1_77;
      highp float mu1_78;
      highp float r1_79;
      highp vec4 inScatter_80;
      highp float tmpvar_81;
      tmpvar_81 = dot (tmpvar_71, SUN_DIR);
      highp float tmpvar_82;
      tmpvar_82 = (dot (camera_58, SUN_DIR) / r_63);
      if ((r_63 < (Rg + 600.0))) {
        highp float tmpvar_83;
        tmpvar_83 = ((Rg + 600.0) / r_63);
        r_63 = (r_63 * tmpvar_83);
        rMu_62 = (rMu_62 * tmpvar_83);
        _point_59 = (tmpvar_74 * tmpvar_83);
      };
      highp float tmpvar_84;
      tmpvar_84 = sqrt(dot (_point_59, _point_59));
      r1_79 = tmpvar_84;
      highp float tmpvar_85;
      tmpvar_85 = (dot (_point_59, tmpvar_71) / tmpvar_84);
      mu1_78 = tmpvar_85;
      muS1_77 = (dot (_point_59, SUN_DIR) / tmpvar_84);
      if ((mu_61 > 0.0)) {
        highp vec3 tmpvar_86;
        highp float y_over_x_87;
        y_over_x_87 = (((mu_61 + 0.15) / 1.15) * 14.1014);
        highp float x_88;
        x_88 = (y_over_x_87 * inversesqrt(((y_over_x_87 * y_over_x_87) + 1.0)));
        highp vec4 tmpvar_89;
        tmpvar_89.zw = vec2(0.0, 0.0);
        tmpvar_89.x = ((sign(x_88) * (1.5708 - (sqrt((1.0 - abs(x_88))) * (1.5708 + (abs(x_88) * (-0.214602 + (abs(x_88) * (0.0865667 + (abs(x_88) * -0.0310296))))))))) / 1.5);
        tmpvar_89.y = sqrt(((r_63 - Rg) / (tmpvar_70 - Rg)));
        lowp vec4 tmpvar_90;
        tmpvar_90 = texture2DLodEXT (_Transmittance, tmpvar_89.xy, 0.0);
        tmpvar_86 = tmpvar_90.xyz;
        highp vec3 tmpvar_91;
        highp float y_over_x_92;
        y_over_x_92 = (((tmpvar_85 + 0.15) / 1.15) * 14.1014);
        highp float x_93;
        x_93 = (y_over_x_92 * inversesqrt(((y_over_x_92 * y_over_x_92) + 1.0)));
        highp vec4 tmpvar_94;
        tmpvar_94.zw = vec2(0.0, 0.0);
        tmpvar_94.x = ((sign(x_93) * (1.5708 - (sqrt((1.0 - abs(x_93))) * (1.5708 + (abs(x_93) * (-0.214602 + (abs(x_93) * (0.0865667 + (abs(x_93) * -0.0310296))))))))) / 1.5);
        tmpvar_94.y = sqrt(((tmpvar_84 - Rg) / (tmpvar_70 - Rg)));
        lowp vec4 tmpvar_95;
        tmpvar_95 = texture2DLodEXT (_Transmittance, tmpvar_94.xy, 0.0);
        tmpvar_91 = tmpvar_95.xyz;
        extinction_60 = min ((tmpvar_86 / tmpvar_91), vec3(1.0, 1.0, 1.0));
      } else {
        highp vec3 tmpvar_96;
        highp float y_over_x_97;
        y_over_x_97 = (((-(tmpvar_85) + 0.15) / 1.15) * 14.1014);
        highp float x_98;
        x_98 = (y_over_x_97 * inversesqrt(((y_over_x_97 * y_over_x_97) + 1.0)));
        highp vec4 tmpvar_99;
        tmpvar_99.zw = vec2(0.0, 0.0);
        tmpvar_99.x = ((sign(x_98) * (1.5708 - (sqrt((1.0 - abs(x_98))) * (1.5708 + (abs(x_98) * (-0.214602 + (abs(x_98) * (0.0865667 + (abs(x_98) * -0.0310296))))))))) / 1.5);
        tmpvar_99.y = sqrt(((tmpvar_84 - Rg) / (tmpvar_70 - Rg)));
        lowp vec4 tmpvar_100;
        tmpvar_100 = texture2DLodEXT (_Transmittance, tmpvar_99.xy, 0.0);
        tmpvar_96 = tmpvar_100.xyz;
        highp vec3 tmpvar_101;
        highp float y_over_x_102;
        y_over_x_102 = (((-(mu_61) + 0.15) / 1.15) * 14.1014);
        highp float x_103;
        x_103 = (y_over_x_102 * inversesqrt(((y_over_x_102 * y_over_x_102) + 1.0)));
        highp vec4 tmpvar_104;
        tmpvar_104.zw = vec2(0.0, 0.0);
        tmpvar_104.x = ((sign(x_103) * (1.5708 - (sqrt((1.0 - abs(x_103))) * (1.5708 + (abs(x_103) * (-0.214602 + (abs(x_103) * (0.0865667 + (abs(x_103) * -0.0310296))))))))) / 1.5);
        tmpvar_104.y = sqrt(((r_63 - Rg) / (tmpvar_70 - Rg)));
        lowp vec4 tmpvar_105;
        tmpvar_105 = texture2DLodEXT (_Transmittance, tmpvar_104.xy, 0.0);
        tmpvar_101 = tmpvar_105.xyz;
        extinction_60 = min ((tmpvar_96 / tmpvar_101), vec3(1.0, 1.0, 1.0));
      };
      highp float tmpvar_106;
      tmpvar_106 = -(sqrt((1.0 - ((Rg / r_63) * (Rg / r_63)))));
      highp float tmpvar_107;
      tmpvar_107 = abs((mu_61 - tmpvar_106));
      if ((tmpvar_107 < 0.004)) {
        highp vec4 inScatterA_108;
        highp vec4 inScatter0_109;
        highp float a_110;
        a_110 = (((mu_61 - tmpvar_106) + 0.004) / 0.008);
        highp float tmpvar_111;
        tmpvar_111 = (tmpvar_106 - 0.004);
        mu_61 = tmpvar_111;
        highp float tmpvar_112;
        tmpvar_112 = sqrt((((r_63 * r_63) + (d_64 * d_64)) + (((2.0 * r_63) * d_64) * tmpvar_111)));
        r1_79 = tmpvar_112;
        mu1_78 = (((r_63 * tmpvar_111) + d_64) / tmpvar_112);
        highp float uMu_113;
        highp float uR_114;
        highp float tmpvar_115;
        tmpvar_115 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_116;
        tmpvar_116 = sqrt(((r_63 * r_63) - (Rg * Rg)));
        highp float tmpvar_117;
        tmpvar_117 = (r_63 * tmpvar_111);
        highp float tmpvar_118;
        tmpvar_118 = (((tmpvar_117 * tmpvar_117) - (r_63 * r_63)) + (Rg * Rg));
        highp vec4 tmpvar_119;
        if (((tmpvar_117 < 0.0) && (tmpvar_118 > 0.0))) {
          highp vec4 tmpvar_120;
          tmpvar_120.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_120.w = (0.5 - (0.5 / RES_MU));
          tmpvar_119 = tmpvar_120;
        } else {
          highp vec4 tmpvar_121;
          tmpvar_121.x = -1.0;
          tmpvar_121.y = (tmpvar_115 * tmpvar_115);
          tmpvar_121.z = tmpvar_115;
          tmpvar_121.w = (0.5 + (0.5 / RES_MU));
          tmpvar_119 = tmpvar_121;
        };
        uR_114 = ((0.5 / RES_R) + ((tmpvar_116 / tmpvar_115) * (1.0 - (1.0/(RES_R)))));
        uMu_113 = (tmpvar_119.w + ((((tmpvar_117 * tmpvar_119.x) + sqrt((tmpvar_118 + tmpvar_119.y))) / (tmpvar_116 + tmpvar_119.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_122;
        y_over_x_122 = (max (tmpvar_82, -0.1975) * 5.34962);
        highp float x_123;
        x_123 = (y_over_x_122 * inversesqrt(((y_over_x_122 * y_over_x_122) + 1.0)));
        highp float tmpvar_124;
        tmpvar_124 = ((0.5 / RES_MU_S) + (((((sign(x_123) * (1.5708 - (sqrt((1.0 - abs(x_123))) * (1.5708 + (abs(x_123) * (-0.214602 + (abs(x_123) * (0.0865667 + (abs(x_123) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_125;
        tmpvar_125 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_126;
        tmpvar_126 = floor(tmpvar_125);
        highp float tmpvar_127;
        tmpvar_127 = (tmpvar_125 - tmpvar_126);
        highp float tmpvar_128;
        tmpvar_128 = (floor(((uR_114 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_129;
        tmpvar_129 = (floor((uR_114 * RES_R)) / RES_R);
        highp float tmpvar_130;
        tmpvar_130 = fract((uR_114 * RES_R));
        highp vec4 tmpvar_131;
        tmpvar_131.zw = vec2(0.0, 0.0);
        tmpvar_131.x = ((tmpvar_126 + tmpvar_124) / RES_NU);
        tmpvar_131.y = ((uMu_113 / RES_R) + tmpvar_128);
        lowp vec4 tmpvar_132;
        tmpvar_132 = texture2DLodEXT (_Inscatter, tmpvar_131.xy, 0.0);
        highp vec4 tmpvar_133;
        tmpvar_133.zw = vec2(0.0, 0.0);
        tmpvar_133.x = (((tmpvar_126 + tmpvar_124) + 1.0) / RES_NU);
        tmpvar_133.y = ((uMu_113 / RES_R) + tmpvar_128);
        lowp vec4 tmpvar_134;
        tmpvar_134 = texture2DLodEXT (_Inscatter, tmpvar_133.xy, 0.0);
        highp vec4 tmpvar_135;
        tmpvar_135.zw = vec2(0.0, 0.0);
        tmpvar_135.x = ((tmpvar_126 + tmpvar_124) / RES_NU);
        tmpvar_135.y = ((uMu_113 / RES_R) + tmpvar_129);
        lowp vec4 tmpvar_136;
        tmpvar_136 = texture2DLodEXT (_Inscatter, tmpvar_135.xy, 0.0);
        highp vec4 tmpvar_137;
        tmpvar_137.zw = vec2(0.0, 0.0);
        tmpvar_137.x = (((tmpvar_126 + tmpvar_124) + 1.0) / RES_NU);
        tmpvar_137.y = ((uMu_113 / RES_R) + tmpvar_129);
        lowp vec4 tmpvar_138;
        tmpvar_138 = texture2DLodEXT (_Inscatter, tmpvar_137.xy, 0.0);
        inScatter0_109 = ((((tmpvar_132 * (1.0 - tmpvar_127)) + (tmpvar_134 * tmpvar_127)) * (1.0 - tmpvar_130)) + (((tmpvar_136 * (1.0 - tmpvar_127)) + (tmpvar_138 * tmpvar_127)) * tmpvar_130));
        highp float uMu_139;
        highp float uR_140;
        highp float tmpvar_141;
        tmpvar_141 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_142;
        tmpvar_142 = sqrt(((tmpvar_112 * tmpvar_112) - (Rg * Rg)));
        highp float tmpvar_143;
        tmpvar_143 = (tmpvar_112 * mu1_78);
        highp float tmpvar_144;
        tmpvar_144 = (((tmpvar_143 * tmpvar_143) - (tmpvar_112 * tmpvar_112)) + (Rg * Rg));
        highp vec4 tmpvar_145;
        if (((tmpvar_143 < 0.0) && (tmpvar_144 > 0.0))) {
          highp vec4 tmpvar_146;
          tmpvar_146.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_146.w = (0.5 - (0.5 / RES_MU));
          tmpvar_145 = tmpvar_146;
        } else {
          highp vec4 tmpvar_147;
          tmpvar_147.x = -1.0;
          tmpvar_147.y = (tmpvar_141 * tmpvar_141);
          tmpvar_147.z = tmpvar_141;
          tmpvar_147.w = (0.5 + (0.5 / RES_MU));
          tmpvar_145 = tmpvar_147;
        };
        uR_140 = ((0.5 / RES_R) + ((tmpvar_142 / tmpvar_141) * (1.0 - (1.0/(RES_R)))));
        uMu_139 = (tmpvar_145.w + ((((tmpvar_143 * tmpvar_145.x) + sqrt((tmpvar_144 + tmpvar_145.y))) / (tmpvar_142 + tmpvar_145.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_148;
        y_over_x_148 = (max (muS1_77, -0.1975) * 5.34962);
        highp float x_149;
        x_149 = (y_over_x_148 * inversesqrt(((y_over_x_148 * y_over_x_148) + 1.0)));
        highp float tmpvar_150;
        tmpvar_150 = ((0.5 / RES_MU_S) + (((((sign(x_149) * (1.5708 - (sqrt((1.0 - abs(x_149))) * (1.5708 + (abs(x_149) * (-0.214602 + (abs(x_149) * (0.0865667 + (abs(x_149) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_151;
        tmpvar_151 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_152;
        tmpvar_152 = floor(tmpvar_151);
        highp float tmpvar_153;
        tmpvar_153 = (tmpvar_151 - tmpvar_152);
        highp float tmpvar_154;
        tmpvar_154 = (floor(((uR_140 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_155;
        tmpvar_155 = (floor((uR_140 * RES_R)) / RES_R);
        highp float tmpvar_156;
        tmpvar_156 = fract((uR_140 * RES_R));
        highp vec4 tmpvar_157;
        tmpvar_157.zw = vec2(0.0, 0.0);
        tmpvar_157.x = ((tmpvar_152 + tmpvar_150) / RES_NU);
        tmpvar_157.y = ((uMu_139 / RES_R) + tmpvar_154);
        lowp vec4 tmpvar_158;
        tmpvar_158 = texture2DLodEXT (_Inscatter, tmpvar_157.xy, 0.0);
        highp vec4 tmpvar_159;
        tmpvar_159.zw = vec2(0.0, 0.0);
        tmpvar_159.x = (((tmpvar_152 + tmpvar_150) + 1.0) / RES_NU);
        tmpvar_159.y = ((uMu_139 / RES_R) + tmpvar_154);
        lowp vec4 tmpvar_160;
        tmpvar_160 = texture2DLodEXT (_Inscatter, tmpvar_159.xy, 0.0);
        highp vec4 tmpvar_161;
        tmpvar_161.zw = vec2(0.0, 0.0);
        tmpvar_161.x = ((tmpvar_152 + tmpvar_150) / RES_NU);
        tmpvar_161.y = ((uMu_139 / RES_R) + tmpvar_155);
        lowp vec4 tmpvar_162;
        tmpvar_162 = texture2DLodEXT (_Inscatter, tmpvar_161.xy, 0.0);
        highp vec4 tmpvar_163;
        tmpvar_163.zw = vec2(0.0, 0.0);
        tmpvar_163.x = (((tmpvar_152 + tmpvar_150) + 1.0) / RES_NU);
        tmpvar_163.y = ((uMu_139 / RES_R) + tmpvar_155);
        lowp vec4 tmpvar_164;
        tmpvar_164 = texture2DLodEXT (_Inscatter, tmpvar_163.xy, 0.0);
        inScatterA_108 = max ((inScatter0_109 - (((((tmpvar_158 * (1.0 - tmpvar_153)) + (tmpvar_160 * tmpvar_153)) * (1.0 - tmpvar_156)) + (((tmpvar_162 * (1.0 - tmpvar_153)) + (tmpvar_164 * tmpvar_153)) * tmpvar_156)) * extinction_60.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
        highp float tmpvar_165;
        tmpvar_165 = (tmpvar_106 + 0.004);
        mu_61 = tmpvar_165;
        highp float tmpvar_166;
        tmpvar_166 = sqrt((((r_63 * r_63) + (d_64 * d_64)) + (((2.0 * r_63) * d_64) * tmpvar_165)));
        r1_79 = tmpvar_166;
        mu1_78 = (((r_63 * tmpvar_165) + d_64) / tmpvar_166);
        highp float uMu_167;
        highp float uR_168;
        highp float tmpvar_169;
        tmpvar_169 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_170;
        tmpvar_170 = sqrt(((r_63 * r_63) - (Rg * Rg)));
        highp float tmpvar_171;
        tmpvar_171 = (r_63 * tmpvar_165);
        highp float tmpvar_172;
        tmpvar_172 = (((tmpvar_171 * tmpvar_171) - (r_63 * r_63)) + (Rg * Rg));
        highp vec4 tmpvar_173;
        if (((tmpvar_171 < 0.0) && (tmpvar_172 > 0.0))) {
          highp vec4 tmpvar_174;
          tmpvar_174.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_174.w = (0.5 - (0.5 / RES_MU));
          tmpvar_173 = tmpvar_174;
        } else {
          highp vec4 tmpvar_175;
          tmpvar_175.x = -1.0;
          tmpvar_175.y = (tmpvar_169 * tmpvar_169);
          tmpvar_175.z = tmpvar_169;
          tmpvar_175.w = (0.5 + (0.5 / RES_MU));
          tmpvar_173 = tmpvar_175;
        };
        uR_168 = ((0.5 / RES_R) + ((tmpvar_170 / tmpvar_169) * (1.0 - (1.0/(RES_R)))));
        uMu_167 = (tmpvar_173.w + ((((tmpvar_171 * tmpvar_173.x) + sqrt((tmpvar_172 + tmpvar_173.y))) / (tmpvar_170 + tmpvar_173.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_176;
        y_over_x_176 = (max (tmpvar_82, -0.1975) * 5.34962);
        highp float x_177;
        x_177 = (y_over_x_176 * inversesqrt(((y_over_x_176 * y_over_x_176) + 1.0)));
        highp float tmpvar_178;
        tmpvar_178 = ((0.5 / RES_MU_S) + (((((sign(x_177) * (1.5708 - (sqrt((1.0 - abs(x_177))) * (1.5708 + (abs(x_177) * (-0.214602 + (abs(x_177) * (0.0865667 + (abs(x_177) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_179;
        tmpvar_179 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_180;
        tmpvar_180 = floor(tmpvar_179);
        highp float tmpvar_181;
        tmpvar_181 = (tmpvar_179 - tmpvar_180);
        highp float tmpvar_182;
        tmpvar_182 = (floor(((uR_168 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_183;
        tmpvar_183 = (floor((uR_168 * RES_R)) / RES_R);
        highp float tmpvar_184;
        tmpvar_184 = fract((uR_168 * RES_R));
        highp vec4 tmpvar_185;
        tmpvar_185.zw = vec2(0.0, 0.0);
        tmpvar_185.x = ((tmpvar_180 + tmpvar_178) / RES_NU);
        tmpvar_185.y = ((uMu_167 / RES_R) + tmpvar_182);
        lowp vec4 tmpvar_186;
        tmpvar_186 = texture2DLodEXT (_Inscatter, tmpvar_185.xy, 0.0);
        highp vec4 tmpvar_187;
        tmpvar_187.zw = vec2(0.0, 0.0);
        tmpvar_187.x = (((tmpvar_180 + tmpvar_178) + 1.0) / RES_NU);
        tmpvar_187.y = ((uMu_167 / RES_R) + tmpvar_182);
        lowp vec4 tmpvar_188;
        tmpvar_188 = texture2DLodEXT (_Inscatter, tmpvar_187.xy, 0.0);
        highp vec4 tmpvar_189;
        tmpvar_189.zw = vec2(0.0, 0.0);
        tmpvar_189.x = ((tmpvar_180 + tmpvar_178) / RES_NU);
        tmpvar_189.y = ((uMu_167 / RES_R) + tmpvar_183);
        lowp vec4 tmpvar_190;
        tmpvar_190 = texture2DLodEXT (_Inscatter, tmpvar_189.xy, 0.0);
        highp vec4 tmpvar_191;
        tmpvar_191.zw = vec2(0.0, 0.0);
        tmpvar_191.x = (((tmpvar_180 + tmpvar_178) + 1.0) / RES_NU);
        tmpvar_191.y = ((uMu_167 / RES_R) + tmpvar_183);
        lowp vec4 tmpvar_192;
        tmpvar_192 = texture2DLodEXT (_Inscatter, tmpvar_191.xy, 0.0);
        inScatter0_109 = ((((tmpvar_186 * (1.0 - tmpvar_181)) + (tmpvar_188 * tmpvar_181)) * (1.0 - tmpvar_184)) + (((tmpvar_190 * (1.0 - tmpvar_181)) + (tmpvar_192 * tmpvar_181)) * tmpvar_184));
        highp float uMu_193;
        highp float uR_194;
        highp float tmpvar_195;
        tmpvar_195 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_196;
        tmpvar_196 = sqrt(((tmpvar_166 * tmpvar_166) - (Rg * Rg)));
        highp float tmpvar_197;
        tmpvar_197 = (tmpvar_166 * mu1_78);
        highp float tmpvar_198;
        tmpvar_198 = (((tmpvar_197 * tmpvar_197) - (tmpvar_166 * tmpvar_166)) + (Rg * Rg));
        highp vec4 tmpvar_199;
        if (((tmpvar_197 < 0.0) && (tmpvar_198 > 0.0))) {
          highp vec4 tmpvar_200;
          tmpvar_200.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_200.w = (0.5 - (0.5 / RES_MU));
          tmpvar_199 = tmpvar_200;
        } else {
          highp vec4 tmpvar_201;
          tmpvar_201.x = -1.0;
          tmpvar_201.y = (tmpvar_195 * tmpvar_195);
          tmpvar_201.z = tmpvar_195;
          tmpvar_201.w = (0.5 + (0.5 / RES_MU));
          tmpvar_199 = tmpvar_201;
        };
        uR_194 = ((0.5 / RES_R) + ((tmpvar_196 / tmpvar_195) * (1.0 - (1.0/(RES_R)))));
        uMu_193 = (tmpvar_199.w + ((((tmpvar_197 * tmpvar_199.x) + sqrt((tmpvar_198 + tmpvar_199.y))) / (tmpvar_196 + tmpvar_199.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_202;
        y_over_x_202 = (max (muS1_77, -0.1975) * 5.34962);
        highp float x_203;
        x_203 = (y_over_x_202 * inversesqrt(((y_over_x_202 * y_over_x_202) + 1.0)));
        highp float tmpvar_204;
        tmpvar_204 = ((0.5 / RES_MU_S) + (((((sign(x_203) * (1.5708 - (sqrt((1.0 - abs(x_203))) * (1.5708 + (abs(x_203) * (-0.214602 + (abs(x_203) * (0.0865667 + (abs(x_203) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_205;
        tmpvar_205 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_206;
        tmpvar_206 = floor(tmpvar_205);
        highp float tmpvar_207;
        tmpvar_207 = (tmpvar_205 - tmpvar_206);
        highp float tmpvar_208;
        tmpvar_208 = (floor(((uR_194 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_209;
        tmpvar_209 = (floor((uR_194 * RES_R)) / RES_R);
        highp float tmpvar_210;
        tmpvar_210 = fract((uR_194 * RES_R));
        highp vec4 tmpvar_211;
        tmpvar_211.zw = vec2(0.0, 0.0);
        tmpvar_211.x = ((tmpvar_206 + tmpvar_204) / RES_NU);
        tmpvar_211.y = ((uMu_193 / RES_R) + tmpvar_208);
        lowp vec4 tmpvar_212;
        tmpvar_212 = texture2DLodEXT (_Inscatter, tmpvar_211.xy, 0.0);
        highp vec4 tmpvar_213;
        tmpvar_213.zw = vec2(0.0, 0.0);
        tmpvar_213.x = (((tmpvar_206 + tmpvar_204) + 1.0) / RES_NU);
        tmpvar_213.y = ((uMu_193 / RES_R) + tmpvar_208);
        lowp vec4 tmpvar_214;
        tmpvar_214 = texture2DLodEXT (_Inscatter, tmpvar_213.xy, 0.0);
        highp vec4 tmpvar_215;
        tmpvar_215.zw = vec2(0.0, 0.0);
        tmpvar_215.x = ((tmpvar_206 + tmpvar_204) / RES_NU);
        tmpvar_215.y = ((uMu_193 / RES_R) + tmpvar_209);
        lowp vec4 tmpvar_216;
        tmpvar_216 = texture2DLodEXT (_Inscatter, tmpvar_215.xy, 0.0);
        highp vec4 tmpvar_217;
        tmpvar_217.zw = vec2(0.0, 0.0);
        tmpvar_217.x = (((tmpvar_206 + tmpvar_204) + 1.0) / RES_NU);
        tmpvar_217.y = ((uMu_193 / RES_R) + tmpvar_209);
        lowp vec4 tmpvar_218;
        tmpvar_218 = texture2DLodEXT (_Inscatter, tmpvar_217.xy, 0.0);
        inScatter_80 = mix (inScatterA_108, max ((inScatter0_109 - (((((tmpvar_212 * (1.0 - tmpvar_207)) + (tmpvar_214 * tmpvar_207)) * (1.0 - tmpvar_210)) + (((tmpvar_216 * (1.0 - tmpvar_207)) + (tmpvar_218 * tmpvar_207)) * tmpvar_210)) * extinction_60.xyzx)), vec4(0.0, 0.0, 0.0, 0.0)), vec4(a_110));
      } else {
        highp vec4 inScatter0_1_219;
        highp float uMu_220;
        highp float uR_221;
        highp float tmpvar_222;
        tmpvar_222 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_223;
        tmpvar_223 = sqrt(((r_63 * r_63) - (Rg * Rg)));
        highp float tmpvar_224;
        tmpvar_224 = (r_63 * mu_61);
        highp float tmpvar_225;
        tmpvar_225 = (((tmpvar_224 * tmpvar_224) - (r_63 * r_63)) + (Rg * Rg));
        highp vec4 tmpvar_226;
        if (((tmpvar_224 < 0.0) && (tmpvar_225 > 0.0))) {
          highp vec4 tmpvar_227;
          tmpvar_227.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_227.w = (0.5 - (0.5 / RES_MU));
          tmpvar_226 = tmpvar_227;
        } else {
          highp vec4 tmpvar_228;
          tmpvar_228.x = -1.0;
          tmpvar_228.y = (tmpvar_222 * tmpvar_222);
          tmpvar_228.z = tmpvar_222;
          tmpvar_228.w = (0.5 + (0.5 / RES_MU));
          tmpvar_226 = tmpvar_228;
        };
        uR_221 = ((0.5 / RES_R) + ((tmpvar_223 / tmpvar_222) * (1.0 - (1.0/(RES_R)))));
        uMu_220 = (tmpvar_226.w + ((((tmpvar_224 * tmpvar_226.x) + sqrt((tmpvar_225 + tmpvar_226.y))) / (tmpvar_223 + tmpvar_226.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_229;
        y_over_x_229 = (max (tmpvar_82, -0.1975) * 5.34962);
        highp float x_230;
        x_230 = (y_over_x_229 * inversesqrt(((y_over_x_229 * y_over_x_229) + 1.0)));
        highp float tmpvar_231;
        tmpvar_231 = ((0.5 / RES_MU_S) + (((((sign(x_230) * (1.5708 - (sqrt((1.0 - abs(x_230))) * (1.5708 + (abs(x_230) * (-0.214602 + (abs(x_230) * (0.0865667 + (abs(x_230) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_232;
        tmpvar_232 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_233;
        tmpvar_233 = floor(tmpvar_232);
        highp float tmpvar_234;
        tmpvar_234 = (tmpvar_232 - tmpvar_233);
        highp float tmpvar_235;
        tmpvar_235 = (floor(((uR_221 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_236;
        tmpvar_236 = (floor((uR_221 * RES_R)) / RES_R);
        highp float tmpvar_237;
        tmpvar_237 = fract((uR_221 * RES_R));
        highp vec4 tmpvar_238;
        tmpvar_238.zw = vec2(0.0, 0.0);
        tmpvar_238.x = ((tmpvar_233 + tmpvar_231) / RES_NU);
        tmpvar_238.y = ((uMu_220 / RES_R) + tmpvar_235);
        lowp vec4 tmpvar_239;
        tmpvar_239 = texture2DLodEXT (_Inscatter, tmpvar_238.xy, 0.0);
        highp vec4 tmpvar_240;
        tmpvar_240.zw = vec2(0.0, 0.0);
        tmpvar_240.x = (((tmpvar_233 + tmpvar_231) + 1.0) / RES_NU);
        tmpvar_240.y = ((uMu_220 / RES_R) + tmpvar_235);
        lowp vec4 tmpvar_241;
        tmpvar_241 = texture2DLodEXT (_Inscatter, tmpvar_240.xy, 0.0);
        highp vec4 tmpvar_242;
        tmpvar_242.zw = vec2(0.0, 0.0);
        tmpvar_242.x = ((tmpvar_233 + tmpvar_231) / RES_NU);
        tmpvar_242.y = ((uMu_220 / RES_R) + tmpvar_236);
        lowp vec4 tmpvar_243;
        tmpvar_243 = texture2DLodEXT (_Inscatter, tmpvar_242.xy, 0.0);
        highp vec4 tmpvar_244;
        tmpvar_244.zw = vec2(0.0, 0.0);
        tmpvar_244.x = (((tmpvar_233 + tmpvar_231) + 1.0) / RES_NU);
        tmpvar_244.y = ((uMu_220 / RES_R) + tmpvar_236);
        lowp vec4 tmpvar_245;
        tmpvar_245 = texture2DLodEXT (_Inscatter, tmpvar_244.xy, 0.0);
        inScatter0_1_219 = ((((tmpvar_239 * (1.0 - tmpvar_234)) + (tmpvar_241 * tmpvar_234)) * (1.0 - tmpvar_237)) + (((tmpvar_243 * (1.0 - tmpvar_234)) + (tmpvar_245 * tmpvar_234)) * tmpvar_237));
        highp float uMu_246;
        highp float uR_247;
        highp float tmpvar_248;
        tmpvar_248 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_249;
        tmpvar_249 = sqrt(((r1_79 * r1_79) - (Rg * Rg)));
        highp float tmpvar_250;
        tmpvar_250 = (r1_79 * mu1_78);
        highp float tmpvar_251;
        tmpvar_251 = (((tmpvar_250 * tmpvar_250) - (r1_79 * r1_79)) + (Rg * Rg));
        highp vec4 tmpvar_252;
        if (((tmpvar_250 < 0.0) && (tmpvar_251 > 0.0))) {
          highp vec4 tmpvar_253;
          tmpvar_253.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_253.w = (0.5 - (0.5 / RES_MU));
          tmpvar_252 = tmpvar_253;
        } else {
          highp vec4 tmpvar_254;
          tmpvar_254.x = -1.0;
          tmpvar_254.y = (tmpvar_248 * tmpvar_248);
          tmpvar_254.z = tmpvar_248;
          tmpvar_254.w = (0.5 + (0.5 / RES_MU));
          tmpvar_252 = tmpvar_254;
        };
        uR_247 = ((0.5 / RES_R) + ((tmpvar_249 / tmpvar_248) * (1.0 - (1.0/(RES_R)))));
        uMu_246 = (tmpvar_252.w + ((((tmpvar_250 * tmpvar_252.x) + sqrt((tmpvar_251 + tmpvar_252.y))) / (tmpvar_249 + tmpvar_252.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_255;
        y_over_x_255 = (max (muS1_77, -0.1975) * 5.34962);
        highp float x_256;
        x_256 = (y_over_x_255 * inversesqrt(((y_over_x_255 * y_over_x_255) + 1.0)));
        highp float tmpvar_257;
        tmpvar_257 = ((0.5 / RES_MU_S) + (((((sign(x_256) * (1.5708 - (sqrt((1.0 - abs(x_256))) * (1.5708 + (abs(x_256) * (-0.214602 + (abs(x_256) * (0.0865667 + (abs(x_256) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_258;
        tmpvar_258 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_259;
        tmpvar_259 = floor(tmpvar_258);
        highp float tmpvar_260;
        tmpvar_260 = (tmpvar_258 - tmpvar_259);
        highp float tmpvar_261;
        tmpvar_261 = (floor(((uR_247 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_262;
        tmpvar_262 = (floor((uR_247 * RES_R)) / RES_R);
        highp float tmpvar_263;
        tmpvar_263 = fract((uR_247 * RES_R));
        highp vec4 tmpvar_264;
        tmpvar_264.zw = vec2(0.0, 0.0);
        tmpvar_264.x = ((tmpvar_259 + tmpvar_257) / RES_NU);
        tmpvar_264.y = ((uMu_246 / RES_R) + tmpvar_261);
        lowp vec4 tmpvar_265;
        tmpvar_265 = texture2DLodEXT (_Inscatter, tmpvar_264.xy, 0.0);
        highp vec4 tmpvar_266;
        tmpvar_266.zw = vec2(0.0, 0.0);
        tmpvar_266.x = (((tmpvar_259 + tmpvar_257) + 1.0) / RES_NU);
        tmpvar_266.y = ((uMu_246 / RES_R) + tmpvar_261);
        lowp vec4 tmpvar_267;
        tmpvar_267 = texture2DLodEXT (_Inscatter, tmpvar_266.xy, 0.0);
        highp vec4 tmpvar_268;
        tmpvar_268.zw = vec2(0.0, 0.0);
        tmpvar_268.x = ((tmpvar_259 + tmpvar_257) / RES_NU);
        tmpvar_268.y = ((uMu_246 / RES_R) + tmpvar_262);
        lowp vec4 tmpvar_269;
        tmpvar_269 = texture2DLodEXT (_Inscatter, tmpvar_268.xy, 0.0);
        highp vec4 tmpvar_270;
        tmpvar_270.zw = vec2(0.0, 0.0);
        tmpvar_270.x = (((tmpvar_259 + tmpvar_257) + 1.0) / RES_NU);
        tmpvar_270.y = ((uMu_246 / RES_R) + tmpvar_262);
        lowp vec4 tmpvar_271;
        tmpvar_271 = texture2DLodEXT (_Inscatter, tmpvar_270.xy, 0.0);
        inScatter_80 = max ((inScatter0_1_219 - (((((tmpvar_265 * (1.0 - tmpvar_260)) + (tmpvar_267 * tmpvar_260)) * (1.0 - tmpvar_263)) + (((tmpvar_269 * (1.0 - tmpvar_260)) + (tmpvar_271 * tmpvar_260)) * tmpvar_263)) * extinction_60.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      };
      highp float t_272;
      t_272 = max (min ((tmpvar_82 / 0.02), 1.0), 0.0);
      inScatter_80.w = (inScatter_80.w * (t_272 * (t_272 * (3.0 - (2.0 * t_272)))));
      result_66 = ((inScatter_80.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_81 * tmpvar_81)))) + ((((inScatter_80.xyz * inScatter_80.w) / max (inScatter_80.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_81)), -1.5)) * (1.0 + (tmpvar_81 * tmpvar_81))) / (2.0 + (mieG * mieG)))));
    };
    tmpvar_57 = (result_66 * SUN_INTENSITY);
    visib_2 = 1.0;
    highp float tmpvar_273;
    highp vec3 arg0_274;
    arg0_274 = (worldPos_4 - _camPos);
    tmpvar_273 = sqrt(dot (arg0_274, arg0_274));
    dpth_6 = tmpvar_273;
    if ((tmpvar_273 <= _global_depth)) {
      visib_2 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_273) / _global_depth))));
    };
    if (((tmpvar_18 && tmpvar_22) && (fakeOcean == 1.0))) {
      highp vec3 L_275;
      L_275 = (oceanColor_3 * extinction_60);
      highp vec3 tmpvar_276;
      tmpvar_276 = (L_275 * _Exposure);
      L_275 = tmpvar_276;
      highp float tmpvar_277;
      if ((tmpvar_276.x < 1.413)) {
        tmpvar_277 = pow ((tmpvar_276.x * 0.38317), 0.454545);
      } else {
        tmpvar_277 = (1.0 - exp(-(tmpvar_276.x)));
      };
      L_275.x = tmpvar_277;
      highp float tmpvar_278;
      if ((tmpvar_276.y < 1.413)) {
        tmpvar_278 = pow ((tmpvar_276.y * 0.38317), 0.454545);
      } else {
        tmpvar_278 = (1.0 - exp(-(tmpvar_276.y)));
      };
      L_275.y = tmpvar_278;
      highp float tmpvar_279;
      if ((tmpvar_276.z < 1.413)) {
        tmpvar_279 = pow ((tmpvar_276.z * 0.38317), 0.454545);
      } else {
        tmpvar_279 = (1.0 - exp(-(tmpvar_276.z)));
      };
      L_275.z = tmpvar_279;
      highp vec3 L_280;
      highp vec3 tmpvar_281;
      tmpvar_281 = (tmpvar_57 * _Exposure);
      L_280 = tmpvar_281;
      highp float tmpvar_282;
      if ((tmpvar_281.x < 1.413)) {
        tmpvar_282 = pow ((tmpvar_281.x * 0.38317), 0.454545);
      } else {
        tmpvar_282 = (1.0 - exp(-(tmpvar_281.x)));
      };
      L_280.x = tmpvar_282;
      highp float tmpvar_283;
      if ((tmpvar_281.y < 1.413)) {
        tmpvar_283 = pow ((tmpvar_281.y * 0.38317), 0.454545);
      } else {
        tmpvar_283 = (1.0 - exp(-(tmpvar_281.y)));
      };
      L_280.y = tmpvar_283;
      highp float tmpvar_284;
      if ((tmpvar_281.z < 1.413)) {
        tmpvar_284 = pow ((tmpvar_281.z * 0.38317), 0.454545);
      } else {
        tmpvar_284 = (1.0 - exp(-(tmpvar_281.z)));
      };
      L_280.z = tmpvar_284;
      highp vec4 tmpvar_285;
      tmpvar_285.xyz = mix (L_275, L_280, vec3((_global_alpha * visib_2)));
      tmpvar_285.w = _fade;
      tmpvar_1 = tmpvar_285;
    } else {
      highp vec3 L_286;
      highp vec3 tmpvar_287;
      tmpvar_287 = (tmpvar_57 * _Exposure);
      L_286 = tmpvar_287;
      highp float tmpvar_288;
      if ((tmpvar_287.x < 1.413)) {
        tmpvar_288 = pow ((tmpvar_287.x * 0.38317), 0.454545);
      } else {
        tmpvar_288 = (1.0 - exp(-(tmpvar_287.x)));
      };
      L_286.x = tmpvar_288;
      highp float tmpvar_289;
      if ((tmpvar_287.y < 1.413)) {
        tmpvar_289 = pow ((tmpvar_287.y * 0.38317), 0.454545);
      } else {
        tmpvar_289 = (1.0 - exp(-(tmpvar_287.y)));
      };
      L_286.y = tmpvar_289;
      highp float tmpvar_290;
      if ((tmpvar_287.z < 1.413)) {
        tmpvar_290 = pow ((tmpvar_287.z * 0.38317), 0.454545);
      } else {
        tmpvar_290 = (1.0 - exp(-(tmpvar_287.z)));
      };
      L_286.z = tmpvar_290;
      highp vec4 tmpvar_291;
      tmpvar_291.xyz = L_286;
      tmpvar_291.w = ((_global_alpha * visib_2) * _fade);
      tmpvar_1 = tmpvar_291;
    };
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform highp vec4 _ZBufferParams;
uniform sampler2D _Transmittance;
uniform sampler2D _Inscatter;
uniform sampler2D _Irradiance;
uniform highp float M_PI;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp mat4 _ViewProjInv;
uniform highp float _viewdirOffset;
uniform highp float _experimentalAtmoScale;
uniform highp float _global_alpha;
uniform highp float _Exposure;
uniform highp float _global_depth;
uniform highp float _Ocean_Sigma;
uniform highp float fakeOcean;
uniform highp float _fade;
uniform highp vec3 _Ocean_Color;
uniform highp vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform highp float _openglThreshold;
uniform highp float _edgeThreshold;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp float visib_2;
  highp vec3 oceanColor_3;
  highp vec3 worldPos_4;
  highp float depth_5;
  highp float dpth_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_customDepthTexture, xlv_TEXCOORD2);
  highp float z_8;
  z_8 = tmpvar_7.x;
  dpth_6 = (1.0/(((_ZBufferParams.x * z_8) + _ZBufferParams.y)));
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_10.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_10.z = depth_5;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_ViewProjInv * tmpvar_10);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 / tmpvar_11.w).xyz;
  worldPos_4 = tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 - _camPos);
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = (2.0 * dot (tmpvar_14, _camPos));
  highp float tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_17 < 0.0)) {
    tmpvar_13 = -1.0;
  } else {
    tmpvar_13 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
  };
  bool tmpvar_18;
  tmpvar_18 = (tmpvar_13 > 0.0);
  if (((dpth_6 >= _edgeThreshold) && !(tmpvar_18))) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_19;
    tmpvar_19 = (_camPos + (tmpvar_13 * (tmpvar_12 - _camPos)));
    highp vec3 arg0_20;
    arg0_20 = (tmpvar_19 - _camPos);
    highp vec3 arg0_21;
    arg0_21 = (tmpvar_12 - _camPos);
    bool tmpvar_22;
    tmpvar_22 = (sqrt(dot (arg0_20, arg0_20)) < sqrt(dot (arg0_21, arg0_21)));
    oceanColor_3 = vec3(1.0, 1.0, 1.0);
    if ((tmpvar_18 && tmpvar_22)) {
      worldPos_4 = tmpvar_19;
      if ((fakeOcean == 1.0)) {
        highp vec3 tmpvar_23;
        tmpvar_23 = normalize(tmpvar_19);
        highp vec3 tmpvar_24;
        tmpvar_24 = (tmpvar_23 * max (sqrt(dot (tmpvar_19, tmpvar_19)), (Rg + 10.0)));
        highp vec3 tmpvar_25;
        tmpvar_25 = normalize((tmpvar_24 - _camPos));
        highp vec3 worldP_26;
        worldP_26 = tmpvar_24;
        highp float r_27;
        highp float tmpvar_28;
        tmpvar_28 = sqrt(dot (tmpvar_24, tmpvar_24));
        r_27 = tmpvar_28;
        if ((tmpvar_28 < (0.9 * Rg))) {
          worldP_26.z = (tmpvar_24.z + Rg);
          r_27 = sqrt(dot (worldP_26, worldP_26));
        };
        highp vec3 tmpvar_29;
        tmpvar_29 = (worldP_26 / r_27);
        highp float tmpvar_30;
        tmpvar_30 = dot (tmpvar_29, SUN_DIR);
        highp float tmpvar_31;
        tmpvar_31 = sqrt((1.0 - ((Rg / r_27) * (Rg / r_27))));
        highp vec3 tmpvar_32;
        if ((tmpvar_30 < -(tmpvar_31))) {
          tmpvar_32 = vec3(0.0, 0.0, 0.0);
        } else {
          highp vec3 tmpvar_33;
          highp float y_over_x_34;
          y_over_x_34 = (((tmpvar_30 + 0.15) / 1.15) * 14.1014);
          highp float x_35;
          x_35 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
          highp vec4 tmpvar_36;
          tmpvar_36.zw = vec2(0.0, 0.0);
          tmpvar_36.x = ((sign(x_35) * (1.5708 - (sqrt((1.0 - abs(x_35))) * (1.5708 + (abs(x_35) * (-0.214602 + (abs(x_35) * (0.0865667 + (abs(x_35) * -0.0310296))))))))) / 1.5);
          tmpvar_36.y = sqrt(((r_27 - Rg) / (Rt - Rg)));
          lowp vec4 tmpvar_37;
          tmpvar_37 = texture2DLodEXT (_Transmittance, tmpvar_36.xy, 0.0);
          tmpvar_33 = tmpvar_37.xyz;
          tmpvar_32 = tmpvar_33;
        };
        highp vec3 tmpvar_38;
        tmpvar_38 = (tmpvar_32 * SUN_INTENSITY);
        highp vec3 tmpvar_39;
        highp vec2 tmpvar_40;
        tmpvar_40.x = ((tmpvar_30 + 0.2) / 1.2);
        tmpvar_40.y = ((r_27 - Rg) / (Rt - Rg));
        lowp vec4 tmpvar_41;
        tmpvar_41 = texture2DLodEXT (_Irradiance, tmpvar_40, 0.0);
        tmpvar_39 = tmpvar_41.xyz;
        highp vec3 tmpvar_42;
        tmpvar_42 = (((2.0 * tmpvar_39) * SUN_INTENSITY) * ((1.0 + tmpvar_29.z) * 0.5));
        highp vec3 V_43;
        V_43 = -(tmpvar_25);
        highp vec3 seaColor_44;
        seaColor_44 = (_Ocean_Color * 10.0);
        highp float tmpvar_45;
        tmpvar_45 = sqrt(_Ocean_Sigma);
        highp float tmpvar_46;
        tmpvar_46 = (pow ((1.0 - dot (V_43, tmpvar_23)), (5.0 * exp((-2.69 * tmpvar_45)))) / (1.0 + (22.7 * pow (tmpvar_45, 1.5))));
        highp vec3 tmpvar_47;
        tmpvar_47 = normalize((SUN_DIR + V_43));
        highp float tmpvar_48;
        tmpvar_48 = dot (tmpvar_47, tmpvar_23);
        highp float tmpvar_49;
        tmpvar_49 = (exp(((-2.0 * ((1.0 - (tmpvar_48 * tmpvar_48)) / _Ocean_Sigma)) / (1.0 + tmpvar_48))) / ((4.0 * M_PI) * _Ocean_Sigma));
        highp float tmpvar_50;
        tmpvar_50 = (1.0 - dot (V_43, tmpvar_47));
        highp float tmpvar_51;
        tmpvar_51 = (tmpvar_50 * tmpvar_50);
        highp float tmpvar_52;
        tmpvar_52 = (0.02 + (((0.98 * tmpvar_51) * tmpvar_51) * tmpvar_50));
        highp float tmpvar_53;
        tmpvar_53 = max (dot (SUN_DIR, tmpvar_23), 0.01);
        highp float tmpvar_54;
        tmpvar_54 = max (dot (V_43, tmpvar_23), 0.01);
        highp float tmpvar_55;
        if ((tmpvar_53 <= 0.0)) {
          tmpvar_55 = 0.0;
        } else {
          tmpvar_55 = max (((tmpvar_52 * tmpvar_49) * sqrt(abs((tmpvar_53 / tmpvar_54)))), 0.0);
        };
        oceanColor_3 = (((tmpvar_55 * tmpvar_38) + ((tmpvar_42 * tmpvar_46) / M_PI)) + ((((1.0 - tmpvar_46) * seaColor_44) * tmpvar_42) / M_PI));
      };
    };
    highp float tmpvar_56;
    tmpvar_56 = sqrt(dot (worldPos_4, worldPos_4));
    if ((tmpvar_56 < (Rg + _openglThreshold))) {
      worldPos_4 = ((Rg + _openglThreshold) * normalize(worldPos_4));
    };
    highp vec3 tmpvar_57;
    highp vec3 camera_58;
    camera_58 = _camPos;
    highp vec3 _point_59;
    _point_59 = worldPos_4;
    highp vec3 extinction_60;
    highp float mu_61;
    highp float rMu_62;
    highp float r_63;
    highp float d_64;
    highp vec3 viewdir_65;
    highp vec3 result_66;
    result_66 = vec3(0.0, 0.0, 0.0);
    extinction_60 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_67;
    tmpvar_67 = (worldPos_4 - _camPos);
    highp float tmpvar_68;
    tmpvar_68 = sqrt(dot (tmpvar_67, tmpvar_67));
    d_64 = tmpvar_68;
    highp vec3 tmpvar_69;
    tmpvar_69 = (tmpvar_67 / tmpvar_68);
    viewdir_65.yz = tmpvar_69.yz;
    highp float tmpvar_70;
    tmpvar_70 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    viewdir_65.x = (tmpvar_69.x + _viewdirOffset);
    highp vec3 tmpvar_71;
    tmpvar_71 = normalize(viewdir_65);
    viewdir_65 = tmpvar_71;
    highp float tmpvar_72;
    tmpvar_72 = sqrt(dot (_camPos, _camPos));
    r_63 = tmpvar_72;
    if ((tmpvar_72 < (0.9 * Rg))) {
      camera_58.y = (_camPos.y + Rg);
      _point_59.y = (worldPos_4.y + Rg);
      r_63 = sqrt(dot (camera_58, camera_58));
    };
    highp float tmpvar_73;
    tmpvar_73 = dot (camera_58, tmpvar_71);
    rMu_62 = tmpvar_73;
    mu_61 = (tmpvar_73 / r_63);
    highp vec3 tmpvar_74;
    tmpvar_74 = (_point_59 - (tmpvar_71 * clamp (1.0, 0.0, tmpvar_68)));
    _point_59 = tmpvar_74;
    highp float tmpvar_75;
    tmpvar_75 = max ((-(tmpvar_73) - sqrt((((tmpvar_73 * tmpvar_73) - (r_63 * r_63)) + (tmpvar_70 * tmpvar_70)))), 0.0);
    if (((tmpvar_75 > 0.0) && (tmpvar_75 < tmpvar_68))) {
      camera_58 = (camera_58 + (tmpvar_75 * tmpvar_71));
      highp float tmpvar_76;
      tmpvar_76 = (tmpvar_73 + tmpvar_75);
      rMu_62 = tmpvar_76;
      mu_61 = (tmpvar_76 / tmpvar_70);
      r_63 = tmpvar_70;
      d_64 = (tmpvar_68 - tmpvar_75);
    };
    if ((r_63 <= tmpvar_70)) {
      highp float muS1_77;
      highp float mu1_78;
      highp float r1_79;
      highp vec4 inScatter_80;
      highp float tmpvar_81;
      tmpvar_81 = dot (tmpvar_71, SUN_DIR);
      highp float tmpvar_82;
      tmpvar_82 = (dot (camera_58, SUN_DIR) / r_63);
      if ((r_63 < (Rg + 600.0))) {
        highp float tmpvar_83;
        tmpvar_83 = ((Rg + 600.0) / r_63);
        r_63 = (r_63 * tmpvar_83);
        rMu_62 = (rMu_62 * tmpvar_83);
        _point_59 = (tmpvar_74 * tmpvar_83);
      };
      highp float tmpvar_84;
      tmpvar_84 = sqrt(dot (_point_59, _point_59));
      r1_79 = tmpvar_84;
      highp float tmpvar_85;
      tmpvar_85 = (dot (_point_59, tmpvar_71) / tmpvar_84);
      mu1_78 = tmpvar_85;
      muS1_77 = (dot (_point_59, SUN_DIR) / tmpvar_84);
      if ((mu_61 > 0.0)) {
        highp vec3 tmpvar_86;
        highp float y_over_x_87;
        y_over_x_87 = (((mu_61 + 0.15) / 1.15) * 14.1014);
        highp float x_88;
        x_88 = (y_over_x_87 * inversesqrt(((y_over_x_87 * y_over_x_87) + 1.0)));
        highp vec4 tmpvar_89;
        tmpvar_89.zw = vec2(0.0, 0.0);
        tmpvar_89.x = ((sign(x_88) * (1.5708 - (sqrt((1.0 - abs(x_88))) * (1.5708 + (abs(x_88) * (-0.214602 + (abs(x_88) * (0.0865667 + (abs(x_88) * -0.0310296))))))))) / 1.5);
        tmpvar_89.y = sqrt(((r_63 - Rg) / (tmpvar_70 - Rg)));
        lowp vec4 tmpvar_90;
        tmpvar_90 = texture2DLodEXT (_Transmittance, tmpvar_89.xy, 0.0);
        tmpvar_86 = tmpvar_90.xyz;
        highp vec3 tmpvar_91;
        highp float y_over_x_92;
        y_over_x_92 = (((tmpvar_85 + 0.15) / 1.15) * 14.1014);
        highp float x_93;
        x_93 = (y_over_x_92 * inversesqrt(((y_over_x_92 * y_over_x_92) + 1.0)));
        highp vec4 tmpvar_94;
        tmpvar_94.zw = vec2(0.0, 0.0);
        tmpvar_94.x = ((sign(x_93) * (1.5708 - (sqrt((1.0 - abs(x_93))) * (1.5708 + (abs(x_93) * (-0.214602 + (abs(x_93) * (0.0865667 + (abs(x_93) * -0.0310296))))))))) / 1.5);
        tmpvar_94.y = sqrt(((tmpvar_84 - Rg) / (tmpvar_70 - Rg)));
        lowp vec4 tmpvar_95;
        tmpvar_95 = texture2DLodEXT (_Transmittance, tmpvar_94.xy, 0.0);
        tmpvar_91 = tmpvar_95.xyz;
        extinction_60 = min ((tmpvar_86 / tmpvar_91), vec3(1.0, 1.0, 1.0));
      } else {
        highp vec3 tmpvar_96;
        highp float y_over_x_97;
        y_over_x_97 = (((-(tmpvar_85) + 0.15) / 1.15) * 14.1014);
        highp float x_98;
        x_98 = (y_over_x_97 * inversesqrt(((y_over_x_97 * y_over_x_97) + 1.0)));
        highp vec4 tmpvar_99;
        tmpvar_99.zw = vec2(0.0, 0.0);
        tmpvar_99.x = ((sign(x_98) * (1.5708 - (sqrt((1.0 - abs(x_98))) * (1.5708 + (abs(x_98) * (-0.214602 + (abs(x_98) * (0.0865667 + (abs(x_98) * -0.0310296))))))))) / 1.5);
        tmpvar_99.y = sqrt(((tmpvar_84 - Rg) / (tmpvar_70 - Rg)));
        lowp vec4 tmpvar_100;
        tmpvar_100 = texture2DLodEXT (_Transmittance, tmpvar_99.xy, 0.0);
        tmpvar_96 = tmpvar_100.xyz;
        highp vec3 tmpvar_101;
        highp float y_over_x_102;
        y_over_x_102 = (((-(mu_61) + 0.15) / 1.15) * 14.1014);
        highp float x_103;
        x_103 = (y_over_x_102 * inversesqrt(((y_over_x_102 * y_over_x_102) + 1.0)));
        highp vec4 tmpvar_104;
        tmpvar_104.zw = vec2(0.0, 0.0);
        tmpvar_104.x = ((sign(x_103) * (1.5708 - (sqrt((1.0 - abs(x_103))) * (1.5708 + (abs(x_103) * (-0.214602 + (abs(x_103) * (0.0865667 + (abs(x_103) * -0.0310296))))))))) / 1.5);
        tmpvar_104.y = sqrt(((r_63 - Rg) / (tmpvar_70 - Rg)));
        lowp vec4 tmpvar_105;
        tmpvar_105 = texture2DLodEXT (_Transmittance, tmpvar_104.xy, 0.0);
        tmpvar_101 = tmpvar_105.xyz;
        extinction_60 = min ((tmpvar_96 / tmpvar_101), vec3(1.0, 1.0, 1.0));
      };
      highp float tmpvar_106;
      tmpvar_106 = -(sqrt((1.0 - ((Rg / r_63) * (Rg / r_63)))));
      highp float tmpvar_107;
      tmpvar_107 = abs((mu_61 - tmpvar_106));
      if ((tmpvar_107 < 0.004)) {
        highp vec4 inScatterA_108;
        highp vec4 inScatter0_109;
        highp float a_110;
        a_110 = (((mu_61 - tmpvar_106) + 0.004) / 0.008);
        highp float tmpvar_111;
        tmpvar_111 = (tmpvar_106 - 0.004);
        mu_61 = tmpvar_111;
        highp float tmpvar_112;
        tmpvar_112 = sqrt((((r_63 * r_63) + (d_64 * d_64)) + (((2.0 * r_63) * d_64) * tmpvar_111)));
        r1_79 = tmpvar_112;
        mu1_78 = (((r_63 * tmpvar_111) + d_64) / tmpvar_112);
        highp float uMu_113;
        highp float uR_114;
        highp float tmpvar_115;
        tmpvar_115 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_116;
        tmpvar_116 = sqrt(((r_63 * r_63) - (Rg * Rg)));
        highp float tmpvar_117;
        tmpvar_117 = (r_63 * tmpvar_111);
        highp float tmpvar_118;
        tmpvar_118 = (((tmpvar_117 * tmpvar_117) - (r_63 * r_63)) + (Rg * Rg));
        highp vec4 tmpvar_119;
        if (((tmpvar_117 < 0.0) && (tmpvar_118 > 0.0))) {
          highp vec4 tmpvar_120;
          tmpvar_120.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_120.w = (0.5 - (0.5 / RES_MU));
          tmpvar_119 = tmpvar_120;
        } else {
          highp vec4 tmpvar_121;
          tmpvar_121.x = -1.0;
          tmpvar_121.y = (tmpvar_115 * tmpvar_115);
          tmpvar_121.z = tmpvar_115;
          tmpvar_121.w = (0.5 + (0.5 / RES_MU));
          tmpvar_119 = tmpvar_121;
        };
        uR_114 = ((0.5 / RES_R) + ((tmpvar_116 / tmpvar_115) * (1.0 - (1.0/(RES_R)))));
        uMu_113 = (tmpvar_119.w + ((((tmpvar_117 * tmpvar_119.x) + sqrt((tmpvar_118 + tmpvar_119.y))) / (tmpvar_116 + tmpvar_119.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_122;
        y_over_x_122 = (max (tmpvar_82, -0.1975) * 5.34962);
        highp float x_123;
        x_123 = (y_over_x_122 * inversesqrt(((y_over_x_122 * y_over_x_122) + 1.0)));
        highp float tmpvar_124;
        tmpvar_124 = ((0.5 / RES_MU_S) + (((((sign(x_123) * (1.5708 - (sqrt((1.0 - abs(x_123))) * (1.5708 + (abs(x_123) * (-0.214602 + (abs(x_123) * (0.0865667 + (abs(x_123) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_125;
        tmpvar_125 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_126;
        tmpvar_126 = floor(tmpvar_125);
        highp float tmpvar_127;
        tmpvar_127 = (tmpvar_125 - tmpvar_126);
        highp float tmpvar_128;
        tmpvar_128 = (floor(((uR_114 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_129;
        tmpvar_129 = (floor((uR_114 * RES_R)) / RES_R);
        highp float tmpvar_130;
        tmpvar_130 = fract((uR_114 * RES_R));
        highp vec4 tmpvar_131;
        tmpvar_131.zw = vec2(0.0, 0.0);
        tmpvar_131.x = ((tmpvar_126 + tmpvar_124) / RES_NU);
        tmpvar_131.y = ((uMu_113 / RES_R) + tmpvar_128);
        lowp vec4 tmpvar_132;
        tmpvar_132 = texture2DLodEXT (_Inscatter, tmpvar_131.xy, 0.0);
        highp vec4 tmpvar_133;
        tmpvar_133.zw = vec2(0.0, 0.0);
        tmpvar_133.x = (((tmpvar_126 + tmpvar_124) + 1.0) / RES_NU);
        tmpvar_133.y = ((uMu_113 / RES_R) + tmpvar_128);
        lowp vec4 tmpvar_134;
        tmpvar_134 = texture2DLodEXT (_Inscatter, tmpvar_133.xy, 0.0);
        highp vec4 tmpvar_135;
        tmpvar_135.zw = vec2(0.0, 0.0);
        tmpvar_135.x = ((tmpvar_126 + tmpvar_124) / RES_NU);
        tmpvar_135.y = ((uMu_113 / RES_R) + tmpvar_129);
        lowp vec4 tmpvar_136;
        tmpvar_136 = texture2DLodEXT (_Inscatter, tmpvar_135.xy, 0.0);
        highp vec4 tmpvar_137;
        tmpvar_137.zw = vec2(0.0, 0.0);
        tmpvar_137.x = (((tmpvar_126 + tmpvar_124) + 1.0) / RES_NU);
        tmpvar_137.y = ((uMu_113 / RES_R) + tmpvar_129);
        lowp vec4 tmpvar_138;
        tmpvar_138 = texture2DLodEXT (_Inscatter, tmpvar_137.xy, 0.0);
        inScatter0_109 = ((((tmpvar_132 * (1.0 - tmpvar_127)) + (tmpvar_134 * tmpvar_127)) * (1.0 - tmpvar_130)) + (((tmpvar_136 * (1.0 - tmpvar_127)) + (tmpvar_138 * tmpvar_127)) * tmpvar_130));
        highp float uMu_139;
        highp float uR_140;
        highp float tmpvar_141;
        tmpvar_141 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_142;
        tmpvar_142 = sqrt(((tmpvar_112 * tmpvar_112) - (Rg * Rg)));
        highp float tmpvar_143;
        tmpvar_143 = (tmpvar_112 * mu1_78);
        highp float tmpvar_144;
        tmpvar_144 = (((tmpvar_143 * tmpvar_143) - (tmpvar_112 * tmpvar_112)) + (Rg * Rg));
        highp vec4 tmpvar_145;
        if (((tmpvar_143 < 0.0) && (tmpvar_144 > 0.0))) {
          highp vec4 tmpvar_146;
          tmpvar_146.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_146.w = (0.5 - (0.5 / RES_MU));
          tmpvar_145 = tmpvar_146;
        } else {
          highp vec4 tmpvar_147;
          tmpvar_147.x = -1.0;
          tmpvar_147.y = (tmpvar_141 * tmpvar_141);
          tmpvar_147.z = tmpvar_141;
          tmpvar_147.w = (0.5 + (0.5 / RES_MU));
          tmpvar_145 = tmpvar_147;
        };
        uR_140 = ((0.5 / RES_R) + ((tmpvar_142 / tmpvar_141) * (1.0 - (1.0/(RES_R)))));
        uMu_139 = (tmpvar_145.w + ((((tmpvar_143 * tmpvar_145.x) + sqrt((tmpvar_144 + tmpvar_145.y))) / (tmpvar_142 + tmpvar_145.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_148;
        y_over_x_148 = (max (muS1_77, -0.1975) * 5.34962);
        highp float x_149;
        x_149 = (y_over_x_148 * inversesqrt(((y_over_x_148 * y_over_x_148) + 1.0)));
        highp float tmpvar_150;
        tmpvar_150 = ((0.5 / RES_MU_S) + (((((sign(x_149) * (1.5708 - (sqrt((1.0 - abs(x_149))) * (1.5708 + (abs(x_149) * (-0.214602 + (abs(x_149) * (0.0865667 + (abs(x_149) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_151;
        tmpvar_151 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_152;
        tmpvar_152 = floor(tmpvar_151);
        highp float tmpvar_153;
        tmpvar_153 = (tmpvar_151 - tmpvar_152);
        highp float tmpvar_154;
        tmpvar_154 = (floor(((uR_140 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_155;
        tmpvar_155 = (floor((uR_140 * RES_R)) / RES_R);
        highp float tmpvar_156;
        tmpvar_156 = fract((uR_140 * RES_R));
        highp vec4 tmpvar_157;
        tmpvar_157.zw = vec2(0.0, 0.0);
        tmpvar_157.x = ((tmpvar_152 + tmpvar_150) / RES_NU);
        tmpvar_157.y = ((uMu_139 / RES_R) + tmpvar_154);
        lowp vec4 tmpvar_158;
        tmpvar_158 = texture2DLodEXT (_Inscatter, tmpvar_157.xy, 0.0);
        highp vec4 tmpvar_159;
        tmpvar_159.zw = vec2(0.0, 0.0);
        tmpvar_159.x = (((tmpvar_152 + tmpvar_150) + 1.0) / RES_NU);
        tmpvar_159.y = ((uMu_139 / RES_R) + tmpvar_154);
        lowp vec4 tmpvar_160;
        tmpvar_160 = texture2DLodEXT (_Inscatter, tmpvar_159.xy, 0.0);
        highp vec4 tmpvar_161;
        tmpvar_161.zw = vec2(0.0, 0.0);
        tmpvar_161.x = ((tmpvar_152 + tmpvar_150) / RES_NU);
        tmpvar_161.y = ((uMu_139 / RES_R) + tmpvar_155);
        lowp vec4 tmpvar_162;
        tmpvar_162 = texture2DLodEXT (_Inscatter, tmpvar_161.xy, 0.0);
        highp vec4 tmpvar_163;
        tmpvar_163.zw = vec2(0.0, 0.0);
        tmpvar_163.x = (((tmpvar_152 + tmpvar_150) + 1.0) / RES_NU);
        tmpvar_163.y = ((uMu_139 / RES_R) + tmpvar_155);
        lowp vec4 tmpvar_164;
        tmpvar_164 = texture2DLodEXT (_Inscatter, tmpvar_163.xy, 0.0);
        inScatterA_108 = max ((inScatter0_109 - (((((tmpvar_158 * (1.0 - tmpvar_153)) + (tmpvar_160 * tmpvar_153)) * (1.0 - tmpvar_156)) + (((tmpvar_162 * (1.0 - tmpvar_153)) + (tmpvar_164 * tmpvar_153)) * tmpvar_156)) * extinction_60.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
        highp float tmpvar_165;
        tmpvar_165 = (tmpvar_106 + 0.004);
        mu_61 = tmpvar_165;
        highp float tmpvar_166;
        tmpvar_166 = sqrt((((r_63 * r_63) + (d_64 * d_64)) + (((2.0 * r_63) * d_64) * tmpvar_165)));
        r1_79 = tmpvar_166;
        mu1_78 = (((r_63 * tmpvar_165) + d_64) / tmpvar_166);
        highp float uMu_167;
        highp float uR_168;
        highp float tmpvar_169;
        tmpvar_169 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_170;
        tmpvar_170 = sqrt(((r_63 * r_63) - (Rg * Rg)));
        highp float tmpvar_171;
        tmpvar_171 = (r_63 * tmpvar_165);
        highp float tmpvar_172;
        tmpvar_172 = (((tmpvar_171 * tmpvar_171) - (r_63 * r_63)) + (Rg * Rg));
        highp vec4 tmpvar_173;
        if (((tmpvar_171 < 0.0) && (tmpvar_172 > 0.0))) {
          highp vec4 tmpvar_174;
          tmpvar_174.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_174.w = (0.5 - (0.5 / RES_MU));
          tmpvar_173 = tmpvar_174;
        } else {
          highp vec4 tmpvar_175;
          tmpvar_175.x = -1.0;
          tmpvar_175.y = (tmpvar_169 * tmpvar_169);
          tmpvar_175.z = tmpvar_169;
          tmpvar_175.w = (0.5 + (0.5 / RES_MU));
          tmpvar_173 = tmpvar_175;
        };
        uR_168 = ((0.5 / RES_R) + ((tmpvar_170 / tmpvar_169) * (1.0 - (1.0/(RES_R)))));
        uMu_167 = (tmpvar_173.w + ((((tmpvar_171 * tmpvar_173.x) + sqrt((tmpvar_172 + tmpvar_173.y))) / (tmpvar_170 + tmpvar_173.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_176;
        y_over_x_176 = (max (tmpvar_82, -0.1975) * 5.34962);
        highp float x_177;
        x_177 = (y_over_x_176 * inversesqrt(((y_over_x_176 * y_over_x_176) + 1.0)));
        highp float tmpvar_178;
        tmpvar_178 = ((0.5 / RES_MU_S) + (((((sign(x_177) * (1.5708 - (sqrt((1.0 - abs(x_177))) * (1.5708 + (abs(x_177) * (-0.214602 + (abs(x_177) * (0.0865667 + (abs(x_177) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_179;
        tmpvar_179 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_180;
        tmpvar_180 = floor(tmpvar_179);
        highp float tmpvar_181;
        tmpvar_181 = (tmpvar_179 - tmpvar_180);
        highp float tmpvar_182;
        tmpvar_182 = (floor(((uR_168 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_183;
        tmpvar_183 = (floor((uR_168 * RES_R)) / RES_R);
        highp float tmpvar_184;
        tmpvar_184 = fract((uR_168 * RES_R));
        highp vec4 tmpvar_185;
        tmpvar_185.zw = vec2(0.0, 0.0);
        tmpvar_185.x = ((tmpvar_180 + tmpvar_178) / RES_NU);
        tmpvar_185.y = ((uMu_167 / RES_R) + tmpvar_182);
        lowp vec4 tmpvar_186;
        tmpvar_186 = texture2DLodEXT (_Inscatter, tmpvar_185.xy, 0.0);
        highp vec4 tmpvar_187;
        tmpvar_187.zw = vec2(0.0, 0.0);
        tmpvar_187.x = (((tmpvar_180 + tmpvar_178) + 1.0) / RES_NU);
        tmpvar_187.y = ((uMu_167 / RES_R) + tmpvar_182);
        lowp vec4 tmpvar_188;
        tmpvar_188 = texture2DLodEXT (_Inscatter, tmpvar_187.xy, 0.0);
        highp vec4 tmpvar_189;
        tmpvar_189.zw = vec2(0.0, 0.0);
        tmpvar_189.x = ((tmpvar_180 + tmpvar_178) / RES_NU);
        tmpvar_189.y = ((uMu_167 / RES_R) + tmpvar_183);
        lowp vec4 tmpvar_190;
        tmpvar_190 = texture2DLodEXT (_Inscatter, tmpvar_189.xy, 0.0);
        highp vec4 tmpvar_191;
        tmpvar_191.zw = vec2(0.0, 0.0);
        tmpvar_191.x = (((tmpvar_180 + tmpvar_178) + 1.0) / RES_NU);
        tmpvar_191.y = ((uMu_167 / RES_R) + tmpvar_183);
        lowp vec4 tmpvar_192;
        tmpvar_192 = texture2DLodEXT (_Inscatter, tmpvar_191.xy, 0.0);
        inScatter0_109 = ((((tmpvar_186 * (1.0 - tmpvar_181)) + (tmpvar_188 * tmpvar_181)) * (1.0 - tmpvar_184)) + (((tmpvar_190 * (1.0 - tmpvar_181)) + (tmpvar_192 * tmpvar_181)) * tmpvar_184));
        highp float uMu_193;
        highp float uR_194;
        highp float tmpvar_195;
        tmpvar_195 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_196;
        tmpvar_196 = sqrt(((tmpvar_166 * tmpvar_166) - (Rg * Rg)));
        highp float tmpvar_197;
        tmpvar_197 = (tmpvar_166 * mu1_78);
        highp float tmpvar_198;
        tmpvar_198 = (((tmpvar_197 * tmpvar_197) - (tmpvar_166 * tmpvar_166)) + (Rg * Rg));
        highp vec4 tmpvar_199;
        if (((tmpvar_197 < 0.0) && (tmpvar_198 > 0.0))) {
          highp vec4 tmpvar_200;
          tmpvar_200.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_200.w = (0.5 - (0.5 / RES_MU));
          tmpvar_199 = tmpvar_200;
        } else {
          highp vec4 tmpvar_201;
          tmpvar_201.x = -1.0;
          tmpvar_201.y = (tmpvar_195 * tmpvar_195);
          tmpvar_201.z = tmpvar_195;
          tmpvar_201.w = (0.5 + (0.5 / RES_MU));
          tmpvar_199 = tmpvar_201;
        };
        uR_194 = ((0.5 / RES_R) + ((tmpvar_196 / tmpvar_195) * (1.0 - (1.0/(RES_R)))));
        uMu_193 = (tmpvar_199.w + ((((tmpvar_197 * tmpvar_199.x) + sqrt((tmpvar_198 + tmpvar_199.y))) / (tmpvar_196 + tmpvar_199.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_202;
        y_over_x_202 = (max (muS1_77, -0.1975) * 5.34962);
        highp float x_203;
        x_203 = (y_over_x_202 * inversesqrt(((y_over_x_202 * y_over_x_202) + 1.0)));
        highp float tmpvar_204;
        tmpvar_204 = ((0.5 / RES_MU_S) + (((((sign(x_203) * (1.5708 - (sqrt((1.0 - abs(x_203))) * (1.5708 + (abs(x_203) * (-0.214602 + (abs(x_203) * (0.0865667 + (abs(x_203) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_205;
        tmpvar_205 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_206;
        tmpvar_206 = floor(tmpvar_205);
        highp float tmpvar_207;
        tmpvar_207 = (tmpvar_205 - tmpvar_206);
        highp float tmpvar_208;
        tmpvar_208 = (floor(((uR_194 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_209;
        tmpvar_209 = (floor((uR_194 * RES_R)) / RES_R);
        highp float tmpvar_210;
        tmpvar_210 = fract((uR_194 * RES_R));
        highp vec4 tmpvar_211;
        tmpvar_211.zw = vec2(0.0, 0.0);
        tmpvar_211.x = ((tmpvar_206 + tmpvar_204) / RES_NU);
        tmpvar_211.y = ((uMu_193 / RES_R) + tmpvar_208);
        lowp vec4 tmpvar_212;
        tmpvar_212 = texture2DLodEXT (_Inscatter, tmpvar_211.xy, 0.0);
        highp vec4 tmpvar_213;
        tmpvar_213.zw = vec2(0.0, 0.0);
        tmpvar_213.x = (((tmpvar_206 + tmpvar_204) + 1.0) / RES_NU);
        tmpvar_213.y = ((uMu_193 / RES_R) + tmpvar_208);
        lowp vec4 tmpvar_214;
        tmpvar_214 = texture2DLodEXT (_Inscatter, tmpvar_213.xy, 0.0);
        highp vec4 tmpvar_215;
        tmpvar_215.zw = vec2(0.0, 0.0);
        tmpvar_215.x = ((tmpvar_206 + tmpvar_204) / RES_NU);
        tmpvar_215.y = ((uMu_193 / RES_R) + tmpvar_209);
        lowp vec4 tmpvar_216;
        tmpvar_216 = texture2DLodEXT (_Inscatter, tmpvar_215.xy, 0.0);
        highp vec4 tmpvar_217;
        tmpvar_217.zw = vec2(0.0, 0.0);
        tmpvar_217.x = (((tmpvar_206 + tmpvar_204) + 1.0) / RES_NU);
        tmpvar_217.y = ((uMu_193 / RES_R) + tmpvar_209);
        lowp vec4 tmpvar_218;
        tmpvar_218 = texture2DLodEXT (_Inscatter, tmpvar_217.xy, 0.0);
        inScatter_80 = mix (inScatterA_108, max ((inScatter0_109 - (((((tmpvar_212 * (1.0 - tmpvar_207)) + (tmpvar_214 * tmpvar_207)) * (1.0 - tmpvar_210)) + (((tmpvar_216 * (1.0 - tmpvar_207)) + (tmpvar_218 * tmpvar_207)) * tmpvar_210)) * extinction_60.xyzx)), vec4(0.0, 0.0, 0.0, 0.0)), vec4(a_110));
      } else {
        highp vec4 inScatter0_1_219;
        highp float uMu_220;
        highp float uR_221;
        highp float tmpvar_222;
        tmpvar_222 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_223;
        tmpvar_223 = sqrt(((r_63 * r_63) - (Rg * Rg)));
        highp float tmpvar_224;
        tmpvar_224 = (r_63 * mu_61);
        highp float tmpvar_225;
        tmpvar_225 = (((tmpvar_224 * tmpvar_224) - (r_63 * r_63)) + (Rg * Rg));
        highp vec4 tmpvar_226;
        if (((tmpvar_224 < 0.0) && (tmpvar_225 > 0.0))) {
          highp vec4 tmpvar_227;
          tmpvar_227.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_227.w = (0.5 - (0.5 / RES_MU));
          tmpvar_226 = tmpvar_227;
        } else {
          highp vec4 tmpvar_228;
          tmpvar_228.x = -1.0;
          tmpvar_228.y = (tmpvar_222 * tmpvar_222);
          tmpvar_228.z = tmpvar_222;
          tmpvar_228.w = (0.5 + (0.5 / RES_MU));
          tmpvar_226 = tmpvar_228;
        };
        uR_221 = ((0.5 / RES_R) + ((tmpvar_223 / tmpvar_222) * (1.0 - (1.0/(RES_R)))));
        uMu_220 = (tmpvar_226.w + ((((tmpvar_224 * tmpvar_226.x) + sqrt((tmpvar_225 + tmpvar_226.y))) / (tmpvar_223 + tmpvar_226.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_229;
        y_over_x_229 = (max (tmpvar_82, -0.1975) * 5.34962);
        highp float x_230;
        x_230 = (y_over_x_229 * inversesqrt(((y_over_x_229 * y_over_x_229) + 1.0)));
        highp float tmpvar_231;
        tmpvar_231 = ((0.5 / RES_MU_S) + (((((sign(x_230) * (1.5708 - (sqrt((1.0 - abs(x_230))) * (1.5708 + (abs(x_230) * (-0.214602 + (abs(x_230) * (0.0865667 + (abs(x_230) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_232;
        tmpvar_232 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_233;
        tmpvar_233 = floor(tmpvar_232);
        highp float tmpvar_234;
        tmpvar_234 = (tmpvar_232 - tmpvar_233);
        highp float tmpvar_235;
        tmpvar_235 = (floor(((uR_221 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_236;
        tmpvar_236 = (floor((uR_221 * RES_R)) / RES_R);
        highp float tmpvar_237;
        tmpvar_237 = fract((uR_221 * RES_R));
        highp vec4 tmpvar_238;
        tmpvar_238.zw = vec2(0.0, 0.0);
        tmpvar_238.x = ((tmpvar_233 + tmpvar_231) / RES_NU);
        tmpvar_238.y = ((uMu_220 / RES_R) + tmpvar_235);
        lowp vec4 tmpvar_239;
        tmpvar_239 = texture2DLodEXT (_Inscatter, tmpvar_238.xy, 0.0);
        highp vec4 tmpvar_240;
        tmpvar_240.zw = vec2(0.0, 0.0);
        tmpvar_240.x = (((tmpvar_233 + tmpvar_231) + 1.0) / RES_NU);
        tmpvar_240.y = ((uMu_220 / RES_R) + tmpvar_235);
        lowp vec4 tmpvar_241;
        tmpvar_241 = texture2DLodEXT (_Inscatter, tmpvar_240.xy, 0.0);
        highp vec4 tmpvar_242;
        tmpvar_242.zw = vec2(0.0, 0.0);
        tmpvar_242.x = ((tmpvar_233 + tmpvar_231) / RES_NU);
        tmpvar_242.y = ((uMu_220 / RES_R) + tmpvar_236);
        lowp vec4 tmpvar_243;
        tmpvar_243 = texture2DLodEXT (_Inscatter, tmpvar_242.xy, 0.0);
        highp vec4 tmpvar_244;
        tmpvar_244.zw = vec2(0.0, 0.0);
        tmpvar_244.x = (((tmpvar_233 + tmpvar_231) + 1.0) / RES_NU);
        tmpvar_244.y = ((uMu_220 / RES_R) + tmpvar_236);
        lowp vec4 tmpvar_245;
        tmpvar_245 = texture2DLodEXT (_Inscatter, tmpvar_244.xy, 0.0);
        inScatter0_1_219 = ((((tmpvar_239 * (1.0 - tmpvar_234)) + (tmpvar_241 * tmpvar_234)) * (1.0 - tmpvar_237)) + (((tmpvar_243 * (1.0 - tmpvar_234)) + (tmpvar_245 * tmpvar_234)) * tmpvar_237));
        highp float uMu_246;
        highp float uR_247;
        highp float tmpvar_248;
        tmpvar_248 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_249;
        tmpvar_249 = sqrt(((r1_79 * r1_79) - (Rg * Rg)));
        highp float tmpvar_250;
        tmpvar_250 = (r1_79 * mu1_78);
        highp float tmpvar_251;
        tmpvar_251 = (((tmpvar_250 * tmpvar_250) - (r1_79 * r1_79)) + (Rg * Rg));
        highp vec4 tmpvar_252;
        if (((tmpvar_250 < 0.0) && (tmpvar_251 > 0.0))) {
          highp vec4 tmpvar_253;
          tmpvar_253.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_253.w = (0.5 - (0.5 / RES_MU));
          tmpvar_252 = tmpvar_253;
        } else {
          highp vec4 tmpvar_254;
          tmpvar_254.x = -1.0;
          tmpvar_254.y = (tmpvar_248 * tmpvar_248);
          tmpvar_254.z = tmpvar_248;
          tmpvar_254.w = (0.5 + (0.5 / RES_MU));
          tmpvar_252 = tmpvar_254;
        };
        uR_247 = ((0.5 / RES_R) + ((tmpvar_249 / tmpvar_248) * (1.0 - (1.0/(RES_R)))));
        uMu_246 = (tmpvar_252.w + ((((tmpvar_250 * tmpvar_252.x) + sqrt((tmpvar_251 + tmpvar_252.y))) / (tmpvar_249 + tmpvar_252.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_255;
        y_over_x_255 = (max (muS1_77, -0.1975) * 5.34962);
        highp float x_256;
        x_256 = (y_over_x_255 * inversesqrt(((y_over_x_255 * y_over_x_255) + 1.0)));
        highp float tmpvar_257;
        tmpvar_257 = ((0.5 / RES_MU_S) + (((((sign(x_256) * (1.5708 - (sqrt((1.0 - abs(x_256))) * (1.5708 + (abs(x_256) * (-0.214602 + (abs(x_256) * (0.0865667 + (abs(x_256) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_258;
        tmpvar_258 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_259;
        tmpvar_259 = floor(tmpvar_258);
        highp float tmpvar_260;
        tmpvar_260 = (tmpvar_258 - tmpvar_259);
        highp float tmpvar_261;
        tmpvar_261 = (floor(((uR_247 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_262;
        tmpvar_262 = (floor((uR_247 * RES_R)) / RES_R);
        highp float tmpvar_263;
        tmpvar_263 = fract((uR_247 * RES_R));
        highp vec4 tmpvar_264;
        tmpvar_264.zw = vec2(0.0, 0.0);
        tmpvar_264.x = ((tmpvar_259 + tmpvar_257) / RES_NU);
        tmpvar_264.y = ((uMu_246 / RES_R) + tmpvar_261);
        lowp vec4 tmpvar_265;
        tmpvar_265 = texture2DLodEXT (_Inscatter, tmpvar_264.xy, 0.0);
        highp vec4 tmpvar_266;
        tmpvar_266.zw = vec2(0.0, 0.0);
        tmpvar_266.x = (((tmpvar_259 + tmpvar_257) + 1.0) / RES_NU);
        tmpvar_266.y = ((uMu_246 / RES_R) + tmpvar_261);
        lowp vec4 tmpvar_267;
        tmpvar_267 = texture2DLodEXT (_Inscatter, tmpvar_266.xy, 0.0);
        highp vec4 tmpvar_268;
        tmpvar_268.zw = vec2(0.0, 0.0);
        tmpvar_268.x = ((tmpvar_259 + tmpvar_257) / RES_NU);
        tmpvar_268.y = ((uMu_246 / RES_R) + tmpvar_262);
        lowp vec4 tmpvar_269;
        tmpvar_269 = texture2DLodEXT (_Inscatter, tmpvar_268.xy, 0.0);
        highp vec4 tmpvar_270;
        tmpvar_270.zw = vec2(0.0, 0.0);
        tmpvar_270.x = (((tmpvar_259 + tmpvar_257) + 1.0) / RES_NU);
        tmpvar_270.y = ((uMu_246 / RES_R) + tmpvar_262);
        lowp vec4 tmpvar_271;
        tmpvar_271 = texture2DLodEXT (_Inscatter, tmpvar_270.xy, 0.0);
        inScatter_80 = max ((inScatter0_1_219 - (((((tmpvar_265 * (1.0 - tmpvar_260)) + (tmpvar_267 * tmpvar_260)) * (1.0 - tmpvar_263)) + (((tmpvar_269 * (1.0 - tmpvar_260)) + (tmpvar_271 * tmpvar_260)) * tmpvar_263)) * extinction_60.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      };
      highp float t_272;
      t_272 = max (min ((tmpvar_82 / 0.02), 1.0), 0.0);
      inScatter_80.w = (inScatter_80.w * (t_272 * (t_272 * (3.0 - (2.0 * t_272)))));
      result_66 = ((inScatter_80.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_81 * tmpvar_81)))) + ((((inScatter_80.xyz * inScatter_80.w) / max (inScatter_80.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_81)), -1.5)) * (1.0 + (tmpvar_81 * tmpvar_81))) / (2.0 + (mieG * mieG)))));
    };
    tmpvar_57 = (result_66 * SUN_INTENSITY);
    visib_2 = 1.0;
    highp float tmpvar_273;
    highp vec3 arg0_274;
    arg0_274 = (worldPos_4 - _camPos);
    tmpvar_273 = sqrt(dot (arg0_274, arg0_274));
    dpth_6 = tmpvar_273;
    if ((tmpvar_273 <= _global_depth)) {
      visib_2 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_273) / _global_depth))));
    };
    if (((tmpvar_18 && tmpvar_22) && (fakeOcean == 1.0))) {
      highp vec3 L_275;
      L_275 = (oceanColor_3 * extinction_60);
      highp vec3 tmpvar_276;
      tmpvar_276 = (L_275 * _Exposure);
      L_275 = tmpvar_276;
      highp float tmpvar_277;
      if ((tmpvar_276.x < 1.413)) {
        tmpvar_277 = pow ((tmpvar_276.x * 0.38317), 0.454545);
      } else {
        tmpvar_277 = (1.0 - exp(-(tmpvar_276.x)));
      };
      L_275.x = tmpvar_277;
      highp float tmpvar_278;
      if ((tmpvar_276.y < 1.413)) {
        tmpvar_278 = pow ((tmpvar_276.y * 0.38317), 0.454545);
      } else {
        tmpvar_278 = (1.0 - exp(-(tmpvar_276.y)));
      };
      L_275.y = tmpvar_278;
      highp float tmpvar_279;
      if ((tmpvar_276.z < 1.413)) {
        tmpvar_279 = pow ((tmpvar_276.z * 0.38317), 0.454545);
      } else {
        tmpvar_279 = (1.0 - exp(-(tmpvar_276.z)));
      };
      L_275.z = tmpvar_279;
      highp vec3 L_280;
      highp vec3 tmpvar_281;
      tmpvar_281 = (tmpvar_57 * _Exposure);
      L_280 = tmpvar_281;
      highp float tmpvar_282;
      if ((tmpvar_281.x < 1.413)) {
        tmpvar_282 = pow ((tmpvar_281.x * 0.38317), 0.454545);
      } else {
        tmpvar_282 = (1.0 - exp(-(tmpvar_281.x)));
      };
      L_280.x = tmpvar_282;
      highp float tmpvar_283;
      if ((tmpvar_281.y < 1.413)) {
        tmpvar_283 = pow ((tmpvar_281.y * 0.38317), 0.454545);
      } else {
        tmpvar_283 = (1.0 - exp(-(tmpvar_281.y)));
      };
      L_280.y = tmpvar_283;
      highp float tmpvar_284;
      if ((tmpvar_281.z < 1.413)) {
        tmpvar_284 = pow ((tmpvar_281.z * 0.38317), 0.454545);
      } else {
        tmpvar_284 = (1.0 - exp(-(tmpvar_281.z)));
      };
      L_280.z = tmpvar_284;
      highp vec4 tmpvar_285;
      tmpvar_285.xyz = mix (L_275, L_280, vec3((_global_alpha * visib_2)));
      tmpvar_285.w = _fade;
      tmpvar_1 = tmpvar_285;
    } else {
      highp vec3 L_286;
      highp vec3 tmpvar_287;
      tmpvar_287 = (tmpvar_57 * _Exposure);
      L_286 = tmpvar_287;
      highp float tmpvar_288;
      if ((tmpvar_287.x < 1.413)) {
        tmpvar_288 = pow ((tmpvar_287.x * 0.38317), 0.454545);
      } else {
        tmpvar_288 = (1.0 - exp(-(tmpvar_287.x)));
      };
      L_286.x = tmpvar_288;
      highp float tmpvar_289;
      if ((tmpvar_287.y < 1.413)) {
        tmpvar_289 = pow ((tmpvar_287.y * 0.38317), 0.454545);
      } else {
        tmpvar_289 = (1.0 - exp(-(tmpvar_287.y)));
      };
      L_286.y = tmpvar_289;
      highp float tmpvar_290;
      if ((tmpvar_287.z < 1.413)) {
        tmpvar_290 = pow ((tmpvar_287.z * 0.38317), 0.454545);
      } else {
        tmpvar_290 = (1.0 - exp(-(tmpvar_287.z)));
      };
      L_286.z = tmpvar_290;
      highp vec4 tmpvar_291;
      tmpvar_291.xyz = L_286;
      tmpvar_291.w = ((_global_alpha * visib_2) * _fade);
      tmpvar_1 = tmpvar_291;
    };
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp vec4 _ZBufferParams;
uniform sampler2D _Transmittance;
uniform sampler2D _Inscatter;
uniform sampler2D _Irradiance;
uniform highp float M_PI;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp mat4 _ViewProjInv;
uniform highp float _viewdirOffset;
uniform highp float _experimentalAtmoScale;
uniform highp float _global_alpha;
uniform highp float _Exposure;
uniform highp float _global_depth;
uniform highp float _Ocean_Sigma;
uniform highp float fakeOcean;
uniform highp float _fade;
uniform highp vec3 _Ocean_Color;
uniform highp vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform highp float _openglThreshold;
uniform highp float _edgeThreshold;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp float visib_2;
  highp vec3 oceanColor_3;
  highp vec3 worldPos_4;
  highp float depth_5;
  highp float dpth_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_customDepthTexture, xlv_TEXCOORD2);
  highp float z_8;
  z_8 = tmpvar_7.x;
  dpth_6 = (1.0/(((_ZBufferParams.x * z_8) + _ZBufferParams.y)));
  lowp float tmpvar_9;
  tmpvar_9 = texture (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_10.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_10.z = depth_5;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_ViewProjInv * tmpvar_10);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 / tmpvar_11.w).xyz;
  worldPos_4 = tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 - _camPos);
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = (2.0 * dot (tmpvar_14, _camPos));
  highp float tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_17 < 0.0)) {
    tmpvar_13 = -1.0;
  } else {
    tmpvar_13 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
  };
  bool tmpvar_18;
  tmpvar_18 = (tmpvar_13 > 0.0);
  if (((dpth_6 >= _edgeThreshold) && !(tmpvar_18))) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_19;
    tmpvar_19 = (_camPos + (tmpvar_13 * (tmpvar_12 - _camPos)));
    highp vec3 arg0_20;
    arg0_20 = (tmpvar_19 - _camPos);
    highp vec3 arg0_21;
    arg0_21 = (tmpvar_12 - _camPos);
    bool tmpvar_22;
    tmpvar_22 = (sqrt(dot (arg0_20, arg0_20)) < sqrt(dot (arg0_21, arg0_21)));
    oceanColor_3 = vec3(1.0, 1.0, 1.0);
    if ((tmpvar_18 && tmpvar_22)) {
      worldPos_4 = tmpvar_19;
      if ((fakeOcean == 1.0)) {
        highp vec3 tmpvar_23;
        tmpvar_23 = normalize(tmpvar_19);
        highp vec3 tmpvar_24;
        tmpvar_24 = (tmpvar_23 * max (sqrt(dot (tmpvar_19, tmpvar_19)), (Rg + 10.0)));
        highp vec3 tmpvar_25;
        tmpvar_25 = normalize((tmpvar_24 - _camPos));
        highp vec3 worldP_26;
        worldP_26 = tmpvar_24;
        highp float r_27;
        highp float tmpvar_28;
        tmpvar_28 = sqrt(dot (tmpvar_24, tmpvar_24));
        r_27 = tmpvar_28;
        if ((tmpvar_28 < (0.9 * Rg))) {
          worldP_26.z = (tmpvar_24.z + Rg);
          r_27 = sqrt(dot (worldP_26, worldP_26));
        };
        highp vec3 tmpvar_29;
        tmpvar_29 = (worldP_26 / r_27);
        highp float tmpvar_30;
        tmpvar_30 = dot (tmpvar_29, SUN_DIR);
        highp float tmpvar_31;
        tmpvar_31 = sqrt((1.0 - ((Rg / r_27) * (Rg / r_27))));
        highp vec3 tmpvar_32;
        if ((tmpvar_30 < -(tmpvar_31))) {
          tmpvar_32 = vec3(0.0, 0.0, 0.0);
        } else {
          highp vec3 tmpvar_33;
          highp float y_over_x_34;
          y_over_x_34 = (((tmpvar_30 + 0.15) / 1.15) * 14.1014);
          highp float x_35;
          x_35 = (y_over_x_34 * inversesqrt(((y_over_x_34 * y_over_x_34) + 1.0)));
          highp vec4 tmpvar_36;
          tmpvar_36.zw = vec2(0.0, 0.0);
          tmpvar_36.x = ((sign(x_35) * (1.5708 - (sqrt((1.0 - abs(x_35))) * (1.5708 + (abs(x_35) * (-0.214602 + (abs(x_35) * (0.0865667 + (abs(x_35) * -0.0310296))))))))) / 1.5);
          tmpvar_36.y = sqrt(((r_27 - Rg) / (Rt - Rg)));
          lowp vec4 tmpvar_37;
          tmpvar_37 = textureLod (_Transmittance, tmpvar_36.xy, 0.0);
          tmpvar_33 = tmpvar_37.xyz;
          tmpvar_32 = tmpvar_33;
        };
        highp vec3 tmpvar_38;
        tmpvar_38 = (tmpvar_32 * SUN_INTENSITY);
        highp vec3 tmpvar_39;
        highp vec2 tmpvar_40;
        tmpvar_40.x = ((tmpvar_30 + 0.2) / 1.2);
        tmpvar_40.y = ((r_27 - Rg) / (Rt - Rg));
        lowp vec4 tmpvar_41;
        tmpvar_41 = textureLod (_Irradiance, tmpvar_40, 0.0);
        tmpvar_39 = tmpvar_41.xyz;
        highp vec3 tmpvar_42;
        tmpvar_42 = (((2.0 * tmpvar_39) * SUN_INTENSITY) * ((1.0 + tmpvar_29.z) * 0.5));
        highp vec3 V_43;
        V_43 = -(tmpvar_25);
        highp vec3 seaColor_44;
        seaColor_44 = (_Ocean_Color * 10.0);
        highp float tmpvar_45;
        tmpvar_45 = sqrt(_Ocean_Sigma);
        highp float tmpvar_46;
        tmpvar_46 = (pow ((1.0 - dot (V_43, tmpvar_23)), (5.0 * exp((-2.69 * tmpvar_45)))) / (1.0 + (22.7 * pow (tmpvar_45, 1.5))));
        highp vec3 tmpvar_47;
        tmpvar_47 = normalize((SUN_DIR + V_43));
        highp float tmpvar_48;
        tmpvar_48 = dot (tmpvar_47, tmpvar_23);
        highp float tmpvar_49;
        tmpvar_49 = (exp(((-2.0 * ((1.0 - (tmpvar_48 * tmpvar_48)) / _Ocean_Sigma)) / (1.0 + tmpvar_48))) / ((4.0 * M_PI) * _Ocean_Sigma));
        highp float tmpvar_50;
        tmpvar_50 = (1.0 - dot (V_43, tmpvar_47));
        highp float tmpvar_51;
        tmpvar_51 = (tmpvar_50 * tmpvar_50);
        highp float tmpvar_52;
        tmpvar_52 = (0.02 + (((0.98 * tmpvar_51) * tmpvar_51) * tmpvar_50));
        highp float tmpvar_53;
        tmpvar_53 = max (dot (SUN_DIR, tmpvar_23), 0.01);
        highp float tmpvar_54;
        tmpvar_54 = max (dot (V_43, tmpvar_23), 0.01);
        highp float tmpvar_55;
        if ((tmpvar_53 <= 0.0)) {
          tmpvar_55 = 0.0;
        } else {
          tmpvar_55 = max (((tmpvar_52 * tmpvar_49) * sqrt(abs((tmpvar_53 / tmpvar_54)))), 0.0);
        };
        oceanColor_3 = (((tmpvar_55 * tmpvar_38) + ((tmpvar_42 * tmpvar_46) / M_PI)) + ((((1.0 - tmpvar_46) * seaColor_44) * tmpvar_42) / M_PI));
      };
    };
    highp float tmpvar_56;
    tmpvar_56 = sqrt(dot (worldPos_4, worldPos_4));
    if ((tmpvar_56 < (Rg + _openglThreshold))) {
      worldPos_4 = ((Rg + _openglThreshold) * normalize(worldPos_4));
    };
    highp vec3 tmpvar_57;
    highp vec3 camera_58;
    camera_58 = _camPos;
    highp vec3 _point_59;
    _point_59 = worldPos_4;
    highp vec3 extinction_60;
    highp float mu_61;
    highp float rMu_62;
    highp float r_63;
    highp float d_64;
    highp vec3 viewdir_65;
    highp vec3 result_66;
    result_66 = vec3(0.0, 0.0, 0.0);
    extinction_60 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_67;
    tmpvar_67 = (worldPos_4 - _camPos);
    highp float tmpvar_68;
    tmpvar_68 = sqrt(dot (tmpvar_67, tmpvar_67));
    d_64 = tmpvar_68;
    highp vec3 tmpvar_69;
    tmpvar_69 = (tmpvar_67 / tmpvar_68);
    viewdir_65.yz = tmpvar_69.yz;
    highp float tmpvar_70;
    tmpvar_70 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    viewdir_65.x = (tmpvar_69.x + _viewdirOffset);
    highp vec3 tmpvar_71;
    tmpvar_71 = normalize(viewdir_65);
    viewdir_65 = tmpvar_71;
    highp float tmpvar_72;
    tmpvar_72 = sqrt(dot (_camPos, _camPos));
    r_63 = tmpvar_72;
    if ((tmpvar_72 < (0.9 * Rg))) {
      camera_58.y = (_camPos.y + Rg);
      _point_59.y = (worldPos_4.y + Rg);
      r_63 = sqrt(dot (camera_58, camera_58));
    };
    highp float tmpvar_73;
    tmpvar_73 = dot (camera_58, tmpvar_71);
    rMu_62 = tmpvar_73;
    mu_61 = (tmpvar_73 / r_63);
    highp vec3 tmpvar_74;
    tmpvar_74 = (_point_59 - (tmpvar_71 * clamp (1.0, 0.0, tmpvar_68)));
    _point_59 = tmpvar_74;
    highp float tmpvar_75;
    tmpvar_75 = max ((-(tmpvar_73) - sqrt((((tmpvar_73 * tmpvar_73) - (r_63 * r_63)) + (tmpvar_70 * tmpvar_70)))), 0.0);
    if (((tmpvar_75 > 0.0) && (tmpvar_75 < tmpvar_68))) {
      camera_58 = (camera_58 + (tmpvar_75 * tmpvar_71));
      highp float tmpvar_76;
      tmpvar_76 = (tmpvar_73 + tmpvar_75);
      rMu_62 = tmpvar_76;
      mu_61 = (tmpvar_76 / tmpvar_70);
      r_63 = tmpvar_70;
      d_64 = (tmpvar_68 - tmpvar_75);
    };
    if ((r_63 <= tmpvar_70)) {
      highp float muS1_77;
      highp float mu1_78;
      highp float r1_79;
      highp vec4 inScatter_80;
      highp float tmpvar_81;
      tmpvar_81 = dot (tmpvar_71, SUN_DIR);
      highp float tmpvar_82;
      tmpvar_82 = (dot (camera_58, SUN_DIR) / r_63);
      if ((r_63 < (Rg + 600.0))) {
        highp float tmpvar_83;
        tmpvar_83 = ((Rg + 600.0) / r_63);
        r_63 = (r_63 * tmpvar_83);
        rMu_62 = (rMu_62 * tmpvar_83);
        _point_59 = (tmpvar_74 * tmpvar_83);
      };
      highp float tmpvar_84;
      tmpvar_84 = sqrt(dot (_point_59, _point_59));
      r1_79 = tmpvar_84;
      highp float tmpvar_85;
      tmpvar_85 = (dot (_point_59, tmpvar_71) / tmpvar_84);
      mu1_78 = tmpvar_85;
      muS1_77 = (dot (_point_59, SUN_DIR) / tmpvar_84);
      if ((mu_61 > 0.0)) {
        highp vec3 tmpvar_86;
        highp float y_over_x_87;
        y_over_x_87 = (((mu_61 + 0.15) / 1.15) * 14.1014);
        highp float x_88;
        x_88 = (y_over_x_87 * inversesqrt(((y_over_x_87 * y_over_x_87) + 1.0)));
        highp vec4 tmpvar_89;
        tmpvar_89.zw = vec2(0.0, 0.0);
        tmpvar_89.x = ((sign(x_88) * (1.5708 - (sqrt((1.0 - abs(x_88))) * (1.5708 + (abs(x_88) * (-0.214602 + (abs(x_88) * (0.0865667 + (abs(x_88) * -0.0310296))))))))) / 1.5);
        tmpvar_89.y = sqrt(((r_63 - Rg) / (tmpvar_70 - Rg)));
        lowp vec4 tmpvar_90;
        tmpvar_90 = textureLod (_Transmittance, tmpvar_89.xy, 0.0);
        tmpvar_86 = tmpvar_90.xyz;
        highp vec3 tmpvar_91;
        highp float y_over_x_92;
        y_over_x_92 = (((tmpvar_85 + 0.15) / 1.15) * 14.1014);
        highp float x_93;
        x_93 = (y_over_x_92 * inversesqrt(((y_over_x_92 * y_over_x_92) + 1.0)));
        highp vec4 tmpvar_94;
        tmpvar_94.zw = vec2(0.0, 0.0);
        tmpvar_94.x = ((sign(x_93) * (1.5708 - (sqrt((1.0 - abs(x_93))) * (1.5708 + (abs(x_93) * (-0.214602 + (abs(x_93) * (0.0865667 + (abs(x_93) * -0.0310296))))))))) / 1.5);
        tmpvar_94.y = sqrt(((tmpvar_84 - Rg) / (tmpvar_70 - Rg)));
        lowp vec4 tmpvar_95;
        tmpvar_95 = textureLod (_Transmittance, tmpvar_94.xy, 0.0);
        tmpvar_91 = tmpvar_95.xyz;
        extinction_60 = min ((tmpvar_86 / tmpvar_91), vec3(1.0, 1.0, 1.0));
      } else {
        highp vec3 tmpvar_96;
        highp float y_over_x_97;
        y_over_x_97 = (((-(tmpvar_85) + 0.15) / 1.15) * 14.1014);
        highp float x_98;
        x_98 = (y_over_x_97 * inversesqrt(((y_over_x_97 * y_over_x_97) + 1.0)));
        highp vec4 tmpvar_99;
        tmpvar_99.zw = vec2(0.0, 0.0);
        tmpvar_99.x = ((sign(x_98) * (1.5708 - (sqrt((1.0 - abs(x_98))) * (1.5708 + (abs(x_98) * (-0.214602 + (abs(x_98) * (0.0865667 + (abs(x_98) * -0.0310296))))))))) / 1.5);
        tmpvar_99.y = sqrt(((tmpvar_84 - Rg) / (tmpvar_70 - Rg)));
        lowp vec4 tmpvar_100;
        tmpvar_100 = textureLod (_Transmittance, tmpvar_99.xy, 0.0);
        tmpvar_96 = tmpvar_100.xyz;
        highp vec3 tmpvar_101;
        highp float y_over_x_102;
        y_over_x_102 = (((-(mu_61) + 0.15) / 1.15) * 14.1014);
        highp float x_103;
        x_103 = (y_over_x_102 * inversesqrt(((y_over_x_102 * y_over_x_102) + 1.0)));
        highp vec4 tmpvar_104;
        tmpvar_104.zw = vec2(0.0, 0.0);
        tmpvar_104.x = ((sign(x_103) * (1.5708 - (sqrt((1.0 - abs(x_103))) * (1.5708 + (abs(x_103) * (-0.214602 + (abs(x_103) * (0.0865667 + (abs(x_103) * -0.0310296))))))))) / 1.5);
        tmpvar_104.y = sqrt(((r_63 - Rg) / (tmpvar_70 - Rg)));
        lowp vec4 tmpvar_105;
        tmpvar_105 = textureLod (_Transmittance, tmpvar_104.xy, 0.0);
        tmpvar_101 = tmpvar_105.xyz;
        extinction_60 = min ((tmpvar_96 / tmpvar_101), vec3(1.0, 1.0, 1.0));
      };
      highp float tmpvar_106;
      tmpvar_106 = -(sqrt((1.0 - ((Rg / r_63) * (Rg / r_63)))));
      highp float tmpvar_107;
      tmpvar_107 = abs((mu_61 - tmpvar_106));
      if ((tmpvar_107 < 0.004)) {
        highp vec4 inScatterA_108;
        highp vec4 inScatter0_109;
        highp float a_110;
        a_110 = (((mu_61 - tmpvar_106) + 0.004) / 0.008);
        highp float tmpvar_111;
        tmpvar_111 = (tmpvar_106 - 0.004);
        mu_61 = tmpvar_111;
        highp float tmpvar_112;
        tmpvar_112 = sqrt((((r_63 * r_63) + (d_64 * d_64)) + (((2.0 * r_63) * d_64) * tmpvar_111)));
        r1_79 = tmpvar_112;
        mu1_78 = (((r_63 * tmpvar_111) + d_64) / tmpvar_112);
        highp float uMu_113;
        highp float uR_114;
        highp float tmpvar_115;
        tmpvar_115 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_116;
        tmpvar_116 = sqrt(((r_63 * r_63) - (Rg * Rg)));
        highp float tmpvar_117;
        tmpvar_117 = (r_63 * tmpvar_111);
        highp float tmpvar_118;
        tmpvar_118 = (((tmpvar_117 * tmpvar_117) - (r_63 * r_63)) + (Rg * Rg));
        highp vec4 tmpvar_119;
        if (((tmpvar_117 < 0.0) && (tmpvar_118 > 0.0))) {
          highp vec4 tmpvar_120;
          tmpvar_120.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_120.w = (0.5 - (0.5 / RES_MU));
          tmpvar_119 = tmpvar_120;
        } else {
          highp vec4 tmpvar_121;
          tmpvar_121.x = -1.0;
          tmpvar_121.y = (tmpvar_115 * tmpvar_115);
          tmpvar_121.z = tmpvar_115;
          tmpvar_121.w = (0.5 + (0.5 / RES_MU));
          tmpvar_119 = tmpvar_121;
        };
        uR_114 = ((0.5 / RES_R) + ((tmpvar_116 / tmpvar_115) * (1.0 - (1.0/(RES_R)))));
        uMu_113 = (tmpvar_119.w + ((((tmpvar_117 * tmpvar_119.x) + sqrt((tmpvar_118 + tmpvar_119.y))) / (tmpvar_116 + tmpvar_119.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_122;
        y_over_x_122 = (max (tmpvar_82, -0.1975) * 5.34962);
        highp float x_123;
        x_123 = (y_over_x_122 * inversesqrt(((y_over_x_122 * y_over_x_122) + 1.0)));
        highp float tmpvar_124;
        tmpvar_124 = ((0.5 / RES_MU_S) + (((((sign(x_123) * (1.5708 - (sqrt((1.0 - abs(x_123))) * (1.5708 + (abs(x_123) * (-0.214602 + (abs(x_123) * (0.0865667 + (abs(x_123) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_125;
        tmpvar_125 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_126;
        tmpvar_126 = floor(tmpvar_125);
        highp float tmpvar_127;
        tmpvar_127 = (tmpvar_125 - tmpvar_126);
        highp float tmpvar_128;
        tmpvar_128 = (floor(((uR_114 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_129;
        tmpvar_129 = (floor((uR_114 * RES_R)) / RES_R);
        highp float tmpvar_130;
        tmpvar_130 = fract((uR_114 * RES_R));
        highp vec4 tmpvar_131;
        tmpvar_131.zw = vec2(0.0, 0.0);
        tmpvar_131.x = ((tmpvar_126 + tmpvar_124) / RES_NU);
        tmpvar_131.y = ((uMu_113 / RES_R) + tmpvar_128);
        lowp vec4 tmpvar_132;
        tmpvar_132 = textureLod (_Inscatter, tmpvar_131.xy, 0.0);
        highp vec4 tmpvar_133;
        tmpvar_133.zw = vec2(0.0, 0.0);
        tmpvar_133.x = (((tmpvar_126 + tmpvar_124) + 1.0) / RES_NU);
        tmpvar_133.y = ((uMu_113 / RES_R) + tmpvar_128);
        lowp vec4 tmpvar_134;
        tmpvar_134 = textureLod (_Inscatter, tmpvar_133.xy, 0.0);
        highp vec4 tmpvar_135;
        tmpvar_135.zw = vec2(0.0, 0.0);
        tmpvar_135.x = ((tmpvar_126 + tmpvar_124) / RES_NU);
        tmpvar_135.y = ((uMu_113 / RES_R) + tmpvar_129);
        lowp vec4 tmpvar_136;
        tmpvar_136 = textureLod (_Inscatter, tmpvar_135.xy, 0.0);
        highp vec4 tmpvar_137;
        tmpvar_137.zw = vec2(0.0, 0.0);
        tmpvar_137.x = (((tmpvar_126 + tmpvar_124) + 1.0) / RES_NU);
        tmpvar_137.y = ((uMu_113 / RES_R) + tmpvar_129);
        lowp vec4 tmpvar_138;
        tmpvar_138 = textureLod (_Inscatter, tmpvar_137.xy, 0.0);
        inScatter0_109 = ((((tmpvar_132 * (1.0 - tmpvar_127)) + (tmpvar_134 * tmpvar_127)) * (1.0 - tmpvar_130)) + (((tmpvar_136 * (1.0 - tmpvar_127)) + (tmpvar_138 * tmpvar_127)) * tmpvar_130));
        highp float uMu_139;
        highp float uR_140;
        highp float tmpvar_141;
        tmpvar_141 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_142;
        tmpvar_142 = sqrt(((tmpvar_112 * tmpvar_112) - (Rg * Rg)));
        highp float tmpvar_143;
        tmpvar_143 = (tmpvar_112 * mu1_78);
        highp float tmpvar_144;
        tmpvar_144 = (((tmpvar_143 * tmpvar_143) - (tmpvar_112 * tmpvar_112)) + (Rg * Rg));
        highp vec4 tmpvar_145;
        if (((tmpvar_143 < 0.0) && (tmpvar_144 > 0.0))) {
          highp vec4 tmpvar_146;
          tmpvar_146.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_146.w = (0.5 - (0.5 / RES_MU));
          tmpvar_145 = tmpvar_146;
        } else {
          highp vec4 tmpvar_147;
          tmpvar_147.x = -1.0;
          tmpvar_147.y = (tmpvar_141 * tmpvar_141);
          tmpvar_147.z = tmpvar_141;
          tmpvar_147.w = (0.5 + (0.5 / RES_MU));
          tmpvar_145 = tmpvar_147;
        };
        uR_140 = ((0.5 / RES_R) + ((tmpvar_142 / tmpvar_141) * (1.0 - (1.0/(RES_R)))));
        uMu_139 = (tmpvar_145.w + ((((tmpvar_143 * tmpvar_145.x) + sqrt((tmpvar_144 + tmpvar_145.y))) / (tmpvar_142 + tmpvar_145.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_148;
        y_over_x_148 = (max (muS1_77, -0.1975) * 5.34962);
        highp float x_149;
        x_149 = (y_over_x_148 * inversesqrt(((y_over_x_148 * y_over_x_148) + 1.0)));
        highp float tmpvar_150;
        tmpvar_150 = ((0.5 / RES_MU_S) + (((((sign(x_149) * (1.5708 - (sqrt((1.0 - abs(x_149))) * (1.5708 + (abs(x_149) * (-0.214602 + (abs(x_149) * (0.0865667 + (abs(x_149) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_151;
        tmpvar_151 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_152;
        tmpvar_152 = floor(tmpvar_151);
        highp float tmpvar_153;
        tmpvar_153 = (tmpvar_151 - tmpvar_152);
        highp float tmpvar_154;
        tmpvar_154 = (floor(((uR_140 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_155;
        tmpvar_155 = (floor((uR_140 * RES_R)) / RES_R);
        highp float tmpvar_156;
        tmpvar_156 = fract((uR_140 * RES_R));
        highp vec4 tmpvar_157;
        tmpvar_157.zw = vec2(0.0, 0.0);
        tmpvar_157.x = ((tmpvar_152 + tmpvar_150) / RES_NU);
        tmpvar_157.y = ((uMu_139 / RES_R) + tmpvar_154);
        lowp vec4 tmpvar_158;
        tmpvar_158 = textureLod (_Inscatter, tmpvar_157.xy, 0.0);
        highp vec4 tmpvar_159;
        tmpvar_159.zw = vec2(0.0, 0.0);
        tmpvar_159.x = (((tmpvar_152 + tmpvar_150) + 1.0) / RES_NU);
        tmpvar_159.y = ((uMu_139 / RES_R) + tmpvar_154);
        lowp vec4 tmpvar_160;
        tmpvar_160 = textureLod (_Inscatter, tmpvar_159.xy, 0.0);
        highp vec4 tmpvar_161;
        tmpvar_161.zw = vec2(0.0, 0.0);
        tmpvar_161.x = ((tmpvar_152 + tmpvar_150) / RES_NU);
        tmpvar_161.y = ((uMu_139 / RES_R) + tmpvar_155);
        lowp vec4 tmpvar_162;
        tmpvar_162 = textureLod (_Inscatter, tmpvar_161.xy, 0.0);
        highp vec4 tmpvar_163;
        tmpvar_163.zw = vec2(0.0, 0.0);
        tmpvar_163.x = (((tmpvar_152 + tmpvar_150) + 1.0) / RES_NU);
        tmpvar_163.y = ((uMu_139 / RES_R) + tmpvar_155);
        lowp vec4 tmpvar_164;
        tmpvar_164 = textureLod (_Inscatter, tmpvar_163.xy, 0.0);
        inScatterA_108 = max ((inScatter0_109 - (((((tmpvar_158 * (1.0 - tmpvar_153)) + (tmpvar_160 * tmpvar_153)) * (1.0 - tmpvar_156)) + (((tmpvar_162 * (1.0 - tmpvar_153)) + (tmpvar_164 * tmpvar_153)) * tmpvar_156)) * extinction_60.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
        highp float tmpvar_165;
        tmpvar_165 = (tmpvar_106 + 0.004);
        mu_61 = tmpvar_165;
        highp float tmpvar_166;
        tmpvar_166 = sqrt((((r_63 * r_63) + (d_64 * d_64)) + (((2.0 * r_63) * d_64) * tmpvar_165)));
        r1_79 = tmpvar_166;
        mu1_78 = (((r_63 * tmpvar_165) + d_64) / tmpvar_166);
        highp float uMu_167;
        highp float uR_168;
        highp float tmpvar_169;
        tmpvar_169 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_170;
        tmpvar_170 = sqrt(((r_63 * r_63) - (Rg * Rg)));
        highp float tmpvar_171;
        tmpvar_171 = (r_63 * tmpvar_165);
        highp float tmpvar_172;
        tmpvar_172 = (((tmpvar_171 * tmpvar_171) - (r_63 * r_63)) + (Rg * Rg));
        highp vec4 tmpvar_173;
        if (((tmpvar_171 < 0.0) && (tmpvar_172 > 0.0))) {
          highp vec4 tmpvar_174;
          tmpvar_174.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_174.w = (0.5 - (0.5 / RES_MU));
          tmpvar_173 = tmpvar_174;
        } else {
          highp vec4 tmpvar_175;
          tmpvar_175.x = -1.0;
          tmpvar_175.y = (tmpvar_169 * tmpvar_169);
          tmpvar_175.z = tmpvar_169;
          tmpvar_175.w = (0.5 + (0.5 / RES_MU));
          tmpvar_173 = tmpvar_175;
        };
        uR_168 = ((0.5 / RES_R) + ((tmpvar_170 / tmpvar_169) * (1.0 - (1.0/(RES_R)))));
        uMu_167 = (tmpvar_173.w + ((((tmpvar_171 * tmpvar_173.x) + sqrt((tmpvar_172 + tmpvar_173.y))) / (tmpvar_170 + tmpvar_173.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_176;
        y_over_x_176 = (max (tmpvar_82, -0.1975) * 5.34962);
        highp float x_177;
        x_177 = (y_over_x_176 * inversesqrt(((y_over_x_176 * y_over_x_176) + 1.0)));
        highp float tmpvar_178;
        tmpvar_178 = ((0.5 / RES_MU_S) + (((((sign(x_177) * (1.5708 - (sqrt((1.0 - abs(x_177))) * (1.5708 + (abs(x_177) * (-0.214602 + (abs(x_177) * (0.0865667 + (abs(x_177) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_179;
        tmpvar_179 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_180;
        tmpvar_180 = floor(tmpvar_179);
        highp float tmpvar_181;
        tmpvar_181 = (tmpvar_179 - tmpvar_180);
        highp float tmpvar_182;
        tmpvar_182 = (floor(((uR_168 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_183;
        tmpvar_183 = (floor((uR_168 * RES_R)) / RES_R);
        highp float tmpvar_184;
        tmpvar_184 = fract((uR_168 * RES_R));
        highp vec4 tmpvar_185;
        tmpvar_185.zw = vec2(0.0, 0.0);
        tmpvar_185.x = ((tmpvar_180 + tmpvar_178) / RES_NU);
        tmpvar_185.y = ((uMu_167 / RES_R) + tmpvar_182);
        lowp vec4 tmpvar_186;
        tmpvar_186 = textureLod (_Inscatter, tmpvar_185.xy, 0.0);
        highp vec4 tmpvar_187;
        tmpvar_187.zw = vec2(0.0, 0.0);
        tmpvar_187.x = (((tmpvar_180 + tmpvar_178) + 1.0) / RES_NU);
        tmpvar_187.y = ((uMu_167 / RES_R) + tmpvar_182);
        lowp vec4 tmpvar_188;
        tmpvar_188 = textureLod (_Inscatter, tmpvar_187.xy, 0.0);
        highp vec4 tmpvar_189;
        tmpvar_189.zw = vec2(0.0, 0.0);
        tmpvar_189.x = ((tmpvar_180 + tmpvar_178) / RES_NU);
        tmpvar_189.y = ((uMu_167 / RES_R) + tmpvar_183);
        lowp vec4 tmpvar_190;
        tmpvar_190 = textureLod (_Inscatter, tmpvar_189.xy, 0.0);
        highp vec4 tmpvar_191;
        tmpvar_191.zw = vec2(0.0, 0.0);
        tmpvar_191.x = (((tmpvar_180 + tmpvar_178) + 1.0) / RES_NU);
        tmpvar_191.y = ((uMu_167 / RES_R) + tmpvar_183);
        lowp vec4 tmpvar_192;
        tmpvar_192 = textureLod (_Inscatter, tmpvar_191.xy, 0.0);
        inScatter0_109 = ((((tmpvar_186 * (1.0 - tmpvar_181)) + (tmpvar_188 * tmpvar_181)) * (1.0 - tmpvar_184)) + (((tmpvar_190 * (1.0 - tmpvar_181)) + (tmpvar_192 * tmpvar_181)) * tmpvar_184));
        highp float uMu_193;
        highp float uR_194;
        highp float tmpvar_195;
        tmpvar_195 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_196;
        tmpvar_196 = sqrt(((tmpvar_166 * tmpvar_166) - (Rg * Rg)));
        highp float tmpvar_197;
        tmpvar_197 = (tmpvar_166 * mu1_78);
        highp float tmpvar_198;
        tmpvar_198 = (((tmpvar_197 * tmpvar_197) - (tmpvar_166 * tmpvar_166)) + (Rg * Rg));
        highp vec4 tmpvar_199;
        if (((tmpvar_197 < 0.0) && (tmpvar_198 > 0.0))) {
          highp vec4 tmpvar_200;
          tmpvar_200.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_200.w = (0.5 - (0.5 / RES_MU));
          tmpvar_199 = tmpvar_200;
        } else {
          highp vec4 tmpvar_201;
          tmpvar_201.x = -1.0;
          tmpvar_201.y = (tmpvar_195 * tmpvar_195);
          tmpvar_201.z = tmpvar_195;
          tmpvar_201.w = (0.5 + (0.5 / RES_MU));
          tmpvar_199 = tmpvar_201;
        };
        uR_194 = ((0.5 / RES_R) + ((tmpvar_196 / tmpvar_195) * (1.0 - (1.0/(RES_R)))));
        uMu_193 = (tmpvar_199.w + ((((tmpvar_197 * tmpvar_199.x) + sqrt((tmpvar_198 + tmpvar_199.y))) / (tmpvar_196 + tmpvar_199.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_202;
        y_over_x_202 = (max (muS1_77, -0.1975) * 5.34962);
        highp float x_203;
        x_203 = (y_over_x_202 * inversesqrt(((y_over_x_202 * y_over_x_202) + 1.0)));
        highp float tmpvar_204;
        tmpvar_204 = ((0.5 / RES_MU_S) + (((((sign(x_203) * (1.5708 - (sqrt((1.0 - abs(x_203))) * (1.5708 + (abs(x_203) * (-0.214602 + (abs(x_203) * (0.0865667 + (abs(x_203) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_205;
        tmpvar_205 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_206;
        tmpvar_206 = floor(tmpvar_205);
        highp float tmpvar_207;
        tmpvar_207 = (tmpvar_205 - tmpvar_206);
        highp float tmpvar_208;
        tmpvar_208 = (floor(((uR_194 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_209;
        tmpvar_209 = (floor((uR_194 * RES_R)) / RES_R);
        highp float tmpvar_210;
        tmpvar_210 = fract((uR_194 * RES_R));
        highp vec4 tmpvar_211;
        tmpvar_211.zw = vec2(0.0, 0.0);
        tmpvar_211.x = ((tmpvar_206 + tmpvar_204) / RES_NU);
        tmpvar_211.y = ((uMu_193 / RES_R) + tmpvar_208);
        lowp vec4 tmpvar_212;
        tmpvar_212 = textureLod (_Inscatter, tmpvar_211.xy, 0.0);
        highp vec4 tmpvar_213;
        tmpvar_213.zw = vec2(0.0, 0.0);
        tmpvar_213.x = (((tmpvar_206 + tmpvar_204) + 1.0) / RES_NU);
        tmpvar_213.y = ((uMu_193 / RES_R) + tmpvar_208);
        lowp vec4 tmpvar_214;
        tmpvar_214 = textureLod (_Inscatter, tmpvar_213.xy, 0.0);
        highp vec4 tmpvar_215;
        tmpvar_215.zw = vec2(0.0, 0.0);
        tmpvar_215.x = ((tmpvar_206 + tmpvar_204) / RES_NU);
        tmpvar_215.y = ((uMu_193 / RES_R) + tmpvar_209);
        lowp vec4 tmpvar_216;
        tmpvar_216 = textureLod (_Inscatter, tmpvar_215.xy, 0.0);
        highp vec4 tmpvar_217;
        tmpvar_217.zw = vec2(0.0, 0.0);
        tmpvar_217.x = (((tmpvar_206 + tmpvar_204) + 1.0) / RES_NU);
        tmpvar_217.y = ((uMu_193 / RES_R) + tmpvar_209);
        lowp vec4 tmpvar_218;
        tmpvar_218 = textureLod (_Inscatter, tmpvar_217.xy, 0.0);
        inScatter_80 = mix (inScatterA_108, max ((inScatter0_109 - (((((tmpvar_212 * (1.0 - tmpvar_207)) + (tmpvar_214 * tmpvar_207)) * (1.0 - tmpvar_210)) + (((tmpvar_216 * (1.0 - tmpvar_207)) + (tmpvar_218 * tmpvar_207)) * tmpvar_210)) * extinction_60.xyzx)), vec4(0.0, 0.0, 0.0, 0.0)), vec4(a_110));
      } else {
        highp vec4 inScatter0_1_219;
        highp float uMu_220;
        highp float uR_221;
        highp float tmpvar_222;
        tmpvar_222 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_223;
        tmpvar_223 = sqrt(((r_63 * r_63) - (Rg * Rg)));
        highp float tmpvar_224;
        tmpvar_224 = (r_63 * mu_61);
        highp float tmpvar_225;
        tmpvar_225 = (((tmpvar_224 * tmpvar_224) - (r_63 * r_63)) + (Rg * Rg));
        highp vec4 tmpvar_226;
        if (((tmpvar_224 < 0.0) && (tmpvar_225 > 0.0))) {
          highp vec4 tmpvar_227;
          tmpvar_227.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_227.w = (0.5 - (0.5 / RES_MU));
          tmpvar_226 = tmpvar_227;
        } else {
          highp vec4 tmpvar_228;
          tmpvar_228.x = -1.0;
          tmpvar_228.y = (tmpvar_222 * tmpvar_222);
          tmpvar_228.z = tmpvar_222;
          tmpvar_228.w = (0.5 + (0.5 / RES_MU));
          tmpvar_226 = tmpvar_228;
        };
        uR_221 = ((0.5 / RES_R) + ((tmpvar_223 / tmpvar_222) * (1.0 - (1.0/(RES_R)))));
        uMu_220 = (tmpvar_226.w + ((((tmpvar_224 * tmpvar_226.x) + sqrt((tmpvar_225 + tmpvar_226.y))) / (tmpvar_223 + tmpvar_226.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_229;
        y_over_x_229 = (max (tmpvar_82, -0.1975) * 5.34962);
        highp float x_230;
        x_230 = (y_over_x_229 * inversesqrt(((y_over_x_229 * y_over_x_229) + 1.0)));
        highp float tmpvar_231;
        tmpvar_231 = ((0.5 / RES_MU_S) + (((((sign(x_230) * (1.5708 - (sqrt((1.0 - abs(x_230))) * (1.5708 + (abs(x_230) * (-0.214602 + (abs(x_230) * (0.0865667 + (abs(x_230) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_232;
        tmpvar_232 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_233;
        tmpvar_233 = floor(tmpvar_232);
        highp float tmpvar_234;
        tmpvar_234 = (tmpvar_232 - tmpvar_233);
        highp float tmpvar_235;
        tmpvar_235 = (floor(((uR_221 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_236;
        tmpvar_236 = (floor((uR_221 * RES_R)) / RES_R);
        highp float tmpvar_237;
        tmpvar_237 = fract((uR_221 * RES_R));
        highp vec4 tmpvar_238;
        tmpvar_238.zw = vec2(0.0, 0.0);
        tmpvar_238.x = ((tmpvar_233 + tmpvar_231) / RES_NU);
        tmpvar_238.y = ((uMu_220 / RES_R) + tmpvar_235);
        lowp vec4 tmpvar_239;
        tmpvar_239 = textureLod (_Inscatter, tmpvar_238.xy, 0.0);
        highp vec4 tmpvar_240;
        tmpvar_240.zw = vec2(0.0, 0.0);
        tmpvar_240.x = (((tmpvar_233 + tmpvar_231) + 1.0) / RES_NU);
        tmpvar_240.y = ((uMu_220 / RES_R) + tmpvar_235);
        lowp vec4 tmpvar_241;
        tmpvar_241 = textureLod (_Inscatter, tmpvar_240.xy, 0.0);
        highp vec4 tmpvar_242;
        tmpvar_242.zw = vec2(0.0, 0.0);
        tmpvar_242.x = ((tmpvar_233 + tmpvar_231) / RES_NU);
        tmpvar_242.y = ((uMu_220 / RES_R) + tmpvar_236);
        lowp vec4 tmpvar_243;
        tmpvar_243 = textureLod (_Inscatter, tmpvar_242.xy, 0.0);
        highp vec4 tmpvar_244;
        tmpvar_244.zw = vec2(0.0, 0.0);
        tmpvar_244.x = (((tmpvar_233 + tmpvar_231) + 1.0) / RES_NU);
        tmpvar_244.y = ((uMu_220 / RES_R) + tmpvar_236);
        lowp vec4 tmpvar_245;
        tmpvar_245 = textureLod (_Inscatter, tmpvar_244.xy, 0.0);
        inScatter0_1_219 = ((((tmpvar_239 * (1.0 - tmpvar_234)) + (tmpvar_241 * tmpvar_234)) * (1.0 - tmpvar_237)) + (((tmpvar_243 * (1.0 - tmpvar_234)) + (tmpvar_245 * tmpvar_234)) * tmpvar_237));
        highp float uMu_246;
        highp float uR_247;
        highp float tmpvar_248;
        tmpvar_248 = sqrt(((tmpvar_70 * tmpvar_70) - (Rg * Rg)));
        highp float tmpvar_249;
        tmpvar_249 = sqrt(((r1_79 * r1_79) - (Rg * Rg)));
        highp float tmpvar_250;
        tmpvar_250 = (r1_79 * mu1_78);
        highp float tmpvar_251;
        tmpvar_251 = (((tmpvar_250 * tmpvar_250) - (r1_79 * r1_79)) + (Rg * Rg));
        highp vec4 tmpvar_252;
        if (((tmpvar_250 < 0.0) && (tmpvar_251 > 0.0))) {
          highp vec4 tmpvar_253;
          tmpvar_253.xyz = vec3(1.0, 0.0, 0.0);
          tmpvar_253.w = (0.5 - (0.5 / RES_MU));
          tmpvar_252 = tmpvar_253;
        } else {
          highp vec4 tmpvar_254;
          tmpvar_254.x = -1.0;
          tmpvar_254.y = (tmpvar_248 * tmpvar_248);
          tmpvar_254.z = tmpvar_248;
          tmpvar_254.w = (0.5 + (0.5 / RES_MU));
          tmpvar_252 = tmpvar_254;
        };
        uR_247 = ((0.5 / RES_R) + ((tmpvar_249 / tmpvar_248) * (1.0 - (1.0/(RES_R)))));
        uMu_246 = (tmpvar_252.w + ((((tmpvar_250 * tmpvar_252.x) + sqrt((tmpvar_251 + tmpvar_252.y))) / (tmpvar_249 + tmpvar_252.z)) * (0.5 - (1.0/(RES_MU)))));
        highp float y_over_x_255;
        y_over_x_255 = (max (muS1_77, -0.1975) * 5.34962);
        highp float x_256;
        x_256 = (y_over_x_255 * inversesqrt(((y_over_x_255 * y_over_x_255) + 1.0)));
        highp float tmpvar_257;
        tmpvar_257 = ((0.5 / RES_MU_S) + (((((sign(x_256) * (1.5708 - (sqrt((1.0 - abs(x_256))) * (1.5708 + (abs(x_256) * (-0.214602 + (abs(x_256) * (0.0865667 + (abs(x_256) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
        highp float tmpvar_258;
        tmpvar_258 = (((tmpvar_81 + 1.0) / 2.0) * (RES_NU - 1.0));
        highp float tmpvar_259;
        tmpvar_259 = floor(tmpvar_258);
        highp float tmpvar_260;
        tmpvar_260 = (tmpvar_258 - tmpvar_259);
        highp float tmpvar_261;
        tmpvar_261 = (floor(((uR_247 * RES_R) - 1.0)) / RES_R);
        highp float tmpvar_262;
        tmpvar_262 = (floor((uR_247 * RES_R)) / RES_R);
        highp float tmpvar_263;
        tmpvar_263 = fract((uR_247 * RES_R));
        highp vec4 tmpvar_264;
        tmpvar_264.zw = vec2(0.0, 0.0);
        tmpvar_264.x = ((tmpvar_259 + tmpvar_257) / RES_NU);
        tmpvar_264.y = ((uMu_246 / RES_R) + tmpvar_261);
        lowp vec4 tmpvar_265;
        tmpvar_265 = textureLod (_Inscatter, tmpvar_264.xy, 0.0);
        highp vec4 tmpvar_266;
        tmpvar_266.zw = vec2(0.0, 0.0);
        tmpvar_266.x = (((tmpvar_259 + tmpvar_257) + 1.0) / RES_NU);
        tmpvar_266.y = ((uMu_246 / RES_R) + tmpvar_261);
        lowp vec4 tmpvar_267;
        tmpvar_267 = textureLod (_Inscatter, tmpvar_266.xy, 0.0);
        highp vec4 tmpvar_268;
        tmpvar_268.zw = vec2(0.0, 0.0);
        tmpvar_268.x = ((tmpvar_259 + tmpvar_257) / RES_NU);
        tmpvar_268.y = ((uMu_246 / RES_R) + tmpvar_262);
        lowp vec4 tmpvar_269;
        tmpvar_269 = textureLod (_Inscatter, tmpvar_268.xy, 0.0);
        highp vec4 tmpvar_270;
        tmpvar_270.zw = vec2(0.0, 0.0);
        tmpvar_270.x = (((tmpvar_259 + tmpvar_257) + 1.0) / RES_NU);
        tmpvar_270.y = ((uMu_246 / RES_R) + tmpvar_262);
        lowp vec4 tmpvar_271;
        tmpvar_271 = textureLod (_Inscatter, tmpvar_270.xy, 0.0);
        inScatter_80 = max ((inScatter0_1_219 - (((((tmpvar_265 * (1.0 - tmpvar_260)) + (tmpvar_267 * tmpvar_260)) * (1.0 - tmpvar_263)) + (((tmpvar_269 * (1.0 - tmpvar_260)) + (tmpvar_271 * tmpvar_260)) * tmpvar_263)) * extinction_60.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      };
      highp float t_272;
      t_272 = max (min ((tmpvar_82 / 0.02), 1.0), 0.0);
      inScatter_80.w = (inScatter_80.w * (t_272 * (t_272 * (3.0 - (2.0 * t_272)))));
      result_66 = ((inScatter_80.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_81 * tmpvar_81)))) + ((((inScatter_80.xyz * inScatter_80.w) / max (inScatter_80.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_81)), -1.5)) * (1.0 + (tmpvar_81 * tmpvar_81))) / (2.0 + (mieG * mieG)))));
    };
    tmpvar_57 = (result_66 * SUN_INTENSITY);
    visib_2 = 1.0;
    highp float tmpvar_273;
    highp vec3 arg0_274;
    arg0_274 = (worldPos_4 - _camPos);
    tmpvar_273 = sqrt(dot (arg0_274, arg0_274));
    dpth_6 = tmpvar_273;
    if ((tmpvar_273 <= _global_depth)) {
      visib_2 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_273) / _global_depth))));
    };
    if (((tmpvar_18 && tmpvar_22) && (fakeOcean == 1.0))) {
      highp vec3 L_275;
      L_275 = (oceanColor_3 * extinction_60);
      highp vec3 tmpvar_276;
      tmpvar_276 = (L_275 * _Exposure);
      L_275 = tmpvar_276;
      highp float tmpvar_277;
      if ((tmpvar_276.x < 1.413)) {
        tmpvar_277 = pow ((tmpvar_276.x * 0.38317), 0.454545);
      } else {
        tmpvar_277 = (1.0 - exp(-(tmpvar_276.x)));
      };
      L_275.x = tmpvar_277;
      highp float tmpvar_278;
      if ((tmpvar_276.y < 1.413)) {
        tmpvar_278 = pow ((tmpvar_276.y * 0.38317), 0.454545);
      } else {
        tmpvar_278 = (1.0 - exp(-(tmpvar_276.y)));
      };
      L_275.y = tmpvar_278;
      highp float tmpvar_279;
      if ((tmpvar_276.z < 1.413)) {
        tmpvar_279 = pow ((tmpvar_276.z * 0.38317), 0.454545);
      } else {
        tmpvar_279 = (1.0 - exp(-(tmpvar_276.z)));
      };
      L_275.z = tmpvar_279;
      highp vec3 L_280;
      highp vec3 tmpvar_281;
      tmpvar_281 = (tmpvar_57 * _Exposure);
      L_280 = tmpvar_281;
      highp float tmpvar_282;
      if ((tmpvar_281.x < 1.413)) {
        tmpvar_282 = pow ((tmpvar_281.x * 0.38317), 0.454545);
      } else {
        tmpvar_282 = (1.0 - exp(-(tmpvar_281.x)));
      };
      L_280.x = tmpvar_282;
      highp float tmpvar_283;
      if ((tmpvar_281.y < 1.413)) {
        tmpvar_283 = pow ((tmpvar_281.y * 0.38317), 0.454545);
      } else {
        tmpvar_283 = (1.0 - exp(-(tmpvar_281.y)));
      };
      L_280.y = tmpvar_283;
      highp float tmpvar_284;
      if ((tmpvar_281.z < 1.413)) {
        tmpvar_284 = pow ((tmpvar_281.z * 0.38317), 0.454545);
      } else {
        tmpvar_284 = (1.0 - exp(-(tmpvar_281.z)));
      };
      L_280.z = tmpvar_284;
      highp vec4 tmpvar_285;
      tmpvar_285.xyz = mix (L_275, L_280, vec3((_global_alpha * visib_2)));
      tmpvar_285.w = _fade;
      tmpvar_1 = tmpvar_285;
    } else {
      highp vec3 L_286;
      highp vec3 tmpvar_287;
      tmpvar_287 = (tmpvar_57 * _Exposure);
      L_286 = tmpvar_287;
      highp float tmpvar_288;
      if ((tmpvar_287.x < 1.413)) {
        tmpvar_288 = pow ((tmpvar_287.x * 0.38317), 0.454545);
      } else {
        tmpvar_288 = (1.0 - exp(-(tmpvar_287.x)));
      };
      L_286.x = tmpvar_288;
      highp float tmpvar_289;
      if ((tmpvar_287.y < 1.413)) {
        tmpvar_289 = pow ((tmpvar_287.y * 0.38317), 0.454545);
      } else {
        tmpvar_289 = (1.0 - exp(-(tmpvar_287.y)));
      };
      L_286.y = tmpvar_289;
      highp float tmpvar_290;
      if ((tmpvar_287.z < 1.413)) {
        tmpvar_290 = pow ((tmpvar_287.z * 0.38317), 0.454545);
      } else {
        tmpvar_290 = (1.0 - exp(-(tmpvar_287.z)));
      };
      L_286.z = tmpvar_290;
      highp vec4 tmpvar_291;
      tmpvar_291.xyz = L_286;
      tmpvar_291.w = ((_global_alpha * visib_2) * _fade);
      tmpvar_1 = tmpvar_291;
    };
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
// Stats: 1014 math, 61 textures, 9 branches
Matrix 0 [_ViewProjInv]
Vector 4 [_ZBufferParams]
Float 5 [M_PI]
Float 6 [Rg]
Float 7 [Rt]
Float 8 [RES_R]
Float 9 [RES_MU]
Float 10 [RES_MU_S]
Float 11 [RES_NU]
Vector 12 [SUN_DIR]
Float 13 [SUN_INTENSITY]
Vector 14 [betaR]
Float 15 [mieG]
Float 16 [_viewdirOffset]
Float 17 [_experimentalAtmoScale]
Float 18 [_global_alpha]
Float 19 [_Exposure]
Float 20 [_global_depth]
Float 21 [_Ocean_Sigma]
Float 22 [fakeOcean]
Float 23 [_fade]
Vector 24 [_Ocean_Color]
Vector 25 [_camPos]
Float 26 [_edgeThreshold]
SetTexture 0 [_customDepthTexture] 2D 0
SetTexture 1 [_Transmittance] 2D 1
SetTexture 2 [_Irradiance] 2D 2
SetTexture 3 [_Inscatter] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c27, 1.00000000, 0.00000000, 2.00000000, -1.00000000
def c28, 4.00000000, 0.01000000, 10.00000000, -2.00000000
def c29, 2.71828198, 0.98000002, 0.02000000, 0.89999998
def c30, 0.15000001, 12.26193905, -0.01348047, 0.05747731
def c31, -0.12123910, 0.19563590, -0.33299461, 0.99999559
def c32, 1.57079601, 0.66666669, 0.20000000, 0.83333331
def c33, 0.50000000, -2.69000006, 5.00000000, 1.50000000
def c34, 22.70000076, 1.00000000, 1000000015047466200000000000000.00000000, 600.00000000
def c35, 0.00400000, -0.19750001, 5.34960032, -0.00400000
def c36, 0.90909088, 0.74000001, 124.99999237, 16.00000000
def c37, -1.50000000, 50.00000000, 2.00000000, 3.00000000
def c38, 0.00010000, 0.38317001, 0.45454544, -1.41299999
dcl_texcoord2 v0.xy
texld r0.x, v0, s0
mov r4.z, r0.x
mad r0.x, r0, c4, c4.y
rcp r0.x, r0.x
add r0.x, r0, -c26
mad r4.xy, v0, c27.z, c27.w
mov r4.w, c27.x
dp4 r0.y, r4, c3
dp4 r3.z, r4, c2
dp4 r3.y, r4, c1
dp4 r3.x, r4, c0
rcp r0.y, r0.y
mul r8.xyz, r3, r0.y
mov r4.xyz, c25
dp3 r0.z, c27.y, r4
dp3 r0.y, c25, c25
add r0.y, r0, -r0.z
add r3.xyz, r8, -c25
dp3 r0.z, r3, r3
mad r0.y, -c6.x, c6.x, r0
mul r0.w, r0.z, r0.y
dp3 r0.y, r3, c25
mul r0.y, r0, c27.z
mul r0.w, r0, c28.x
mad r0.w, r0.y, r0.y, -r0
cmp_pp r1.y, r0.w, c27.x, c27
cmp r1.x, r0.w, r1, c27.w
rsq r0.w, r0.w
mul r1.z, r0, c27
rcp r0.z, r0.w
add r0.y, -r0, -r0.z
rcp r0.w, r1.z
mul r0.y, r0, r0.w
cmp r1.x, -r1.y, r1, r0.y
cmp r9.w, -r1.x, c27.y, c27.x
abs_pp r0.y, r9.w
cmp_pp r0.y, -r0, c27.x, c27
cmp r0.x, r0, c27, c27.y
mul_pp r1.y, r0.x, r0
cmp_pp r0, -r1.y, r2, c27.y
mov_pp r2, r0
cmp_pp r8.w, -r1.y, c27.x, c27.y
mov_pp oC0, r0
if_gt r8.w, c27.y
add r0.xyz, r8, -c25
mul r1.xyz, r1.x, r0
dp3 r0.y, r0, r0
dp3 r0.x, r1, r1
rsq r0.y, r0.y
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp r10.w, r0.x, c27.y, c27.x
add r0.xyz, r1, c25
mul_pp r0.w, r10, r9
mov r9.xyz, c27.x
if_gt r0.w, c27.y
mov r0.w, c27.x
mov r8.xyz, r0
if_eq c22.x, r0.w
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mov r1.x, c6
add r1.y, c28.z, r1.x
rcp r1.x, r0.w
mul r3.xyz, r0.w, r0
max r1.x, r1, r1.y
mul r0.xyz, r3, r1.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
rcp r1.w, r0.w
mov r0.w, c6.x
mov r1.xy, r0
mad r0.w, c29, -r0, r1
add r1.z, r0, c6.x
cmp r1.z, r0.w, r0, r1
dp3 r3.w, r1, r1
rsq r3.w, r3.w
rcp r3.w, r3.w
cmp r0.w, r0, r1, r3
rcp r4.w, r0.w
mul r5.xyz, r1, r4.w
dp3 r3.w, r5, c12
add r1.x, r3.w, c30
mul r1.y, r1.x, c30
abs r1.z, r1.y
max r1.x, r1.z, c27
rcp r1.w, r1.x
min r1.x, r1.z, c27
mul r1.x, r1, r1.w
mul r1.w, r1.x, r1.x
mad r4.x, r1.w, c30.z, c30.w
mad r4.x, r4, r1.w, c31
mad r4.x, r4, r1.w, c31.y
mad r4.x, r4, r1.w, c31.z
mad r1.w, r4.x, r1, c31
mul r1.w, r1, r1.x
mov r1.x, c7
add r1.x, -c6, r1
add r4.x, -r1.w, c32
add r1.z, r1, c27.w
cmp r4.x, -r1.z, r1.w, r4
rcp r1.x, r1.x
add r0.w, r0, -c6.x
mul r1.zw, r0.w, r1.x
cmp r0.w, r1.y, r4.x, -r4.x
rsq r1.x, r1.z
rcp r4.y, r1.x
mul r4.x, r0.w, c32.y
add r1.xyz, r0, -c25
mov r4.z, c27.y
texldl r0.xyz, r4.xyzz, s1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r4.x, r4.w, c6
mad r0.w, -r4.x, r4.x, c27.x
rsq r4.w, r0.w
add r4.xyz, -r1, c12
dp3 r0.w, r4, r4
rsq r0.w, r0.w
rcp r4.w, r4.w
mul r6.xyz, r0.w, r4
add r4.w, r3, r4
cmp r4.xyz, r4.w, r0, c27.y
dp3 r0.x, -r1, r6
dp3 r0.z, r3, r6
add r0.w, r0.z, c27.x
rcp r4.w, r0.w
add r0.x, -r0, c27
mul r0.y, r0.x, r0.x
mul r0.y, r0, r0
mul r0.x, r0.y, r0
mad r5.x, r0, c29.y, c29.z
rcp r0.w, c21.x
mad r0.z, -r0, r0, c27.x
mul r0.z, r0, r0.w
mul r0.z, r0, r4.w
mul r4.w, r0.z, c28
pow r0, c29.x, r4.w
dp3 r0.w, -r1, r3
max r0.y, r0.w, c28
mov r0.z, r0.x
rcp r1.x, r0.y
dp3 r0.y, r3, c12
max r4.w, r0.y, c28.y
mul r0.y, r4.w, r1.x
mov r0.x, c5
mul r0.x, c21, r0
mul r0.x, r0, c28
rcp r0.x, r0.x
mul r0.x, r0.z, r0
abs r0.y, r0
rsq r0.z, r0.y
mul r0.y, r5.x, r0.x
rcp r0.z, r0.z
mul r5.y, r0, r0.z
add r0.x, r3.w, c32.z
rsq r1.x, c21.x
rcp r3.w, r1.x
mov r0.y, r1.w
mul r4.xyz, r4, c13.x
mul r0.x, r0, c32.w
mov r0.z, c27.y
texldl r0.xyz, r0.xyzz, s2
mul r3.xyz, r0, c13.x
add r0.y, r5.z, c27.x
mul r0.x, r3.w, c33.y
pow r1, c29.x, r0.x
add r1.y, -r0.w, c27.x
mul r5.x, r0.y, c33
pow r0, r3.w, c33.w
mov r0.y, r1.x
mul r1.x, r0.y, c33.z
mov r1.z, r0.x
pow r0, r1.y, r1.x
mad r0.y, r1.z, c34.x, c34
rcp r0.y, r0.y
mul r0.w, r0.x, r0.y
mul r0.xyz, r3, r5.x
add r1.x, -r0.w, c27
max r3.x, r5.y, c27.y
mul r0.xyz, r0, c27.z
mul r1.xyz, r1.x, c24
mul r1.xyz, r1, r0
mul r0.xyz, r0.w, r0
rcp r1.w, c5.x
mul r5.xyz, r0, r1.w
cmp r0.x, -r4.w, c27.y, r3
mad r3.xyz, r0.x, r4, r5
mul r0.xyz, r1, r1.w
mad r9.xyz, r0, c28.z, r3
endif
endif
add r0.xyz, r8, -c25
dp3 r0.w, r0, r0
rsq r3.y, r0.w
mul r0.xyz, r3.y, r0
mov r1.yz, r0
add r1.x, r0, c16
dp3 r0.x, r1, r1
rsq r3.z, r0.x
mov r0.y, c25
add r3.x, c6, r0.y
dp3 r0.w, c25, c25
rsq r0.w, r0.w
rcp r4.w, r3.y
mov r0.xz, c25
mul r1.xyz, r3.z, r1
rcp r0.w, r0.w
mov r0.y, c6.x
mad r1.w, c29, -r0.y, r0
cmp r0.y, r1.w, c25, r3.x
dp3 r3.x, r0, r0
rsq r3.x, r3.x
rcp r3.z, r3.x
cmp r4.x, r1.w, r0.w, r3.z
mov r3.x, c7
add r0.w, -c6.x, r3.x
mul r0.w, r0, c17.x
dp3 r3.w, r0, r1
mul r3.x, r4, r4
add r0.w, r0, c6.x
mad r3.x, r3.w, r3.w, -r3
mad r3.x, r0.w, r0.w, r3
rsq r3.z, r3.x
rcp r3.z, r3.z
cmp r3.x, r3, r3.z, c34.z
add r3.x, -r3.w, -r3
max r4.y, r3.x, c27
add r4.z, r4.y, -r4.w
cmp r5.x, r4.z, c27.y, c27
cmp r4.z, -r4.y, c27.y, c27.x
mul_pp r4.z, r4, r5.x
mad r3.xyz, r4.y, r1, r0
add r5.x, -r4.y, r4.w
cmp r0.xyz, -r4.z, r0, r3
add r3.x, r8.y, c6
cmp r3.y, r1.w, r8, r3.x
cmp r16.x, -r4.z, r4, r0.w
mov_sat r1.w, r4
cmp r15.w, -r4.z, r4, r5.x
mov r3.xz, r8
mad r3.xyz, -r1, r1.w, r3
rcp r1.w, r4.x
add r4.y, r4, r3.w
rcp r4.w, r0.w
mul r4.y, r4, r4.w
mul r1.w, r3, r1
cmp r11.w, -r4.z, r1, r4.y
mov r4.xyz, c27.y
mov r10.xyz, c27.x
if_le r16.x, r0.w
mov r1.w, c6.x
add r3.w, c34, r1
rcp r1.w, r16.x
add r4.w, r16.x, -r3
dp3 r0.x, r0, c12
mul r4.x, r1.w, r3.w
mul r4.xyz, r3, r4.x
cmp r3.xyz, r4.w, r3, r4
mul r13.w, r0.x, r1
dp3 r4.x, r3, r3
dp3 r4.y, r3, c12
dp3 r3.y, r1, r3
rsq r3.x, r4.x
mul r6.z, r3.x, r3.y
mul r7.w, r3.x, r4.y
rcp r11.z, r3.x
dp3 r12.w, r1, c12
cmp r16.x, r4.w, r16, r3.w
if_gt r11.w, c27.y
add r0.x, r6.z, c30
mul r1.x, r0, c30.y
abs r1.y, r1.x
max r0.x, r1.y, c27
rcp r0.y, r0.x
min r0.x, r1.y, c27
mul r1.z, r0.x, r0.y
add r0.x, r11.w, c30
mul r1.w, r0.x, c30.y
mul r3.y, r1.z, r1.z
mad r0.x, r3.y, c30.z, c30.w
mad r0.y, r0.x, r3, c31.x
abs r3.x, r1.w
mad r0.z, r0.y, r3.y, c31.y
max r0.x, r3, c27
rcp r0.y, r0.x
min r0.x, r3, c27
mul r0.y, r0.x, r0
mad r0.x, r0.z, r3.y, c31.z
mad r3.y, r0.x, r3, c31.w
mul r0.z, r0.y, r0.y
mul r1.z, r3.y, r1
mad r0.x, r0.z, c30.z, c30.w
mad r0.x, r0, r0.z, c31
mad r0.x, r0, r0.z, c31.y
add r3.y, -r1.z, c32.x
add r1.y, r1, c27.w
cmp r1.y, -r1, r1.z, r3
cmp r1.y, r1.x, r1, -r1
mad r1.x, r0, r0.z, c31.z
mad r0.z, r1.x, r0, c31.w
mul r3.y, r0.z, r0
mul r0.x, r1.y, c32.y
add r1.x, r0.w, -c6
rcp r3.z, r1.x
add r1.y, r11.z, -c6.x
mul r1.x, r3.z, r1.y
rsq r0.y, r1.x
mov r0.z, c27.y
rcp r0.y, r0.y
texldl r1.xyz, r0.xyzz, s1
add r0.y, -r3, c32.x
add r0.x, r3, c27.w
cmp r0.x, -r0, r3.y, r0.y
add r0.y, r16.x, -c6.x
cmp r0.x, r1.w, r0, -r0
mul r0.y, r0, r3.z
rsq r0.y, r0.y
mul r0.x, r0, c32.y
mov r0.z, c27.y
rcp r0.y, r0.y
texldl r0.xyz, r0.xyzz, s1
rcp r1.x, r1.x
rcp r1.z, r1.z
rcp r1.y, r1.y
mul r0.xyz, r0, r1
min r10.xyz, r0, c27.x
else
add r0.x, -r11.w, c30
mul r1.x, r0, c30.y
abs r1.y, r1.x
max r0.x, r1.y, c27
rcp r0.y, r0.x
min r0.x, r1.y, c27
mul r1.z, r0.x, r0.y
add r0.x, -r6.z, c30
mul r1.w, r0.x, c30.y
mul r3.y, r1.z, r1.z
mad r0.x, r3.y, c30.z, c30.w
mad r0.y, r0.x, r3, c31.x
abs r3.x, r1.w
mad r0.z, r0.y, r3.y, c31.y
max r0.x, r3, c27
rcp r0.y, r0.x
min r0.x, r3, c27
mul r0.y, r0.x, r0
mad r0.x, r0.z, r3.y, c31.z
mad r3.y, r0.x, r3, c31.w
mul r0.z, r0.y, r0.y
mul r1.z, r3.y, r1
mad r0.x, r0.z, c30.z, c30.w
mad r0.x, r0, r0.z, c31
mad r0.x, r0, r0.z, c31.y
add r3.y, -r1.z, c32.x
add r1.y, r1, c27.w
cmp r1.y, -r1, r1.z, r3
cmp r1.y, r1.x, r1, -r1
mad r1.x, r0, r0.z, c31.z
mad r0.z, r1.x, r0, c31.w
mul r3.y, r0.z, r0
mul r0.x, r1.y, c32.y
add r1.x, r0.w, -c6
rcp r3.z, r1.x
add r1.y, r16.x, -c6.x
mul r1.x, r3.z, r1.y
rsq r0.y, r1.x
mov r0.z, c27.y
rcp r0.y, r0.y
texldl r1.xyz, r0.xyzz, s1
add r0.y, -r3, c32.x
add r0.x, r3, c27.w
cmp r0.x, -r0, r3.y, r0.y
add r0.y, r11.z, -c6.x
cmp r0.x, r1.w, r0, -r0
mul r0.y, r0, r3.z
rsq r0.y, r0.y
mul r0.x, r0, c32.y
mov r0.z, c27.y
rcp r0.y, r0.y
texldl r0.xyz, r0.xyzz, s1
rcp r1.x, r1.x
rcp r1.z, r1.z
rcp r1.y, r1.y
mul r0.xyz, r0, r1
min r10.xyz, r0, c27.x
endif
rcp r0.x, r16.x
mul r0.x, r0, c6
mad r0.x, -r0, r0, c27
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.y, r0.x, r11.w
abs r0.y, r0
mov r14.w, -r0.x
if_lt r0.y, c35.x
rcp r1.w, c9.x
add r5.x, r14.w, c35
rcp r13.y, c8.x
mul r12.y, c6.x, c6.x
mad r0.z, r0.w, r0.w, -r12.y
add r17.x, r14.w, c35.w
mul r0.x, r15.w, r15.w
mov r3.xyz, c27.xyyw
rsq r12.z, r0.z
mad r3.w, -r1, c33.x, c33.x
mad r4.w, r1, c33.x, c33.x
add r13.z, -r1.w, c33.x
mov r4.x, c27.w
rcp r7.x, c11.x
mul r11.z, r16.x, r5.x
add r15.z, -r13.y, c27.x
mul r14.z, r16.x, r17.x
mad r16.y, r16.x, r16.x, r0.x
mul r16.z, r16.x, r15.w
mul r0.x, r16.z, r5
mad r0.x, r0, c27.z, r16.y
rsq r0.x, r0.x
mad r0.y, r16.x, r5.x, r15.w
rcp r1.x, r0.x
mul r0.y, r0.x, r0
mul r1.y, r1.x, r0
mul r0.y, r1.x, r1.x
mad r0.y, r1, r1, -r0
mad r1.z, c6.x, c6.x, r0.y
mad r1.x, r1, r1, -r12.y
rsq r1.x, r1.x
cmp r0.y, -r1.z, c27, c27.x
cmp r0.x, r1.y, c27.y, c27
mul_pp r0.x, r0, r0.y
rcp r0.y, r12.z
mul r4.y, r0, r0
mov r4.z, r0.y
cmp r0, -r0.x, r4, r3
add r0.y, r0, r1.z
rcp r1.x, r1.x
rsq r0.y, r0.y
rcp r0.y, r0.y
add r0.z, r0, r1.x
mad r0.x, r1.y, r0, r0.y
rcp r0.y, r0.z
mul r0.x, r0, r0.y
max r0.y, r7.w, c35
rcp r7.w, c10.x
mad r0.x, r0, r13.z, r0.w
mul r0.z, r12, r1.x
mul r0.w, r0.z, r15.z
mad r1.x, r13.y, c33, r0.w
mul r1.z, r1.x, c8.x
frc r11.y, r1.z
add r1.w, r1.z, -r11.y
mul r1.w, r13.y, r1
mul r0.y, r0, c35.z
abs r0.z, r0.y
max r0.w, r0.z, c27.x
rcp r1.x, r0.w
min r0.w, r0.z, c27.x
mul r0.w, r0, r1.x
mul r1.x, r0.w, r0.w
mad r1.y, r1.x, c30.z, c30.w
mad r1.y, r1, r1.x, c31.x
mad r1.y, r1, r1.x, c31
mad r1.y, r1, r1.x, c31.z
mad r1.x, r1.y, r1, c31.w
mul r0.w, r1.x, r0
mad r5.y, r0.x, r13, r1.w
add r1.z, r1, c27.w
frc r1.w, r1.z
add r1.y, r1.z, -r1.w
mul r1.y, r1, r13
add r11.x, -r7.w, c27
add r1.x, -r0.w, c32
add r0.z, r0, c27.w
cmp r0.z, -r0, r0.w, r1.x
cmp r0.y, r0, r0.z, -r0.z
mov r0.w, c11.x
mad r0.y, r0, c36.x, c36
mad r0.y, r0, r11.x, r7.w
mul r7.z, r16.x, r16.x
add r0.w, c27, r0
add r0.z, r12.w, c27.x
mul r0.z, r0, r0.w
mul r0.z, r0, c33.x
frc r15.x, r0.z
add r7.y, r0.z, -r15.x
mad r0.w, r0.y, c33.x, r7.y
mad r0.y, r0.x, r13, r1
add r0.x, r0.w, c27
mul r12.x, r7, r0
add r15.y, -r15.x, c27.x
mul r13.x, r0.w, r7
mov r0.z, c27.y
mov r0.x, r12
texldl r1, r0.xyzz, s3
mul r1, r15.x, r1
mov r0.z, c27.y
mov r0.x, r13
texldl r0, r0.xyzz, s3
mad r6, r0, r15.y, r1
mov r0.y, r5
mov r0.z, c27.y
mov r0.x, r13
texldl r1, r0.xyzz, s3
mad r0.x, r11.z, r11.z, -r7.z
mad r14.x, c6, c6, r0
cmp r0.y, -r14.x, c27, c27.x
cmp r0.x, r11.z, c27.y, c27
mul_pp r0.x, r0, r0.y
cmp r0, -r0.x, r4, r3
add r0.y, r0, r14.x
rsq r0.y, r0.y
rcp r14.x, r0.y
add r0.y, -r11, c27.x
mov r5.x, r12
mov r5.z, c27.y
texldl r5, r5.xyzz, s3
mul r5, r15.x, r5
mad r1, r15.y, r1, r5
mul r1, r11.y, r1
mad r5, r6, r0.y, r1
mad r1.z, r11, r0.x, r14.x
mad r0.y, r16.x, r16.x, -r12
rsq r0.y, r0.y
rcp r14.y, r0.y
add r1.x, r0.z, r14.y
max r0.x, r13.w, c35.y
mul r0.x, r0, c35.z
abs r0.y, r0.x
max r0.z, r0.y, c27.x
rcp r1.w, r1.x
rcp r1.x, r0.z
min r0.z, r0.y, c27.x
mul r1.y, r0.z, r1.x
mul r0.z, r1, r1.w
mad r1.x, r13.z, r0.z, r0.w
mul r1.z, r1.y, r1.y
mul r0.w, r12.z, r14.y
mad r0.z, r1, c30, c30.w
mad r0.z, r0, r1, c31.x
mul r0.w, r15.z, r0
mad r0.z, r0, r1, c31.y
mad r1.w, r13.y, c33.x, r0
mad r0.w, r0.z, r1.z, c31.z
mul r0.z, r1.w, c8.x
mad r0.w, r0, r1.z, c31
mul r0.w, r0, r1.y
add r1.z, r0, c27.w
frc r16.w, r0.z
add r1.y, -r0.w, c32.x
add r0.y, r0, c27.w
cmp r0.y, -r0, r0.w, r1
cmp r0.x, r0, r0.y, -r0.y
frc r1.w, r1.z
add r0.w, r1.z, -r1
mul r11.z, r13.y, r0.w
add r0.y, r0.z, -r16.w
mad r0.x, r0, c36, c36.y
mad r0.x, r11, r0, r7.w
mad r6.w, r0.x, c33.x, r7.y
mul r11.y, r13, r0
add r0.x, r6.w, c27
mul r11.x, r7, r0
mul r14.x, r7, r6.w
mad r6.y, r13, r1.x, r11.z
mad r7.y, r13, r1.x, r11
mov r6.z, c27.y
mov r6.x, r11
texldl r0, r6.xyzz, s3
mul r1, r15.x, r0
mov r0.y, r6
mov r7.x, r11
mov r0.z, c27.y
mov r0.x, r14
texldl r0, r0.xyzz, s3
mad r6, r15.y, r0, r1
mad r1.x, r14.z, r14.z, -r7.z
mad r17.y, c6.x, c6.x, r1.x
cmp r1.x, r14.z, c27.y, c27
cmp r1.y, -r17, c27, c27.x
mov r0.y, r7
mov r7.z, c27.y
mul_pp r7.w, r1.x, r1.y
texldl r1, r7.xyzz, s3
cmp r7, -r7.w, r4, r3
mul r1, r15.x, r1
add r7.y, r7, r17
mov r0.x, r14
mov r0.z, c27.y
texldl r0, r0.xyzz, s3
mad r0, r15.y, r0, r1
add r1.y, r14, r7.z
rsq r1.x, r7.y
rcp r1.x, r1.x
mad r1.x, r14.z, r7, r1
rcp r1.y, r1.y
mul r1.x, r1, r1.y
mad r7.y, r13.z, r1.x, r7.w
mad r11.y, r13, r7, r11
mul r0, r16.w, r0
add r7.x, -r16.w, c27
mad r1, r6, r7.x, r0
mad r6.y, r13, r7, r11.z
mul r7.y, r16.z, r17.x
mad r7.y, r7, c27.z, r16
rsq r7.z, r7.y
rcp r7.y, r7.z
mad r7.w, r16.x, r17.x, r15
mul r7.z, r7, r7.w
mul r7.z, r7.y, r7
mul r7.w, r7.y, r7.y
mad r7.w, r7.z, r7.z, -r7
mov r6.z, c27.y
mov r6.x, r11
texldl r0, r6.xyzz, s3
mad r5, -r5, r10.xyzx, r1
mul r1, r15.x, r0
mov r0.y, r6
mad r7.w, c6.x, c6.x, r7
mov r0.z, c27.y
mov r0.x, r14
texldl r0, r0.xyzz, s3
mad r6, r15.y, r0, r1
mov r11.z, c27.y
texldl r1, r11.xyzz, s3
mul r1, r15.x, r1
mov r14.z, c27.y
mov r14.y, r11
texldl r0, r14.xyzz, s3
mad r0, r15.y, r0, r1
mul r0, r16.w, r0
mad r0, r7.x, r6, r0
cmp r1.y, -r7.w, c27, c27.x
cmp r1.x, r7.z, c27.y, c27
mul_pp r1.x, r1, r1.y
cmp r1, -r1.x, r4, r3
mad r3.x, r7.y, r7.y, -r12.y
add r1.y, r1, r7.w
rsq r3.x, r3.x
rcp r3.x, r3.x
mul r3.y, r12.z, r3.x
rsq r1.y, r1.y
rcp r1.y, r1.y
mad r1.x, r7.z, r1, r1.y
add r1.y, r1.z, r3.x
mul r3.y, r15.z, r3
mad r1.z, r13.y, c33.x, r3.y
mul r1.z, r1, c8.x
rcp r1.y, r1.y
mul r1.x, r1, r1.y
mad r1.x, r13.z, r1, r1.w
frc r6.w, r1.z
add r1.w, r1.z, -r6
add r1.y, r1.z, c27.w
mul r1.w, r13.y, r1
frc r1.z, r1.y
add r1.y, r1, -r1.z
mul r1.y, r13, r1
mad r12.y, r13, r1.x, r1.w
mad r6.y, r13, r1.x, r1
mov r12.z, c27.y
texldl r3, r12.xyzz, s3
mov r6.z, c27.y
mov r6.x, r12
texldl r1, r6.xyzz, s3
mul r3, r15.x, r3
mov r13.z, c27.y
mov r13.y, r12
texldl r4, r13.xyzz, s3
mad r3, r15.y, r4, r3
mul r4, r15.x, r1
mul r3, r6.w, r3
mov r1.y, r6
mov r1.z, c27.y
mov r1.x, r13
texldl r1, r1.xyzz, s3
mad r1, r15.y, r1, r4
add r4.x, -r6.w, c27
mad r1, r1, r4.x, r3
mad r0, r10.xyzx, -r1, r0
add r3.x, r11.w, -r14.w
max r0, r0, c27.y
max r1, r5, c27.y
add r1, r1, -r0
add r3.x, r3, c35
mul r1, r3.x, r1
mad r0, r1, c36.z, r0
else
rcp r4.x, c9.x
mul r4.y, r16.x, r11.w
rcp r11.w, c8.x
mul r12.x, c6, c6
rcp r12.z, c10.x
mul r0.x, r16, r16
mad r0.y, r4, r4, -r0.x
mad r4.z, c6.x, c6.x, r0.y
mad r0.x, r0.w, r0.w, -r12
rsq r12.y, r0.x
rcp r0.w, r12.y
mul r1.y, r0.w, r0.w
mov r1.z, r0.w
mad r1.w, r4.x, c33.x, c33.x
rcp r11.y, c11.x
cmp r0.y, -r4.z, c27, c27.x
cmp r0.x, r4.y, c27.y, c27
mul_pp r3.x, r0, r0.y
mov r1.x, c27.w
mad r0.w, -r4.x, c33.x, c33.x
mov r0.xyz, c27.xyyw
cmp r3, -r3.x, r1, r0
add r3.y, r3, r4.z
mad r4.w, r16.x, r16.x, -r12.x
rsq r4.z, r4.w
rcp r4.z, r4.z
add r3.z, r3, r4
add r13.z, -r4.x, c33.x
rsq r3.y, r3.y
rcp r3.y, r3.y
mad r3.y, r4, r3.x, r3
rcp r3.z, r3.z
mul r3.y, r3, r3.z
max r3.x, r13.w, c35.y
mul r3.z, r3.x, c35
mad r6.y, r13.z, r3, r3.w
abs r3.y, r3.z
max r3.x, r3.y, c27
rcp r3.w, r3.x
min r3.x, r3.y, c27
mul r3.x, r3, r3.w
mul r3.w, r3.x, r3.x
mul r4.x, r12.y, r4.z
add r14.x, -r11.w, c27
mul r4.x, r14, r4
mad r4.y, r11.w, c33.x, r4.x
mul r5.x, r4.y, c8
add r4.y, r5.x, c27.w
frc r14.y, r5.x
frc r4.z, r4.y
add r4.y, r4, -r4.z
mad r4.x, r3.w, c30.z, c30.w
mad r4.x, r4, r3.w, c31
mad r4.x, r4, r3.w, c31.y
mad r4.x, r4, r3.w, c31.z
mad r3.w, r4.x, r3, c31
mul r3.w, r3, r3.x
mul r4.x, r11.w, r4.y
mad r4.y, r11.w, r6, r4.x
add r5.x, r5, -r14.y
mul r7.y, r11.w, r5.x
mad r6.y, r11.w, r6, r7
add r4.x, -r3.w, c32
add r3.y, r3, c27.w
cmp r3.w, -r3.y, r3, r4.x
mov r3.x, c11
add r3.y, c27.w, r3.x
add r3.x, r12.w, c27
mul r3.x, r3, r3.y
cmp r3.y, r3.z, r3.w, -r3.w
mul r3.x, r3, c33
frc r11.x, r3
add r6.w, -r11.x, c27.x
add r13.y, r3.x, -r11.x
mov r7.y, r6
mad r3.y, r3, c36.x, c36
add r13.x, -r12.z, c27
mad r3.x, r13, r3.y, r12.z
mad r3.x, r3, c33, r13.y
add r3.z, r3.x, c27.x
mul r6.x, r11.y, r3.z
mul r7.x, r11.y, r3
mov r3.y, r4
mov r3.x, r7
mov r3.z, c27.y
texldl r3, r3.xyzz, s3
mov r4.x, r6
mov r4.z, c27.y
texldl r4, r4.xyzz, s3
mul r4, r11.x, r4
mad r5, r6.w, r3, r4
mov r7.z, c27.y
texldl r3, r7.xyzz, s3
mul r7.x, r11.z, r6.z
mul r4.x, r11.z, r11.z
mad r4.x, r7, r7, -r4
mad r7.y, c6.x, c6.x, r4.x
mov r6.z, c27.y
texldl r4, r6.xyzz, s3
mul r4, r11.x, r4
cmp r6.y, -r7, c27, c27.x
cmp r6.x, r7, c27.y, c27
mul_pp r6.x, r6, r6.y
cmp r0, -r6.x, r1, r0
mad r1, r6.w, r3, r4
add r0.y, r0, r7
rsq r0.y, r0.y
add r3.x, -r14.y, c27
mul r1, r14.y, r1
mad r1, r5, r3.x, r1
rcp r0.y, r0.y
mad r3.x, r7, r0, r0.y
mad r3.y, r11.z, r11.z, -r12.x
rsq r0.y, r3.y
rcp r3.y, r0.y
add r0.z, r0, r3.y
rcp r3.z, r0.z
mul r3.z, r3.x, r3
max r0.x, r7.w, c35.y
mul r0.x, r0, c35.z
abs r0.y, r0.x
max r0.z, r0.y, c27.x
rcp r3.x, r0.z
min r0.z, r0.y, c27.x
mul r3.y, r12, r3
mul r3.y, r3, r14.x
mad r3.y, r11.w, c33.x, r3
mul r3.y, r3, c8.x
mad r4.x, r3.z, r13.z, r0.w
mul r0.z, r0, r3.x
mul r0.w, r0.z, r0.z
mad r3.x, r0.w, c30.z, c30.w
mad r3.x, r3, r0.w, c31
mad r3.x, r3, r0.w, c31.y
mad r3.x, r3, r0.w, c31.z
mad r0.w, r3.x, r0, c31
frc r5.w, r3.y
mul r0.z, r0.w, r0
add r3.x, r3.y, -r5.w
mul r3.x, r11.w, r3
mad r5.y, r4.x, r11.w, r3.x
add r0.w, -r0.z, c32.x
add r0.y, r0, c27.w
cmp r0.y, -r0, r0.z, r0.w
cmp r0.x, r0, r0.y, -r0.y
add r0.y, r3, c27.w
frc r0.z, r0.y
mad r0.x, r0, c36, c36.y
mad r0.x, r0, r13, r12.z
add r0.y, r0, -r0.z
mad r7.x, r0, c33, r13.y
mul r0.x, r0.y, r11.w
add r0.y, r7.x, c27.x
mul r5.x, r11.y, r0.y
mov r5.z, c27.y
texldl r3, r5.xyzz, s3
mad r6.y, r4.x, r11.w, r0.x
mov r6.x, r5
mov r6.z, c27.y
texldl r0, r6.xyzz, s3
mul r4, r11.x, r3
mul r5.x, r7, r11.y
mov r5.z, c27.y
texldl r3, r5.xyzz, s3
mad r4, r6.w, r3, r4
mul r3, r11.x, r0
mov r0.y, r6
mov r0.z, c27.y
mov r0.x, r5
texldl r0, r0.xyzz, s3
mad r0, r0, r6.w, r3
mul r3, r5.w, r4
add r4.x, -r5.w, c27
mad r0, r0, r4.x, r3
mad r0, -r0, r10.xyzx, r1
max r0, r0, c27.y
endif
mul_sat r1.x, r13.w, c37.y
mad r1.y, -r1.x, c37.z, c37.w
max r1.w, r0.x, c38.x
mul r1.x, r1, r1
mul r1.x, r1, r1.y
mul r1.x, r0.w, r1
mul r0.w, r12, c15.x
mul r0.w, r0, c27.z
mad r0.w, c15.x, c15.x, -r0
mul r1.xyz, r0, r1.x
rcp r1.w, r1.w
add r0.w, r0, c27.x
mul r3.xyz, r1, r1.w
pow r1, r0.w, c37.x
mov r0.w, c5.x
mul r0.w, c28.x, r0
mov r1.z, r1.x
mul r1.y, -c15.x, c15.x
add r1.x, r1.y, c27
rcp r0.w, r0.w
mul r0.w, r0, r1.x
add r1.y, -r1, c27.z
mul r0.w, r0, r1.z
mad r1.x, r12.w, r12.w, c27
mul r1.z, r1.x, r0.w
mov r0.w, c5.x
rcp r1.y, r1.y
mul r0.w, c36, r0
rcp r0.w, r0.w
mul r0.w, r0, r1.x
mul r1.y, r1.z, r1
rcp r4.x, c14.x
rcp r4.z, c14.z
rcp r4.y, c14.y
mul r4.xyz, r4, c14.x
mul r3.xyz, r3, r4
mul r3.xyz, r1.y, r3
mul r1.xyz, r3, c33.w
mul r0.xyz, r0.w, r0
mad r4.xyz, r0, c37.w, r1
endif
add r0.xyz, r8, -c25
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r1.x, r0.x
rcp r0.y, c20.x
mul r0.x, r1, r0.y
mul r1.y, r0.x, c28.x
pow r0, c29.x, -r1.y
mov r0.y, c22.x
add r0.z, c27.w, r0.y
add r0.x, -r0, c27
add r0.y, r1.x, -c20.x
cmp r3.w, -r0.y, r0.x, c27.x
abs r0.z, r0
cmp r0.y, -r0.z, c27.x, c27
mul_pp r0.x, r9.w, r10.w
mul_pp r0.x, r0, r0.y
mul r3.xyz, r4, c13.x
if_gt r0.x, c27.y
mul r0.xyz, r9, r10
mul r2.xyz, r0, c19.x
mul r4.x, r2.z, c38.y
pow r0, r4.x, c38.z
pow r1, c29.x, -r2.z
mov r0.y, r1.x
mov r0.z, r0.x
pow r1, c29.x, -r2.y
add r2.w, r2.z, c38
add r0.x, -r0.y, c27
cmp r2.z, r2.w, r0.x, r0
mul r4.x, r2.y, c38.y
pow r0, r4.x, c38.z
mov r0.y, r1.x
pow r1, c29.x, -r2.x
mul r1.y, r2.x, c38
mov r0.z, r0.x
mul r4.xyz, r3, c19.x
add r2.w, r2.y, c38
add r0.x, -r0.y, c27
cmp r2.y, r2.w, r0.x, r0.z
pow r0, r1.y, c38.z
mov r0.y, r1.x
pow r1, c29.x, -r4.z
mul r1.y, r4.z, c38
add r2.w, r2.x, c38
add r0.y, -r0, c27.x
cmp r2.x, r2.w, r0.y, r0
pow r0, r1.y, c38.z
mov r0.y, r1.x
pow r1, c29.x, -r4.y
mul r1.y, r4, c38
mov r0.z, r0.x
add r0.x, r4.z, c38.w
add r0.y, -r0, c27.x
cmp r4.z, r0.x, r0.y, r0
pow r0, r1.y, c38.z
mov r0.y, r1.x
pow r1, c29.x, -r4.x
mul r1.y, r4.x, c38
mov r0.z, r0.x
add r0.x, r4.y, c38.w
add r0.y, -r0, c27.x
cmp r4.y, r0.x, r0, r0.z
pow r0, r1.y, c38.z
mov r0.y, r1.x
mov r0.z, r0.x
add r0.x, r4, c38.w
add r0.y, -r0, c27.x
cmp r4.x, r0, r0.y, r0.z
add r1.xyz, r4, -r2
mul r0.x, r3.w, c18
mad r0.xyz, r0.x, r1, r2
mov r0.w, c23.x
mov_pp r2, r0
mov_pp oC0, r0
mov_pp r8.w, c27.y
endif
mul r3.xyz, r3, c19.x
pow r1, c29.x, -r3.x
mul r1.y, r3.x, c38
pow r0, r1.y, c38.z
mov r0.y, r1.x
pow r1, c29.x, -r3.y
mul r1.y, r3, c38
mov r0.z, r0.x
add r0.x, r3, c38.w
add r0.y, -r0, c27.x
cmp r3.x, r0, r0.y, r0.z
pow r0, r1.y, c38.z
mov r0.y, r1.x
mov r0.z, r0.x
pow r1, c29.x, -r3.z
mul r1.y, r3.z, c38
add r0.x, r3.y, c38.w
add r0.y, -r0, c27.x
cmp r3.y, r0.x, r0, r0.z
pow r0, r1.y, c38.z
mov r0.y, r1.x
mov r0.z, r0.x
mul r0.w, r3, c18.x
add r0.y, -r0, c27.x
add r0.x, r3.z, c38.w
mul r3.w, r0, c23.x
cmp r3.z, r0.x, r0.y, r0
cmp_pp oC0, -r8.w, r2, r3
endif
"
}
SubProgram "d3d11 " {
// Stats: 686 math, 1 textures, 14 branches
SetTexture 0 [_customDepthTexture] 2D 3
SetTexture 1 [_Transmittance] 2D 0
SetTexture 2 [_Irradiance] 2D 2
SetTexture 3 [_Inscatter] 2D 1
ConstBuffer "$Globals" 336
Matrix 112 [_ViewProjInv]
Float 32 [M_PI]
Float 52 [Rg]
Float 56 [Rt]
Float 64 [RES_R]
Float 68 [RES_MU]
Float 72 [RES_MU_S]
Float 76 [RES_NU]
Vector 80 [SUN_DIR] 3
Float 92 [SUN_INTENSITY]
Vector 96 [betaR] 3
Float 108 [mieG]
Float 176 [_viewdirOffset]
Float 180 [_experimentalAtmoScale]
Float 188 [_global_alpha]
Float 192 [_Exposure]
Float 196 [_global_depth]
Float 200 [_Ocean_Sigma]
Float 204 [fakeOcean]
Float 208 [_fade]
Vector 212 [_Ocean_Color] 3
Vector 224 [_camPos] 3
Float 256 [_openglThreshold]
Float 264 [_edgeThreshold]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedklmenepdjebadgjickiknmahmnallnmhabaaaaaabmgbaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefccmgaaaaaeaaaaaaaalbiaaaafjaaaaaeegiocaaa
aaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacbdaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaadaaaaaadcaaaaalccaabaaaaaaaaaaaakiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaakccaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaa
dcaaaaapmcaabaaaaaaaaaaakgbobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialpdiaaaaai
pcaabaaaabaaaaaapgapbaaaaaaaaaaaegiocaaaaaaaaaaaaiaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaajaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaakaaaaaaaoaaaaahncaabaaaaaaaaaaaagajbaaaabaaaaaa
pgapbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaigadbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaaaoaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaibcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaaoaaaaaaaaaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaabaaaaaajecaabaaaacaaaaaaegiccaaaaaaaaaaaaoaaaaaaegiccaaa
aaaaaaaaaoaaaaaadiaaaaajicaabaaaacaaaaaabkiacaaaaaaaaaaaadaaaaaa
bkiacaaaaaaaaaaaadaaaaaadcaaaaambcaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaackaabaaaacaaaaaadiaaaaah
bcaabaaaadaaaaaadkaabaaaabaaaaaaakaabaaaadaaaaaadiaaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiaeadcaaaaakccaabaaaacaaaaaa
bkaabaaaacaaaaaabkaabaaaacaaaaaaakaabaiaebaaaaaaadaaaaaabnaaaaah
bcaabaaaadaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaelaaaaafccaabaaa
acaaaaaabkaabaaaacaaaaaadcaaaaalbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaaaeabkaabaiaebaaaaaaacaaaaaaaaaaaaahccaabaaa
acaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaaaoaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaadhaaaaajbcaabaaaacaaaaaaakaabaaa
adaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaialpdbaaaaahccaabaaaacaaaaaa
abeaaaaaaaaaaaaaakaabaaaacaaaaaabnaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaackiacaaaaaaaaaaabaaaaaaadlaaaaafbcaabaaaadaaaaaabkaabaaa
acaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaadaaaaaa
bpaaaeadbkaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaabbfaaaaabdiaaaaahhcaabaaaadaaaaaa
egacbaaaabaaaaaaagaabaaaacaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
elaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadbaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaabaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaacaaaaaabpaaaeadbkaabaaaaaaaaaaadcaaaaakncaabaaa
aaaaaaaaagaabaaaacaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaaoaaaaaa
biaaaaaibcaabaaaabaaaaaadkiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaiadp
bpaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaigadbaaaaaaaaaaa
igadbaaaaaaaaaaaeeaaaaafccaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ocaabaaaabaaaaaaagaobaaaaaaaaaaafgafbaaaabaaaaaaelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaacaaaaaabkiacaaaaaaaaaaa
adaaaaaaabeaaaaaaaaacaebdeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaacaaaaaadiaaaaahncaabaaaadaaaaaaagaabaaaabaaaaaapgajbaaa
abaaaaaadcaaaaalhcaabaaaaeaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaa
egiccaiaebaaaaaaaaaaaaaaaoaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
aeaaaaaaegacbaaaaeaaaaaaeeaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahhcaabaaaafaaaaaaagaabaaaacaaaaaaegacbaaaaeaaaaaabaaaaaah
ccaabaaaacaaaaaaigadbaaaadaaaaaaigadbaaaadaaaaaaelaaaaaficaabaaa
agaaaaaabkaabaaaacaaaaaadiaaaaaiccaabaaaacaaaaaabkiacaaaaaaaaaaa
adaaaaaaabeaaaaaggggggdpdbaaaaahccaabaaaacaaaaaadkaabaaaagaaaaaa
bkaabaaaacaaaaaadcaaaaakccaabaaaadaaaaaadkaabaaaabaaaaaaakaabaaa
abaaaaaabkiacaaaaaaaaaaaadaaaaaabaaaaaahbcaabaaaabaaaaaajgahbaaa
adaaaaaajgahbaaaadaaaaaaelaaaaafccaabaaaagaaaaaaakaabaaaabaaaaaa
dgaaaaaffcaabaaaagaaaaaafgaebaaaadaaaaaadhaaaaajdcaabaaaadaaaaaa
fgafbaaaacaaaaaaegaabaaaagaaaaaaogakbaaaagaaaaaaaoaaaaahncaabaaa
adaaaaaakgadbaaaadaaaaaafgafbaaaadaaaaaabaaaaaaibcaabaaaabaaaaaa
igadbaaaadaaaaaaegiccaaaaaaaaaaaafaaaaaaaoaaaaaiccaabaaaacaaaaaa
bkiacaaaaaaaaaaaadaaaaaabkaabaaaadaaaaaadcaaaaakccaabaaaacaaaaaa
bkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaiadpelaaaaaf
ccaabaaaacaaaaaabkaabaaaacaaaaaadbaaaaaiccaabaaaacaaaaaaakaabaaa
abaaaaaabkaabaiaebaaaaaaacaaaaaaaaaaaaajbcaabaaaadaaaaaabkaabaaa
adaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaaaaaaaaakccaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaadaaaaaackiacaaaaaaaaaaaadaaaaaaaoaaaaah
ecaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaaelaaaaafccaabaaa
agaaaaaackaabaaaadaaaaaaaaaaaaakmcaabaaaagaaaaaaagaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaajkjjbjdomnmmemdodiaaaaakdcaabaaaadaaaaaa
ogakbaaaagaaaaaaaceaaaaajfdbeeebffffffdpaaaaaaaaaaaaaaaaddaaaaai
bcaabaaaabaaaaaaakaabaiaibaaaaaaadaaaaaaabeaaaaaaaaaiadpdeaaaaai
icaabaaaaeaaaaaaakaabaiaibaaaaaaadaaaaaaabeaaaaaaaaaiadpaoaaaaak
icaabaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aeaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaaeaaaaaa
diaaaaahicaabaaaaeaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaaj
icaabaaaafaaaaaadkaabaaaaeaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajicaabaaaafaaaaaadkaabaaaaeaaaaaadkaabaaaafaaaaaaabeaaaaa
ochgdidodcaaaaajicaabaaaafaaaaaadkaabaaaaeaaaaaadkaabaaaafaaaaaa
abeaaaaaaebnkjlodcaaaaajicaabaaaaeaaaaaadkaabaaaaeaaaaaadkaabaaa
afaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaaafaaaaaaakaabaaaabaaaaaa
dkaabaaaaeaaaaaadbaaaaaiecaabaaaagaaaaaaabeaaaaaaaaaiadpakaabaia
ibaaaaaaadaaaaaadcaaaaajicaabaaaafaaaaaadkaabaaaafaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpabaaaaahicaabaaaafaaaaaackaabaaaagaaaaaa
dkaabaaaafaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaa
aeaaaaaadkaabaaaafaaaaaaddaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaiadpdbaaaaaibcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaia
ebaaaaaaadaaaaaadhaaaaakbcaabaaaabaaaaaaakaabaaaadaaaaaaakaabaia
ebaaaaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaagaaaaaaakaabaaa
abaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaaagaaaaaaegaabaaaagaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaa
agaaaaaaegacbaaaagaaaaaapgipcaaaaaaaaaaaafaaaaaadhaaaaamhcaabaaa
agaaaaaafgafbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
egacbaaaagaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaadaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadp
eiaaaaalpcaabaaaadaaaaaajgafbaaaadaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaa
pgipcaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaaadaaaaaaagaabaaaabaaaaaa
egacbaaaadaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaadiaaaaalhcaabaaaahaaaaaajgihcaaaaaaaaaaaanaaaaaaaceaaaaa
aaaacaebaaaacaebaaaacaebaaaaaaaabaaaaaaibcaabaaaabaaaaaaegacbaia
ebaaaaaaafaaaaaajgahbaaaabaaaaaaelaaaaagccaabaaaacaaaaaackiacaaa
aaaaaaaaamaaaaaaaaaaaaaiicaabaaaadaaaaaaakaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaaeaaaaaabkaabaaaacaaaaaaabeaaaaa
nifphimabjaaaaaficaabaaaaeaaaaaadkaabaaaaeaaaaaadiaaaaahicaabaaa
aeaaaaaadkaabaaaaeaaaaaaabeaaaaaaaaakaeacpaaaaaficaabaaaadaaaaaa
dkaabaaaadaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaa
aeaaaaaabjaaaaaficaabaaaadaaaaaadkaabaaaadaaaaaacpaaaaafccaabaaa
acaaaaaabkaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaaaaaamadpbjaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaaj
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaajkjjlfebabeaaaaaaaaaiadp
aoaaaaahccaabaaaacaaaaaadkaabaaaadaaaaaabkaabaaaacaaaaaadcaaaaal
hcaabaaaaeaaaaaaegacbaiaebaaaaaaaeaaaaaaagaabaaaacaaaaaaegiccaaa
aaaaaaaaafaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaa
aeaaaaaaeeaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahhcaabaaa
aeaaaaaaagaabaaaacaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaa
egacbaaaaeaaaaaajgahbaaaabaaaaaadcaaaaakicaabaaaadaaaaaaakaabaia
ebaaaaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpaoaaaaaiicaabaaa
adaaaaaadkaabaaaadaaaaaackiacaaaaaaaaaaaamaaaaaadiaaaaahicaabaaa
adaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaamaaaaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaiadpaoaaaaahbcaabaaaacaaaaaadkaabaaa
adaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
abeaaaaadlkklidpbjaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaaj
icaabaaaadaaaaaaakiacaaaaaaaaaaaacaaaaaackiacaaaaaaaaaaaamaaaaaa
diaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaiaeaaoaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaadaaaaaabaaaaaaiicaabaaa
adaaaaaaegacbaiaebaaaaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaa
adaaaaaadkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaa
aeaaaaaadkaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahbcaabaaaaeaaaaaa
akaabaaaaeaaaaaaakaabaaaaeaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaaakaabaaaaeaaaaaadcaaaaajicaabaaaadaaaaaadkaabaaaadaaaaaa
abeaaaaaeiobhkdpabeaaaaaaknhkddmbaaaaaaiccaabaaaabaaaaaaegiccaaa
aaaaaaaaafaaaaaajgahbaaaabaaaaaadeaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaknhcddmaknhcddmaaaaaaaaaaaaaaaadiaaaaahecaabaaa
abaaaaaaakaabaaaacaaaaaadkaabaaaadaaaaaaaoaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaa
deaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
ocaabaaaabaaaaaafgafbaaaacaaaaaaagajbaaaadaaaaaaaoaaaaaiocaabaaa
abaaaaaafgaobaaaabaaaaaaagiacaaaaaaaaaaaacaaaaaaaaaaaaaibcaabaaa
acaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahhcaabaaa
aeaaaaaaegacbaaaahaaaaaaagaabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaegacbaaaaeaaaaaaaoaaaaaihcaabaaaadaaaaaaegacbaaa
adaaaaaaagiacaaaaaaaaaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaa
abaaaaaaegacbaaaagaaaaaajgahbaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaabaaaaaabcaaaaabdgaaaaaihcaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaabfaaaaabbcaaaaabdgaaaaai
hcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaabfaaaaab
baaaaaahicaabaaaabaaaaaaigadbaaaaaaaaaaaigadbaaaaaaaaaaaelaaaaaf
bcaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaajccaabaaaacaaaaaabkiacaaa
aaaaaaaaadaaaaaaakiacaaaaaaaaaaabaaaaaaadbaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaaigadbaaaaaaaaaaapgapbaaaabaaaaaa
diaaaaahhcaabaaaadaaaaaafgafbaaaacaaaaaaegacbaaaadaaaaaadhaaaaaj
hcaabaaaadaaaaaaagaabaaaacaaaaaaegacbaaaadaaaaaaigadbaaaaaaaaaaa
aaaaaaajncaabaaaaaaaaaaaagajbaaaadaaaaaaagijcaiaebaaaaaaaaaaaaaa
aoaaaaaabaaaaaahicaabaaaabaaaaaaigadbaaaaaaaaaaaigadbaaaaaaaaaaa
elaaaaafbcaabaaaaeaaaaaadkaabaaaabaaaaaaaoaaaaahocaabaaaafaaaaaa
agaobaaaaaaaaaaaagaabaaaaeaaaaaaaaaaaaakbcaabaaaaaaaaaaabkiacaia
ebaaaaaaaaaaaaaaadaaaaaackiacaaaaaaaaaaaadaaaaaadiaaaaaiecaabaaa
aaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaadcaaaaalccaabaaa
agaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaabkiacaaaaaaaaaaa
adaaaaaaaaaaaaaibcaabaaaafaaaaaabkaabaaaafaaaaaaakiacaaaaaaaaaaa
alaaaaaabaaaaaahbcaabaaaaaaaaaaaigadbaaaafaaaaaaigadbaaaafaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaafaaaaaa
agaabaaaaaaaaaaaigadbaaaafaaaaaaelaaaaafecaabaaaacaaaaaackaabaaa
acaaaaaadiaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaa
ggggggdpdbaaaaahbcaabaaaaaaaaaaackaabaaaacaaaaaaakaabaaaaaaaaaaa
aaaaaaajccaabaaaahaaaaaabkiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaa
aoaaaaaaaaaaaaaiccaabaaaaiaaaaaabkaabaaaadaaaaaabkiacaaaaaaaaaaa
adaaaaaadgaaaaagfcaabaaaahaaaaaaagiccaaaaaaaaaaaaoaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaaelaaaaafecaabaaa
aiaaaaaadkaabaaaaaaaaaaadgaaaaafbcaabaaaaiaaaaaabkaabaaaahaaaaaa
dgaaaaagbcaabaaaacaaaaaabkiacaaaaaaaaaaaaoaaaaaadgaaaaafccaabaaa
acaaaaaabkaabaaaadaaaaaadhaaaaajhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaaiaaaaaaegacbaaaacaaaaaadgaaaaagfcaabaaaahaaaaaaagiccaaa
aaaaaaaaaoaaaaaadgaaaaafccaabaaaahaaaaaaakaabaaaacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaahaaaaaaegacbaaaafaaaaaaaoaaaaahecaabaaa
aeaaaaaaakaabaaaaaaaaaaackaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaa
ckaabaaaacaaaaaackaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaabkaabaaaagaaaaaabkaabaaaagaaaaaadkaabaaaaaaaaaaaelaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaa
aaaaaaaadkaabaaaaaaaaaaadbaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaa
akaabaaaaeaaaaaaabaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaaaaaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
aoaaaaahecaabaaaagaaaaaaakaabaaaaaaaaaaabkaabaaaagaaaaaaaaaaaaai
bcaabaaaagaaaaaadkaabaiaebaaaaaaaaaaaaaaakaabaaaaeaaaaaadgaaaaaf
ccaabaaaaeaaaaaackaabaaaacaaaaaadhaaaaajocaabaaaaeaaaaaapgapbaaa
abaaaaaaagajbaaaagaaaaaaagajbaaaaeaaaaaabnaaaaahbcaabaaaaaaaaaaa
bkaabaaaagaaaaaackaabaaaaeaaaaaabpaaaeadakaabaaaaaaaaaaaddaaaaah
bcaabaaaaaaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaiadpdgaaaaaficaabaaa
adaaaaaabkaabaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaiaebaaaaaa
afaaaaaaagaabaaaaaaaaaaamgacbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaahaaaaaadhaaaaajhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaahaaaaaabaaaaaai
bcaabaaaaaaaaaaaegacbaaaafaaaaaaegiccaaaaaaaaaaaafaaaaaabaaaaaai
icaabaaaaaaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaafaaaaaaaoaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaeaaaaaaaaaaaaaiicaabaaa
abaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaabgeedbaaaaahbcaabaaa
acaaaaaackaabaaaaeaaaaaadkaabaaaabaaaaaaaoaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaackaabaaaaeaaaaaadiaaaaahhcaabaaaahaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaaaaaaaaaiicaabaaaahaaaaaabkiacaaaaaaaaaaa
adaaaaaaabeaaaaaaaaabgeedgaaaaaficaabaaaadaaaaaackaabaaaaeaaaaaa
dhaaaaajpcaabaaaadaaaaaaagaabaaaacaaaaaaegaobaaaahaaaaaaegaobaaa
adaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
elaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaabaaaaaahccaabaaaacaaaaaa
egacbaaaadaaaaaaegacbaaaafaaaaaaaoaaaaahecaabaaaacaaaaaabkaabaaa
acaaaaaaakaabaaaacaaaaaabaaaaaaibcaabaaaadaaaaaaegacbaaaadaaaaaa
egiccaaaaaaaaaaaafaaaaaaaoaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
akaabaaaacaaaaaadbaaaaahccaabaaaadaaaaaaabeaaaaaaaaaaaaadkaabaaa
aeaaaaaabpaaaeadbkaabaaaadaaaaaaaaaaaaajccaabaaaadaaaaaadkaabaaa
adaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaaaoaaaaahccaabaaaadaaaaaa
bkaabaaaadaaaaaackaabaaaaaaaaaaaelaaaaafccaabaaaafaaaaaabkaabaaa
adaaaaaaaaaaaaahccaabaaaadaaaaaadkaabaaaaeaaaaaaabeaaaaajkjjbjdo
diaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaajfdbeeebddaaaaai
ecaabaaaadaaaaaabkaabaiaibaaaaaaadaaaaaaabeaaaaaaaaaiadpdeaaaaai
ecaabaaaaeaaaaaabkaabaiaibaaaaaaadaaaaaaabeaaaaaaaaaiadpaoaaaaak
ecaabaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaa
aeaaaaaadiaaaaahecaabaaaadaaaaaackaabaaaadaaaaaackaabaaaaeaaaaaa
diaaaaahecaabaaaaeaaaaaackaabaaaadaaaaaackaabaaaadaaaaaadcaaaaaj
ecaabaaaafaaaaaackaabaaaaeaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajecaabaaaafaaaaaackaabaaaaeaaaaaackaabaaaafaaaaaaabeaaaaa
ochgdidodcaaaaajecaabaaaafaaaaaackaabaaaaeaaaaaackaabaaaafaaaaaa
abeaaaaaaebnkjlodcaaaaajecaabaaaaeaaaaaackaabaaaaeaaaaaackaabaaa
afaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaafaaaaaackaabaaaadaaaaaa
ckaabaaaaeaaaaaadbaaaaaiicaabaaaafaaaaaaabeaaaaaaaaaiadpbkaabaia
ibaaaaaaadaaaaaadcaaaaajecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpabaaaaahecaabaaaafaaaaaadkaabaaaafaaaaaa
ckaabaaaafaaaaaadcaaaaajecaabaaaadaaaaaackaabaaaadaaaaaackaabaaa
aeaaaaaackaabaaaafaaaaaaddaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaa
abeaaaaaaaaaiadpdbaaaaaiccaabaaaadaaaaaabkaabaaaadaaaaaabkaabaia
ebaaaaaaadaaaaaadhaaaaakccaabaaaadaaaaaabkaabaaaadaaaaaackaabaia
ebaaaaaaadaaaaaackaabaaaadaaaaaadiaaaaahbcaabaaaafaaaaaabkaabaaa
adaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaaafaaaaaaegaabaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaajccaabaaa
adaaaaaaakaabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaaaoaaaaah
ccaabaaaadaaaaaabkaabaaaadaaaaaackaabaaaaaaaaaaaelaaaaafccaabaaa
ahaaaaaabkaabaaaadaaaaaaaaaaaaahccaabaaaadaaaaaackaabaaaacaaaaaa
abeaaaaajkjjbjdodiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
jfdbeeebddaaaaaiecaabaaaadaaaaaabkaabaiaibaaaaaaadaaaaaaabeaaaaa
aaaaiadpdeaaaaaiecaabaaaaeaaaaaabkaabaiaibaaaaaaadaaaaaaabeaaaaa
aaaaiadpaoaaaaakecaabaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpckaabaaaaeaaaaaadiaaaaahecaabaaaadaaaaaackaabaaaadaaaaaa
ckaabaaaaeaaaaaadiaaaaahecaabaaaaeaaaaaackaabaaaadaaaaaackaabaaa
adaaaaaadcaaaaajicaabaaaafaaaaaackaabaaaaeaaaaaaabeaaaaafpkokkdm
abeaaaaadgfkkolndcaaaaajicaabaaaafaaaaaackaabaaaaeaaaaaadkaabaaa
afaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaafaaaaaackaabaaaaeaaaaaa
dkaabaaaafaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaaeaaaaaackaabaaa
aeaaaaaadkaabaaaafaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaaafaaaaaa
ckaabaaaadaaaaaackaabaaaaeaaaaaadbaaaaaibcaabaaaagaaaaaaabeaaaaa
aaaaiadpbkaabaiaibaaaaaaadaaaaaadcaaaaajicaabaaaafaaaaaadkaabaaa
afaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahicaabaaaafaaaaaa
akaabaaaagaaaaaadkaabaaaafaaaaaadcaaaaajecaabaaaadaaaaaackaabaaa
adaaaaaackaabaaaaeaaaaaadkaabaaaafaaaaaaddaaaaahccaabaaaadaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaaadaaaaaabkaabaaa
adaaaaaabkaabaiaebaaaaaaadaaaaaadhaaaaakccaabaaaadaaaaaabkaabaaa
adaaaaaackaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadiaaaaahbcaabaaa
ahaaaaaabkaabaaaadaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaaahaaaaaa
egaabaaaahaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
aoaaaaahhcaabaaaafaaaaaaegacbaaaafaaaaaaegacbaaaahaaaaaaddaaaaak
hcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaabcaaaaabaaaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaia
ebaaaaaaaaaaaaaaadaaaaaaaoaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
ckaabaaaaaaaaaaaelaaaaafccaabaaaahaaaaaaakaabaaaacaaaaaaaaaaaaai
bcaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaaabeaaaaajkjjbjdodiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaajfdbeeebddaaaaaiecaabaaa
acaaaaaaakaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadpdeaaaaaiccaabaaa
adaaaaaaakaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadpaoaaaaakccaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaa
diaaaaahecaabaaaacaaaaaackaabaaaacaaaaaabkaabaaaadaaaaaadiaaaaah
ccaabaaaadaaaaaackaabaaaacaaaaaackaabaaaacaaaaaadcaaaaajecaabaaa
adaaaaaabkaabaaaadaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ecaabaaaadaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaaochgdido
dcaaaaajecaabaaaadaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaa
aebnkjlodcaaaaajccaabaaaadaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaa
abeaaaaadiphhpdpdiaaaaahecaabaaaadaaaaaackaabaaaacaaaaaabkaabaaa
adaaaaaadbaaaaaiecaabaaaaeaaaaaaabeaaaaaaaaaiadpakaabaiaibaaaaaa
acaaaaaadcaaaaajecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpabaaaaahecaabaaaadaaaaaackaabaaaaeaaaaaackaabaaa
adaaaaaadcaaaaajecaabaaaacaaaaaackaabaaaacaaaaaabkaabaaaadaaaaaa
ckaabaaaadaaaaaaddaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiadpdbaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaadhaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaaahaaaaaaakaabaaaacaaaaaa
abeaaaaaklkkckdpeiaaaaalpcaabaaaahaaaaaaegaabaaaahaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaajbcaabaaaacaaaaaa
dkaabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaaaoaaaaahecaabaaa
aaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaaelaaaaafccaabaaaaiaaaaaa
ckaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaaaeaaaaaa
abeaaaaajkjjbjdodiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
jfdbeeebddaaaaaibcaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdeaaaaaiecaabaaaacaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
aaaaiadpaoaaaaakecaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpckaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahecaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaadcaaaaajccaabaaaadaaaaaackaabaaaacaaaaaaabeaaaaafpkokkdm
abeaaaaadgfkkolndcaaaaajccaabaaaadaaaaaackaabaaaacaaaaaabkaabaaa
adaaaaaaabeaaaaaochgdidodcaaaaajccaabaaaadaaaaaackaabaaaacaaaaaa
bkaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaacaaaaaackaabaaa
acaaaaaabkaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaahccaabaaaadaaaaaa
ckaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaiecaabaaaadaaaaaaabeaaaaa
aaaaiadpckaabaiaibaaaaaaaaaaaaaadcaaaaajccaabaaaadaaaaaabkaabaaa
adaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahccaabaaaadaaaaaa
ckaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaa
acaaaaaackaabaaaacaaaaaabkaabaaaadaaaaaaddaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadhaaaaakecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaa
aiaaaaaackaabaaaaaaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaaaiaaaaaa
egaabaaaaiaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
aoaaaaahncaabaaaagaaaaaaagajbaaaahaaaaaaagajbaaaaiaaaaaaddaaaaak
hcaabaaaafaaaaaaigadbaaaagaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaabfaaaaabaoaaaaaiecaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaa
dkaabaaaadaaaaaadcaaaaakecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaaaeaaaaaa
dbaaaaaiecaabaaaacaaaaaaakaabaiaibaaaaaaacaaaaaaabeaaaaagpbciddl
bpaaaeadckaabaaaacaaaaaaaaaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
abeaaaaagpbciddldiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
pppppjecaaaaaaalgcaabaaaadaaaaaakgakbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaaaaagpbcidllgpbciddlaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaa
adaaaaaadkaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaabkaabaaaaeaaaaaa
bkaabaaaaeaaaaaackaabaaaaaaaaaaaapaaaaahecaabaaaaeaaaaaafgafbaaa
aeaaaaaapgapbaaaadaaaaaadcaaaaajfcaabaaaagaaaaaakgakbaaaaeaaaaaa
fgagbaaaadaaaaaakgakbaaaacaaaaaaelaaaaaffcaabaaaagaaaaaaagacbaaa
agaaaaaadiaaaaahdcaabaaaahaaaaaajgafbaaaadaaaaaapgapbaaaadaaaaaa
dcaaaaajgcaabaaaadaaaaaapgapbaaaadaaaaaafgagbaaaadaaaaaafgafbaaa
aeaaaaaadcaaaaakecaabaaaacaaaaaabkaabaaaagaaaaaabkaabaaaagaaaaaa
dkaabaiaebaaaaaaacaaaaaaelaaaaafecaabaaaaiaaaaaackaabaaaacaaaaaa
dcaaaaakecaabaaaacaaaaaadkaabaaaadaaaaaadkaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaaelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaadcaaaaak
gcaabaaaaeaaaaaaagabbaaaahaaaaaaagabbaaaahaaaaaakgakbaiaebaaaaaa
aaaaaaaadcaaaaalgcaabaaaaeaaaaaafgifcaaaaaaaaaaaadaaaaaafgifcaaa
aaaaaaaaadaaaaaafgagbaaaaeaaaaaadbaaaaakmcaabaaaahaaaaaaagaebaaa
ahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadbaaaaakdcaabaaa
ajaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaajgafbaaaaeaaaaaa
abaaaaahmcaabaaaahaaaaaakgaobaaaahaaaaaaagaebaaaajaaaaaaaoaaaaal
hcaabaaaajaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaabgigcaaa
aaaaaaaaaeaaaaaaaaaaaaaiicaabaaaakaaaaaaakaabaiaebaaaaaaajaaaaaa
abeaaaaaaaaaaadpdiaaaaahccaabaaaaiaaaaaackaabaaaaiaaaaaackaabaaa
aiaaaaaaaaaaaaahicaabaaaaiaaaaaaakaabaaaajaaaaaaabeaaaaaaaaaaadp
dgaaaaaihcaabaaaakaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaafbcaabaaaaiaaaaaaabeaaaaaaaaaialpdhaaaaajpcaabaaaalaaaaaa
kgakbaaaahaaaaaaigaobaaaakaaaaaaegaobaaaaiaaaaaaaoaaaaahecaabaaa
aaaaaaaackaabaaaacaaaaaackaabaaaaiaaaaaaaoaaaaalhcaabaaaamaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiccaaaaaaaaaaaaeaaaaaa
aaaaaaalhcaabaaaamaaaaaaegacbaiaebaaaaaaamaaaaaaaceaaaaaaaaaiadp
aaaaaadpaaaaiadpaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaamaaaaaabkaabaaaajaaaaaaaaaaaaahccaabaaaaeaaaaaabkaabaaa
aeaaaaaabkaabaaaalaaaaaaelaaaaafccaabaaaaeaaaaaabkaabaaaaeaaaaaa
dcaaaaajccaabaaaaeaaaaaaakaabaaaahaaaaaaakaabaaaalaaaaaabkaabaaa
aeaaaaaaaaaaaaahicaabaaaafaaaaaackaabaaaacaaaaaackaabaaaalaaaaaa
aoaaaaahccaabaaaaeaaaaaabkaabaaaaeaaaaaadkaabaaaafaaaaaadcaaaaaj
ccaabaaaaeaaaaaabkaabaaaaeaaaaaabkaabaaaamaaaaaadkaabaaaalaaaaaa
deaaaaahicaabaaaafaaaaaadkaabaaaaaaaaaaaabeaaaaahbdneklodiaaaaah
icaabaaaafaaaaaadkaabaaaafaaaaaaabeaaaaabodakleaddaaaaaiicaabaaa
agaaaaaadkaabaiaibaaaaaaafaaaaaaabeaaaaaaaaaiadpdeaaaaaibcaabaaa
ahaaaaaadkaabaiaibaaaaaaafaaaaaaabeaaaaaaaaaiadpaoaaaaakbcaabaaa
ahaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaahaaaaaa
diaaaaahicaabaaaagaaaaaadkaabaaaagaaaaaaakaabaaaahaaaaaadiaaaaah
bcaabaaaahaaaaaadkaabaaaagaaaaaadkaabaaaagaaaaaadcaaaaajecaabaaa
ahaaaaaaakaabaaaahaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ecaabaaaahaaaaaaakaabaaaahaaaaaackaabaaaahaaaaaaabeaaaaaochgdido
dcaaaaajecaabaaaahaaaaaaakaabaaaahaaaaaackaabaaaahaaaaaaabeaaaaa
aebnkjlodcaaaaajbcaabaaaahaaaaaaakaabaaaahaaaaaackaabaaaahaaaaaa
abeaaaaadiphhpdpdiaaaaahecaabaaaahaaaaaadkaabaaaagaaaaaaakaabaaa
ahaaaaaadbaaaaaibcaabaaaajaaaaaaabeaaaaaaaaaiadpdkaabaiaibaaaaaa
afaaaaaadcaaaaajecaabaaaahaaaaaackaabaaaahaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpabaaaaahecaabaaaahaaaaaaakaabaaaajaaaaaackaabaaa
ahaaaaaadcaaaaajicaabaaaagaaaaaadkaabaaaagaaaaaaakaabaaaahaaaaaa
ckaabaaaahaaaaaaddaaaaahicaabaaaafaaaaaadkaabaaaafaaaaaaabeaaaaa
aaaaiadpdbaaaaaiicaabaaaafaaaaaadkaabaaaafaaaaaadkaabaiaebaaaaaa
afaaaaaadhaaaaakicaabaaaafaaaaaadkaabaaaafaaaaaadkaabaiaebaaaaaa
agaaaaaadkaabaaaagaaaaaadcaaaaajicaabaaaafaaaaaadkaabaaaafaaaaaa
abeaaaaacolkgidpabeaaaaakehadndpdiaaaaahicaabaaaafaaaaaadkaabaaa
afaaaaaaabeaaaaaaaaaaadpdcaaaaajicaabaaaafaaaaaadkaabaaaafaaaaaa
ckaabaaaamaaaaaackaabaaaajaaaaaaaaaaaaahicaabaaaagaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaagaaaaaadkaabaaaagaaaaaa
abeaaaaaaaaaaadpaaaaaaaibcaabaaaahaaaaaadkiacaaaaaaaaaaaaeaaaaaa
abeaaaaaaaaaialpdiaaaaahecaabaaaahaaaaaadkaabaaaagaaaaaaakaabaaa
ahaaaaaaebaaaaafecaabaaaahaaaaaackaabaaaahaaaaaadcaaaaakicaabaaa
agaaaaaadkaabaaaagaaaaaaakaabaaaahaaaaaackaabaiaebaaaaaaahaaaaaa
diaaaaaibcaabaaaahaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaa
abeaaaaaaaaaialpebaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaaebaaaaaf
bcaabaaaajaaaaaaakaabaaaahaaaaaaaoaaaaaibcaabaaaajaaaaaaakaabaaa
ajaaaaaaakiacaaaaaaaaaaaaeaaaaaabkaaaaafbcaabaaaahaaaaaaakaabaaa
ahaaaaaaaaaaaaahicaabaaaafaaaaaadkaabaaaafaaaaaackaabaaaahaaaaaa
aoaaaaaiccaabaaaalaaaaaadkaabaaaafaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaaiccaabaaaaeaaaaaabkaabaaaaeaaaaaaakiacaaaaaaaaaaaaeaaaaaa
aaaaaaahbcaabaaaalaaaaaackaabaaaaaaaaaaabkaabaaaaeaaaaaaeiaaaaal
pcaabaaaanaaaaaabgafbaaaalaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaajaaaaaadkaabaiaebaaaaaaagaaaaaa
abeaaaaaaaaaiadpaaaaaaahicaabaaaafaaaaaadkaabaaaafaaaaaaabeaaaaa
aaaaiadpaoaaaaaiecaabaaaalaaaaaadkaabaaaafaaaaaadkiacaaaaaaaaaaa
aeaaaaaaeiaaaaalpcaabaaaaoaaaaaacgakbaaaalaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaaoaaaaaapgapbaaa
agaaaaaaegaobaaaaoaaaaaadcaaaaajpcaabaaaanaaaaaaegaobaaaanaaaaaa
pgapbaaaajaaaaaaegaobaaaaoaaaaaaaaaaaaahicaabaaaalaaaaaaakaabaaa
ajaaaaaabkaabaaaaeaaaaaaeiaaaaalpcaabaaaaoaaaaaangafbaaaalaaaaaa
eghobaaaadaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaa
apaaaaaaogakbaaaalaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaahpcaabaaaapaaaaaapgapbaaaagaaaaaaegaobaaaapaaaaaa
dcaaaaajpcaabaaaaoaaaaaaegaobaaaaoaaaaaapgapbaaaajaaaaaaegaobaaa
apaaaaaaaaaaaaaiccaabaaaaeaaaaaaakaabaiaebaaaaaaahaaaaaaabeaaaaa
aaaaiadpdiaaaaahpcaabaaaaoaaaaaaagaabaaaahaaaaaaegaobaaaaoaaaaaa
dcaaaaajpcaabaaaanaaaaaaegaobaaaanaaaaaafgafbaaaaeaaaaaaegaobaaa
aoaaaaaadiaaaaahdcaabaaaaoaaaaaaigaabaaaagaaaaaaigaabaaaagaaaaaa
dcaaaaakfcaabaaaagaaaaaaagacbaaaagaaaaaaagacbaaaagaaaaaapgapbaia
ebaaaaaaacaaaaaaelaaaaaffcaabaaaagaaaaaaagacbaaaagaaaaaadcaaaaak
dcaabaaaaoaaaaaajgafbaaaadaaaaaajgafbaaaadaaaaaaegaabaiaebaaaaaa
aoaaaaaadcaaaaaldcaabaaaaoaaaaaafgifcaaaaaaaaaaaadaaaaaafgifcaaa
aaaaaaaaadaaaaaaegaabaaaaoaaaaaadbaaaaakmcaabaaaaoaaaaaafgajbaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadbaaaaakdcaabaaa
apaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegaabaaaaoaaaaaa
abaaaaahmcaabaaaaoaaaaaakgaobaaaaoaaaaaaagaebaaaapaaaaaadhaaaaaj
pcaabaaaapaaaaaakgakbaaaaoaaaaaaigaobaaaakaaaaaaegaobaaaaiaaaaaa
aoaaaaahdcaabaaabaaaaaaaigaabaaaagaaaaaakgakbaaaaiaaaaaadcaaaaaj
jcaabaaaamaaaaaaagaebaaabaaaaaaaagaabaaaamaaaaaafgafbaaaajaaaaaa
aaaaaaahicaabaaaafaaaaaaakaabaaaaoaaaaaabkaabaaaapaaaaaaelaaaaaf
icaabaaaafaaaaaadkaabaaaafaaaaaadcaaaaajccaabaaaadaaaaaabkaabaaa
adaaaaaaakaabaaaapaaaaaadkaabaaaafaaaaaaaaaaaaahicaabaaaafaaaaaa
akaabaaaagaaaaaackaabaaaapaaaaaaaoaaaaahccaabaaaadaaaaaabkaabaaa
adaaaaaadkaabaaaafaaaaaadcaaaaajccaabaaaadaaaaaabkaabaaaadaaaaaa
bkaabaaaamaaaaaadkaabaaaapaaaaaadeaaaaahicaabaaaafaaaaaaakaabaaa
adaaaaaaabeaaaaahbdneklodiaaaaahicaabaaaafaaaaaadkaabaaaafaaaaaa
abeaaaaabodakleaddaaaaaibcaabaaaagaaaaaadkaabaiaibaaaaaaafaaaaaa
abeaaaaaaaaaiadpdeaaaaaiccaabaaaajaaaaaadkaabaiaibaaaaaaafaaaaaa
abeaaaaaaaaaiadpaoaaaaakccaabaaaajaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaajaaaaaadiaaaaahbcaabaaaagaaaaaaakaabaaa
agaaaaaabkaabaaaajaaaaaadiaaaaahccaabaaaajaaaaaaakaabaaaagaaaaaa
akaabaaaagaaaaaadcaaaaajbcaabaaaaoaaaaaabkaabaaaajaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaaoaaaaaabkaabaaaajaaaaaa
akaabaaaaoaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaaoaaaaaabkaabaaa
ajaaaaaaakaabaaaaoaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaaajaaaaaa
bkaabaaaajaaaaaaakaabaaaaoaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaa
aoaaaaaaakaabaaaagaaaaaabkaabaaaajaaaaaadbaaaaaiecaabaaaaoaaaaaa
abeaaaaaaaaaiadpdkaabaiaibaaaaaaafaaaaaadcaaaaajbcaabaaaaoaaaaaa
akaabaaaaoaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahbcaabaaa
aoaaaaaackaabaaaaoaaaaaaakaabaaaaoaaaaaadcaaaaajbcaabaaaagaaaaaa
akaabaaaagaaaaaabkaabaaaajaaaaaaakaabaaaaoaaaaaaddaaaaahicaabaaa
afaaaaaadkaabaaaafaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaaafaaaaaa
dkaabaaaafaaaaaadkaabaiaebaaaaaaafaaaaaadhaaaaakicaabaaaafaaaaaa
dkaabaaaafaaaaaaakaabaiaebaaaaaaagaaaaaaakaabaaaagaaaaaadcaaaaaj
icaabaaaafaaaaaadkaabaaaafaaaaaaabeaaaaacolkgidpabeaaaaakehadndp
diaaaaahicaabaaaafaaaaaackaabaaaamaaaaaadkaabaaaafaaaaaadcaaaaaj
icaabaaaafaaaaaadkaabaaaafaaaaaaabeaaaaaaaaaaadpckaabaaaajaaaaaa
diaaaaaigcaabaaaajaaaaaaagadbaaaamaaaaaaagiacaaaaaaaaaaaaeaaaaaa
dcaaaaanfcaabaaaamaaaaaaagadbaaaamaaaaaaagiacaaaaaaaaaaaaeaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaebaaaaaffcaabaaaamaaaaaa
agacbaaaamaaaaaaaoaaaaaifcaabaaaamaaaaaaagacbaaaamaaaaaaagiacaaa
aaaaaaaaaeaaaaaaebaaaaaffcaabaaaaoaaaaaafgagbaaaajaaaaaaaoaaaaai
fcaabaaaaoaaaaaaagacbaaaaoaaaaaaagiacaaaaaaaaaaaaeaaaaaabkaaaaaf
gcaabaaaajaaaaaafgagbaaaajaaaaaaaaaaaaahicaabaaaafaaaaaadkaabaaa
afaaaaaackaabaaaahaaaaaaaoaaaaaiccaabaaaapaaaaaadkaabaaaafaaaaaa
dkiacaaaaaaaaaaaaeaaaaaaaoaaaaaiccaabaaaadaaaaaabkaabaaaadaaaaaa
akiacaaaaaaaaaaaaeaaaaaaaaaaaaahbcaabaaaapaaaaaaakaabaaaamaaaaaa
bkaabaaaadaaaaaaeiaaaaalpcaabaaabaaaaaaabgafbaaaapaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahicaabaaaafaaaaaa
dkaabaaaafaaaaaaabeaaaaaaaaaiadpaoaaaaaiecaabaaaapaaaaaadkaabaaa
afaaaaaadkiacaaaaaaaaaaaaeaaaaaaeiaaaaalpcaabaaabbaaaaaacgakbaaa
apaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
pcaabaaabbaaaaaapgapbaaaagaaaaaaegaobaaabbaaaaaadcaaaaajpcaabaaa
baaaaaaaegaobaaabaaaaaaapgapbaaaajaaaaaaegaobaaabbaaaaaaaaaaaaah
icaabaaaapaaaaaaakaabaaaaoaaaaaabkaabaaaadaaaaaaeiaaaaalpcaabaaa
bbaaaaaangafbaaaapaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaaeiaaaaalpcaabaaabcaaaaaaogakbaaaapaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaabcaaaaaapgapbaaa
agaaaaaaegaobaaabcaaaaaadcaaaaajpcaabaaabbaaaaaaegaobaaabbaaaaaa
pgapbaaaajaaaaaaegaobaaabcaaaaaaaaaaaaaljcaabaaaamaaaaaafgajbaia
ebaaaaaaajaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaiadpdiaaaaah
pcaabaaabbaaaaaafgafbaaaajaaaaaaegaobaaabbaaaaaadcaaaaajpcaabaaa
baaaaaaaegaobaaabaaaaaaaagaabaaaamaaaaaaegaobaaabbaaaaaadcaaaaak
pcaabaaaanaaaaaaegaobaiaebaaaaaabaaaaaaaegacbaaaafaaaaaaegaobaaa
anaaaaaadeaaaaakpcaabaaaanaaaaaaegaobaaaanaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadhaaaaajpcaabaaabaaaaaaapgapbaaaahaaaaaa
igaobaaaakaaaaaaegaobaaaaiaaaaaaaaaaaaahccaabaaaadaaaaaackaabaaa
aeaaaaaabkaabaaabaaaaaaaelaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaabkaabaaaahaaaaaaakaabaaabaaaaaaabkaabaaa
adaaaaaaaaaaaaahecaabaaaacaaaaaackaabaaaacaaaaaackaabaaabaaaaaaa
aoaaaaahecaabaaaacaaaaaabkaabaaaadaaaaaackaabaaaacaaaaaadcaaaaaj
ecaabaaaacaaaaaackaabaaaacaaaaaabkaabaaaamaaaaaadkaabaaabaaaaaaa
aoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaaeaaaaaa
aaaaaaahbcaabaaaalaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaeiaaaaal
pcaabaaabaaaaaaabgafbaaaalaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaaeiaaaaalpcaabaaabbaaaaaacgakbaaaalaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaabbaaaaaa
pgapbaaaagaaaaaaegaobaaabbaaaaaadcaaaaajpcaabaaabaaaaaaaegaobaaa
baaaaaaapgapbaaaajaaaaaaegaobaaabbaaaaaaaaaaaaahicaabaaaalaaaaaa
akaabaaaajaaaaaackaabaaaacaaaaaaeiaaaaalpcaabaaabbaaaaaangafbaaa
alaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaal
pcaabaaaalaaaaaaogakbaaaalaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaalaaaaaapgapbaaaagaaaaaaegaobaaa
alaaaaaadcaaaaajpcaabaaaalaaaaaaegaobaaabbaaaaaapgapbaaaajaaaaaa
egaobaaaalaaaaaadiaaaaahpcaabaaaahaaaaaaagaabaaaahaaaaaaegaobaaa
alaaaaaadcaaaaajpcaabaaaahaaaaaaegaobaaabaaaaaaafgafbaaaaeaaaaaa
egaobaaaahaaaaaadhaaaaajpcaabaaaaiaaaaaapgapbaaaaoaaaaaaegaobaaa
akaaaaaaegaobaaaaiaaaaaaaaaaaaahecaabaaaaaaaaaaabkaabaaaaiaaaaaa
bkaabaaaaoaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaadaaaaaaakaabaaaaiaaaaaackaabaaaaaaaaaaa
aaaaaaahecaabaaaacaaaaaackaabaaaagaaaaaackaabaaaaiaaaaaaaoaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaamaaaaaadkaabaaaaiaaaaaaaoaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaaaaaaaaah
bcaabaaaapaaaaaackaabaaaamaaaaaackaabaaaaaaaaaaaeiaaaaalpcaabaaa
aiaaaaaabgafbaaaapaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaaeiaaaaalpcaabaaaakaaaaaacgakbaaaapaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaakaaaaaapgapbaaa
agaaaaaaegaobaaaakaaaaaadcaaaaajpcaabaaaaiaaaaaaegaobaaaaiaaaaaa
pgapbaaaajaaaaaaegaobaaaakaaaaaaaaaaaaahicaabaaaapaaaaaackaabaaa
aoaaaaaackaabaaaaaaaaaaaeiaaaaalpcaabaaaakaaaaaangafbaaaapaaaaaa
eghobaaaadaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaa
alaaaaaaogakbaaaapaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadiaaaaahpcaabaaaalaaaaaapgapbaaaagaaaaaaegaobaaaalaaaaaa
dcaaaaajpcaabaaaakaaaaaaegaobaaaakaaaaaapgapbaaaajaaaaaaegaobaaa
alaaaaaadiaaaaahpcaabaaaajaaaaaakgakbaaaajaaaaaaegaobaaaakaaaaaa
dcaaaaajpcaabaaaaiaaaaaaegaobaaaaiaaaaaapgapbaaaamaaaaaaegaobaaa
ajaaaaaadcaaaaakpcaabaaaahaaaaaaegaobaiaebaaaaaaaiaaaaaaegacbaaa
afaaaaaaegaobaaaahaaaaaadeaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaipcaabaaaahaaaaaa
egaobaiaebaaaaaaanaaaaaaegaobaaaahaaaaaadcaaaaajpcaabaaaahaaaaaa
agaabaaaacaaaaaaegaobaaaahaaaaaaegaobaaaanaaaaaabcaaaaabdcaaaaak
ecaabaaaaaaaaaaabkaabaaaagaaaaaabkaabaaaagaaaaaadkaabaiaebaaaaaa
acaaaaaaelaaaaafecaabaaaagaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaadkaabaaaadaaaaaadkaabaaaadaaaaaadcaaaaakbcaabaaaacaaaaaa
dkaabaaaadaaaaaadkaabaaaadaaaaaadkaabaiaebaaaaaaacaaaaaaelaaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaa
aeaaaaaadkaabaaaadaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaacaaaaaa
ckaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaadcaaaaalecaabaaaaaaaaaaa
bkiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaackaabaaaaaaaaaaa
dbaaaaahicaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaaaaadbaaaaah
ccaabaaaadaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaaabaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaabkaabaaaadaaaaaaaoaaaaalocaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaadpfgiicaaaaaaaaaaaaeaaaaaa
aaaaaaaiicaabaaaaiaaaaaabkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaaadp
diaaaaahccaabaaaagaaaaaackaabaaaagaaaaaackaabaaaagaaaaaaaaaaaaah
icaabaaaagaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaadpdgaaaaaihcaabaaa
aiaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaadgaaaaafbcaabaaa
agaaaaaaabeaaaaaaaaaialpdhaaaaajpcaabaaaajaaaaaapgapbaaaacaaaaaa
igaobaaaaiaaaaaaegaobaaaagaaaaaaaoaaaaahicaabaaaacaaaaaaakaabaaa
acaaaaaackaabaaaagaaaaaaaoaaaaalocaabaaaaeaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpagijcaaaaaaaaaaaaeaaaaaaaaaaaaalocaabaaa
aeaaaaaafgaobaiaebaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaadp
aaaaiadpdcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaabkaabaaaaeaaaaaa
ckaabaaaadaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
ajaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaaaaaaaaaaaaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaackaabaaaajaaaaaaaoaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaeaaaaaadkaabaaaajaaaaaadeaaaaahbcaabaaa
acaaaaaadkaabaaaaaaaaaaaabeaaaaahbdneklodiaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaabodakleaddaaaaaiecaabaaaacaaaaaaakaabaia
ibaaaaaaacaaaaaaabeaaaaaaaaaiadpdeaaaaaiccaabaaaadaaaaaaakaabaia
ibaaaaaaacaaaaaaabeaaaaaaaaaiadpaoaaaaakccaabaaaadaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaadiaaaaahecaabaaa
acaaaaaackaabaaaacaaaaaabkaabaaaadaaaaaadiaaaaahccaabaaaadaaaaaa
ckaabaaaacaaaaaackaabaaaacaaaaaadcaaaaajicaabaaaafaaaaaabkaabaaa
adaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaaafaaaaaa
bkaabaaaadaaaaaadkaabaaaafaaaaaaabeaaaaaochgdidodcaaaaajicaabaaa
afaaaaaabkaabaaaadaaaaaadkaabaaaafaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaadaaaaaabkaabaaaadaaaaaadkaabaaaafaaaaaaabeaaaaadiphhpdp
diaaaaahicaabaaaafaaaaaackaabaaaacaaaaaabkaabaaaadaaaaaadbaaaaai
bcaabaaaajaaaaaaabeaaaaaaaaaiadpakaabaiaibaaaaaaacaaaaaadcaaaaaj
icaabaaaafaaaaaadkaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
abaaaaahicaabaaaafaaaaaaakaabaaaajaaaaaadkaabaaaafaaaaaadcaaaaaj
ecaabaaaacaaaaaackaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaaafaaaaaa
ddaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpdbaaaaai
bcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaadhaaaaak
bcaabaaaacaaaaaaakaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaacolkgidp
abeaaaaakehadndpdiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaaadpdcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaaeaaaaaa
dkaabaaaadaaaaaaaaaaaaahecaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaaadp
aaaaaaaiccaabaaaadaaaaaadkiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaialp
diaaaaahicaabaaaafaaaaaackaabaaaacaaaaaabkaabaaaadaaaaaaebaaaaaf
icaabaaaafaaaaaadkaabaaaafaaaaaadcaaaaakecaabaaaacaaaaaackaabaaa
acaaaaaabkaabaaaadaaaaaadkaabaiaebaaaaaaafaaaaaadiaaaaaiccaabaaa
adaaaaaadkaabaaaacaaaaaaakiacaaaaaaaaaaaaeaaaaaadcaaaaakicaabaaa
acaaaaaadkaabaaaacaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaialp
ebaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaaaoaaaaaiicaabaaaacaaaaaa
dkaabaaaacaaaaaaakiacaaaaaaaaaaaaeaaaaaaebaaaaafbcaabaaaajaaaaaa
bkaabaaaadaaaaaaaoaaaaaibcaabaaaajaaaaaaakaabaaaajaaaaaaakiacaaa
aaaaaaaaaeaaaaaabkaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaaaaaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaafaaaaaaaoaaaaaiccaabaaa
akaaaaaaakaabaaaacaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaaaaaaaaahecaabaaa
akaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaa
jgafbaaaakaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiicaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadp
aaaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpaoaaaaai
bcaabaaaakaaaaaaakaabaaaacaaaaaadkiacaaaaaaaaaaaaeaaaaaaeiaaaaal
pcaabaaaamaaaaaaigaabaaaakaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaamaaaaaakgakbaaaacaaaaaaegaobaaa
amaaaaaadcaaaaajpcaabaaaalaaaaaaegaobaaaalaaaaaapgapbaaaacaaaaaa
egaobaaaamaaaaaaaaaaaaahicaabaaaakaaaaaaakaabaaaajaaaaaackaabaaa
aaaaaaaaeiaaaaalpcaabaaaajaaaaaangafbaaaakaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaakaaaaaamgaabaaa
akaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
pcaabaaaakaaaaaakgakbaaaacaaaaaaegaobaaaakaaaaaadcaaaaajpcaabaaa
ajaaaaaaegaobaaaajaaaaaapgapbaaaacaaaaaaegaobaaaakaaaaaaaaaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaah
pcaabaaaajaaaaaafgafbaaaadaaaaaaegaobaaaajaaaaaadcaaaaajpcaabaaa
ajaaaaaaegaobaaaalaaaaaakgakbaaaaaaaaaaaegaobaaaajaaaaaadcaaaaam
ecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaa
adaaaaaadkaabaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaakicaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadkaabaia
ebaaaaaaabaaaaaadcaaaaalicaabaaaabaaaaaabkiacaaaaaaaaaaaadaaaaaa
bkiacaaaaaaaaaaaadaaaaaadkaabaaaabaaaaaadbaaaaahbcaabaaaacaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaaaadbaaaaahccaabaaaadaaaaaaabeaaaaa
aaaaaaaadkaabaaaabaaaaaaabaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
bkaabaaaadaaaaaadhaaaaajpcaabaaaaiaaaaaaagaabaaaacaaaaaaegaobaaa
aiaaaaaaegaobaaaagaaaaaaaoaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaa
ckaabaaaagaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaa
aeaaaaaackaabaaaadaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
bkaabaaaaiaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaabkaabaaaacaaaaaaakaabaaaaiaaaaaadkaabaaaabaaaaaa
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaiaaaaaaaoaaaaah
ecaabaaaaaaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaeaaaaaadkaabaaaaiaaaaaadeaaaaah
icaabaaaabaaaaaaakaabaaaadaaaaaaabeaaaaahbdneklodiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaabodakleaddaaaaaiccaabaaaacaaaaaa
dkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdeaaaaaibcaabaaaadaaaaaa
dkaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpaoaaaaakbcaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaadiaaaaah
ccaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaahbcaabaaa
adaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaajccaabaaaadaaaaaa
akaabaaaadaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajccaabaaa
adaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaochgdidodcaaaaaj
ccaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaebnkjlo
dcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
diphhpdpdiaaaaahccaabaaaadaaaaaabkaabaaaacaaaaaaakaabaaaadaaaaaa
dbaaaaaiecaabaaaadaaaaaaabeaaaaaaaaaiadpdkaabaiaibaaaaaaabaaaaaa
dcaaaaajccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpabaaaaahccaabaaaadaaaaaackaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaajccaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaadaaaaaabkaabaaa
adaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadp
dbaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
dhaaaaakicaabaaaabaaaaaadkaabaaaabaaaaaabkaabaiaebaaaaaaacaaaaaa
bkaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
colkgidpabeaaaaakehadndpdiaaaaahicaabaaaabaaaaaadkaabaaaaeaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaadpdkaabaaaadaaaaaadiaaaaaiccaabaaaacaaaaaaakaabaaaacaaaaaa
akiacaaaaaaaaaaaaeaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaa
akiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaialpebaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaa
aaaaaaaaaeaaaaaaebaaaaafbcaabaaaadaaaaaabkaabaaaacaaaaaaaoaaaaai
bcaabaaaadaaaaaaakaabaaaadaaaaaaakiacaaaaaaaaaaaaeaaaaaabkaaaaaf
ccaabaaaacaaaaaabkaabaaaacaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaafaaaaaaaoaaaaaiccaabaaaagaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaaeaaaaaaaoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
akiacaaaaaaaaaaaaeaaaaaaaaaaaaahecaabaaaagaaaaaaakaabaaaacaaaaaa
ckaabaaaaaaaaaaaeiaaaaalpcaabaaaaiaaaaaajgafbaaaagaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaiadpaoaaaaaibcaabaaaagaaaaaadkaabaaa
abaaaaaadkiacaaaaaaaaaaaaeaaaaaaeiaaaaalpcaabaaaakaaaaaaigaabaaa
agaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
pcaabaaaakaaaaaakgakbaaaacaaaaaaegaobaaaakaaaaaadcaaaaajpcaabaaa
aiaaaaaaegaobaaaaiaaaaaapgapbaaaacaaaaaaegaobaaaakaaaaaaaaaaaaah
icaabaaaagaaaaaaakaabaaaadaaaaaackaabaaaaaaaaaaaeiaaaaalpcaabaaa
adaaaaaangafbaaaagaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaaeiaaaaalpcaabaaaagaaaaaamgaabaaaagaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaagaaaaaakgakbaaa
acaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaa
pgapbaaaacaaaaaaegaobaaaagaaaaaaaaaaaaaiecaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaaacaaaaaafgafbaaa
acaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaaiaaaaaa
kgakbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegaobaia
ebaaaaaaacaaaaaaegacbaaaafaaaaaaegaobaaaajaaaaaadeaaaaakpcaabaaa
ahaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
bfaaaaabdicaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaeiec
dcaaaaajicaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaahaaaaaadiaaaaahhcaabaaa
acaaaaaakgakbaaaaaaaaaaaegacbaaaahaaaaaadeaaaaahecaabaaaaaaaaaaa
akaabaaaahaaaaaaabeaaaaabhlhnbdiaoaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaakgakbaaaaaaaaaaaaoaaaaajhcaabaaaadaaaaaaagiacaaaaaaaaaaa
agaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaadiaaaaalmcaabaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiaebaaaaiaeaaoaaaaakmcaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaeaeaaaaamadpkgaobaaaaaaaaaaa
dcaaaaajicaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpdcaaaaamicaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaagaaaaaa
dkiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaaodcaabaaaadaaaaaapgipcaaa
aaaaaaaaagaaaaaapgipcaaaaaaaaaaaagaaaaaaaceaaaaaaaaaiadpaaaaaaea
aaaaaaaaaaaaaaaaapaaaaaibcaabaaaaaaaaaaaagaabaaaaaaaaaaapgipcaaa
aaaaaaaaagaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
akaabaaaadaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaamalpbjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahfcaabaaaaaaaaaaaagacbaaaaaaaaaaapgapbaaa
abaaaaaaaoaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaadaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaaj
ncaabaaaaaaaaaaaagajbaaaahaaaaaakgakbaaaaaaaaaaaagajbaaaacaaaaaa
bcaaaaabdgaaaaaihcaabaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadgaaaaaincaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaabfaaaaabdiaaaaaincaabaaaaaaaaaaaagaobaaaaaaaaaaapgipcaaa
aaaaaaaaafaaaaaabnaaaaaiicaabaaaabaaaaaabkiacaaaaaaaaaaaamaaaaaa
akaabaaaaeaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaaeaaaaaaabeaaaaa
aaaaiaeaaoaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaa
amaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklilp
bjaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdhaaaaajicaabaaaabaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpbiaaaaaibcaabaaa
acaaaaaadkiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaiadpabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaabpaaaeadbkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaafaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaaamaaaaaadbaaaaak
hcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaacpnnledpcpnnledpcpnnledp
aaaaaaaadiaaaaakpcaabaaaadaaaaaaagafbaaaabaaaaaaaceaaaaanmcomedo
dlkklilpnmcomedodlkklilpcpaaaaafdcaabaaaabaaaaaaigaabaaaadaaaaaa
diaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaacplkoidocplkoido
aaaaaaaaaaaaaaaabjaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaabjaaaaaf
dcaabaaaadaaaaaangafbaaaadaaaaaaaaaaaaaldcaabaaaadaaaaaaegaabaia
ebaaaaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadhaaaaaj
dcaabaaaadaaaaaaegaabaaaacaaaaaaegaabaaaabaaaaaaegaabaaaadaaaaaa
diaaaaakdcaabaaaabaaaaaakgakbaaaabaaaaaaaceaaaaanmcomedodlkklilp
aaaaaaaaaaaaaaaacpaaaaafccaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaacplkoidobjaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaaabaaaaaabkaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajecaabaaaadaaaaaackaabaaaacaaaaaabkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaigadbaaaaaaaaaaaagiacaaaaaaaaaaa
amaaaaaadbaaaaakhcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaacpnnledp
cpnnledpcpnnledpaaaaaaaadiaaaaakpcaabaaaaeaaaaaaagafbaaaabaaaaaa
aceaaaaanmcomedodlkklilpnmcomedodlkklilpcpaaaaafdcaabaaaabaaaaaa
igaabaaaaeaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaa
cplkoidocplkoidoaaaaaaaaaaaaaaaabjaaaaafdcaabaaaabaaaaaaegaabaaa
abaaaaaabjaaaaafdcaabaaaaeaaaaaangafbaaaaeaaaaaaaaaaaaaldcaabaaa
aeaaaaaaegaabaiaebaaaaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadhaaaaajdcaabaaaaeaaaaaaegaabaaaacaaaaaaegaabaaaabaaaaaa
egaabaaaaeaaaaaadiaaaaakdcaabaaaabaaaaaakgakbaaaabaaaaaaaceaaaaa
nmcomedodlkklilpaaaaaaaaaaaaaaaacpaaaaafccaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaacplkoido
bjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaaabaaaaaa
bkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdhaaaaajecaabaaaaeaaaaaackaabaaaacaaaaaabkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaalaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaa
adaaaaaaegacbaaaaeaaaaaadcaaaaajhccabaaaaaaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaa
aaaaaaaaanaaaaaadoaaaaabbfaaaaabdiaaaaaihcaabaaaaaaaaaaaigadbaaa
aaaaaaaaagiacaaaaaaaaaaaamaaaaaadbaaaaakhcaabaaaabaaaaaaegacbaaa
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
ckaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaalaaaaaadiaaaaaiiccabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaadoaaaaab"
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