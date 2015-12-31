// Compiled shader for all platforms, uncompressed size: 18.2KB

Shader "Custom/viewCustomColorShader" {
SubShader { 
 Tags { "RenderType"="Opaque" }


 // Stats for Vertex shader:
 //       d3d11 : 7 math
 //        d3d9 : 10 math
 //      opengl : 10 math
 // Stats for Fragment shader:
 //        d3d9 : 1 math
 //      opengl : 1 math
 Pass {
  Tags { "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
// Stats: 10 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_ProjectionParams]
"3.0-!!ARBvp1.0
PARAM c[6] = { { 0.5 },
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[5].x;
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 10 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
"vs_3_0
dcl_texcoord0 o0
dcl_position o1
dcl_texcoord1 o2
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c6.x
mul r1.y, r1, c4.x
mad o2.xy, r1.z, c5.zwzw, r1
mov o1, r0
mov o2.zw, r0
mov o0.xy, v1
"
}
SubProgram "d3d11 " {
// Stats: 7 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedieimpdkoobkkabigplmfkeakejhbkpalabaaaaaameacaaaaadaaaaaa
cmaaaaaakaaaaaaabaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaadamaaaafjaaaaaaaaaaaaaaabaaaaaaadaaaaaaabaaaaaaapaaaaaa
faaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafeeffiedepepfcee
aafdfgfpfaepfdejfeejepeoaaklklklfdeieefckmabaaaaeaaaabaaglaaaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaacaaaaaagfaaaaaddccabaaa
aaaaaaaaghaaaaaepccabaaaabaaaaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacacaaaaaadgaaaaafdccabaaaaaaaaaaaegbabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egaobaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD1 = o_2;
}



#endif
#ifdef FRAGMENT

#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif

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
#line 17
struct v2f {
    highp vec2 uv;
    highp vec4 pos;
    highp vec4 projPos;
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
#line 15
uniform sampler2D _ColorTex;
#line 24
#line 34
#line 34
mediump vec4 frag( in v2f i ) {
    #line 39
    highp vec4 color = texture2D( _ColorTex, i.uv);
    #line 50
    return vec4( float(color.x, color.y, color.z, 1));
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main() {
    mediump vec4 xl_retval;
    v2f xlt_i;
    xlt_i.uv = vec2(xlv_TEXCOORD0);
    xlt_i.pos = vec4(0.0);
    xlt_i.projPos = vec4(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:22(2): warning: empty declaration
0:65(2): warning: empty declaration
0:51(15): error: too many parameters to `float' constructor
0:51(9): error: cannot construct `vec4' from a non-numeric data type
0:51(51): error: `return' with wrong type error, in function `frag' returning vec4
*/


#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD1 = o_2;
}



#endif
#ifdef FRAGMENT

#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
#endif

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
#line 17
struct v2f {
    highp vec2 uv;
    highp vec4 pos;
    highp vec4 projPos;
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
#line 15
uniform sampler2D _ColorTex;
#line 24
#line 34
#line 34
mediump vec4 frag( in v2f i ) {
    #line 39
    highp vec4 color = texture2D( _ColorTex, i.uv);
    #line 50
    return vec4( float(color.x, color.y, color.z, 1));
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main() {
    mediump vec4 xl_retval;
    v2f xlt_i;
    xlt_i.uv = vec2(xlv_TEXCOORD0);
    xlt_i.pos = vec4(0.0);
    xlt_i.projPos = vec4(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:22(2): warning: empty declaration
0:65(2): warning: empty declaration
0:51(15): error: too many parameters to `float' constructor
0:51(9): error: cannot construct `vec4' from a non-numeric data type
0:51(51): error: `return' with wrong type error, in function `frag' returning vec4
*/


#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD1 = o_2;
}



#endif
#ifdef FRAGMENT


#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#define gl_FragColor _glesFragData[0]
#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

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
#line 17
struct v2f {
    highp vec2 uv;
    highp vec4 pos;
    highp vec4 projPos;
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
#line 15
uniform sampler2D _ColorTex;
#line 24
#line 34
#line 34
mediump vec4 frag( in v2f i ) {
    #line 39
    highp vec4 color = texture( _ColorTex, i.uv);
    #line 50
    return vec4( float(color.x, color.y, color.z, 1));
}
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main() {
    mediump vec4 xl_retval;
    v2f xlt_i;
    xlt_i.uv = vec2(xlv_TEXCOORD0);
    xlt_i.pos = vec4(0.0);
    xlt_i.projPos = vec4(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:22(2): warning: empty declaration
0:65(2): warning: empty declaration
0:51(15): error: too many parameters to `float' constructor
0:51(9): error: cannot construct `vec4' from a non-numeric data type
0:51(51): error: `return' with wrong type error, in function `frag' returning vec4
*/


#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 1 math
"3.0-!!ARBfp1.0
PARAM c[1] = { { 1 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 1 math
"ps_3_0
def c0, 1.00000000, 0, 0, 0
mov_pp oC0, c0.x
"
}
SubProgram "d3d11 " {
"ps_4_0
eefiecedahihhklfbbkedpalochcnmgohjjjhojmabaaaaaabaabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaadaaaaaafjaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaafaaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafeeffiedepepfceeaafdfgfpfaepfdejfeejepeoaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiaaaaaaeaaaaaaaaoaaaaaa
gfaaaaadpccabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdoaaaaab"
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