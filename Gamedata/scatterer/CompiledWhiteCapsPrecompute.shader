// Compiled shader for all platforms, uncompressed size: 9.8KB

Shader "Proland/Ocean/WhiteCapsPrecompute" {
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 10 math, 3 texture
 //        d3d9 : 14 math, 3 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Map5;
uniform sampler2D _Map6;
uniform sampler2D _Map7;
uniform vec4 _Choppyness;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (_Choppyness * texture2D (_Map5, xlv_TEXCOORD0));
  vec4 tmpvar_2;
  tmpvar_2 = (_Choppyness * texture2D (_Map6, xlv_TEXCOORD0));
  vec4 tmpvar_3;
  tmpvar_3 = ((_Choppyness * _Choppyness) * texture2D (_Map7, xlv_TEXCOORD0));
  vec4 tmpvar_4;
  tmpvar_4 = ((((0.25 + tmpvar_1) + tmpvar_2) + ((_Choppyness * tmpvar_1) * tmpvar_2)) - (tmpvar_3 * tmpvar_3));
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * tmpvar_4);
  vec4 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.y = tmpvar_5.x;
  tmpvar_6.z = tmpvar_4.y;
  tmpvar_6.w = tmpvar_5.y;
  vec4 tmpvar_7;
  tmpvar_7.x = tmpvar_4.z;
  tmpvar_7.y = tmpvar_5.z;
  tmpvar_7.z = tmpvar_4.w;
  tmpvar_7.w = tmpvar_5.w;
  gl_FragData[0] = tmpvar_6;
  gl_FragData[1] = tmpvar_7;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 4 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefieceddolmmcahcgjmjpiinclfhjokihhgamkaabaaaaaaaeacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaacaaaaaa
doaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Map5;
uniform sampler2D _Map6;
uniform sampler2D _Map7;
uniform highp vec4 _Choppyness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Map5, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Choppyness * tmpvar_1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Map6, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Choppyness * tmpvar_3);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Map7, xlv_TEXCOORD0);
  highp vec4 tmpvar_6;
  tmpvar_6 = ((_Choppyness * _Choppyness) * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((((0.25 + tmpvar_2) + tmpvar_4) + ((_Choppyness * tmpvar_2) * tmpvar_4)) - (tmpvar_6 * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_7.y;
  tmpvar_9.w = tmpvar_8.y;
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7.z;
  tmpvar_10.y = tmpvar_8.z;
  tmpvar_10.z = tmpvar_7.w;
  tmpvar_10.w = tmpvar_8.w;
  gl_FragData[0] = tmpvar_9;
  gl_FragData[1] = tmpvar_10;
}



#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Map5;
uniform sampler2D _Map6;
uniform sampler2D _Map7;
uniform highp vec4 _Choppyness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Map5, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Choppyness * tmpvar_1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Map6, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Choppyness * tmpvar_3);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Map7, xlv_TEXCOORD0);
  highp vec4 tmpvar_6;
  tmpvar_6 = ((_Choppyness * _Choppyness) * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((((0.25 + tmpvar_2) + tmpvar_4) + ((_Choppyness * tmpvar_2) * tmpvar_4)) - (tmpvar_6 * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_7.y;
  tmpvar_9.w = tmpvar_8.y;
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7.z;
  tmpvar_10.y = tmpvar_8.z;
  tmpvar_10.z = tmpvar_7.w;
  tmpvar_10.w = tmpvar_8.w;
  gl_FragData[0] = tmpvar_9;
  gl_FragData[1] = tmpvar_10;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Map5;
uniform sampler2D _Map6;
uniform sampler2D _Map7;
uniform highp vec4 _Choppyness;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture (_Map5, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Choppyness * tmpvar_1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_Map6, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Choppyness * tmpvar_3);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Map7, xlv_TEXCOORD0);
  highp vec4 tmpvar_6;
  tmpvar_6 = ((_Choppyness * _Choppyness) * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((((0.25 + tmpvar_2) + tmpvar_4) + ((_Choppyness * tmpvar_2) * tmpvar_4)) - (tmpvar_6 * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_7.y;
  tmpvar_9.w = tmpvar_8.y;
  highp vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_7.z;
  tmpvar_10.y = tmpvar_8.z;
  tmpvar_10.z = tmpvar_7.w;
  tmpvar_10.w = tmpvar_8.w;
  _glesFragData[0] = tmpvar_9;
  _glesFragData[1] = tmpvar_10;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 14 math, 3 textures
Vector 0 [_Choppyness]
SetTexture 0 [_Map5] 2D 0
SetTexture 1 [_Map6] 2D 1
SetTexture 2 [_Map7] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.25000000, 0, 0, 0
dcl_texcoord0 v0.xy
texld r1, v0, s1
texld r0, v0, s0
mul r1, r1, c0
mul r0, r0, c0
add r2, r0, r1
mul r0, r0, c0
mad r2, r0, r1, r2
mul r1, c0, c0
texld r0, v0, s2
mul r0, r1, r0
mad r0, -r0, r0, r2
add r0, r0, c1.x
mul r1, r0, r0
mov oC0.xz, r0.xyyw
mov oC0.yw, r1.xxzy
mov oC1.xz, r0.zyww
mov oC1.yw, r1.xzzw
"
}
SubProgram "d3d11 " {
// Stats: 10 math, 3 textures
SetTexture 0 [_Map5] 2D 0
SetTexture 1 [_Map6] 2D 1
SetTexture 2 [_Map7] 2D 2
ConstBuffer "$Globals" 32
Vector 16 [_Choppyness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedoaffedinohfmmgohhjfijgjfeiahcmooabaaaaaaiiadaaaaadaaaaaa
cmaaaaaaieaaaaaanaaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheoeeaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaadiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclaacaaaaeaaaaaaakmaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaad
pccabaaaabaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
aaaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaiadoaaaaiado
aaaaiadoaaaaiadodcaaaaajpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaajpcaabaaaabaaaaaaegiocaaaaaaaaaaa
abaaaaaaegiocaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadgaaaaaffccabaaa
aaaaaaaaagabbaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaaffccabaaaabaaaaaakgalbaaaaaaaaaaadgaaaaaf
kccabaaaaaaaaaaaagaebaaaabaaaaaadgaaaaafkccabaaaabaaaaaakgaobaaa
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
}