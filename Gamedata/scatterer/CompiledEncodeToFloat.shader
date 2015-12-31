// Compiled shader for all platforms, uncompressed size: 26.1KB

Shader "EncodeFloat/EncodeToFloat" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
}
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //      opengl : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 4 math, 1 texture
 //        d3d9 : 4 math, 1 texture
 //      opengl : 5 math, 1 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
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

uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float r_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).x;
  r_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((r_1 / 255.0) + 0.5);
  r_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.60581e+08) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - (tmpvar_4.yzww * vec4(0.00392157, 0.00392157, 0.00392157, 0.0)));
  gl_FragData[0] = tmpvar_5;
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

uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float r_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).x;
  r_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((r_1 / 255.0) + 0.5);
  r_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.60581e+08) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - (tmpvar_4.yzww * vec4(0.00392157, 0.00392157, 0.00392157, 0.0)));
  gl_FragData[0] = tmpvar_5;
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
uniform sampler2D _MainTex;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float r_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).x;
  r_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((r_1 / 255.0) + 0.5);
  r_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.60581e+08) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - (tmpvar_4.yzww * vec4(0.00392157, 0.00392157, 0.00392157, 0.0)));
  _glesFragData[0] = tmpvar_5;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 5 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[2] = { { 0.0039215689, 0.5, 0 },
		{ 1, 255, 65025, 1.6058138e+008 } };
TEMP R0;
TEX R0.x, fragment.texcoord[0], texture[0], 2D;
MAD R0.x, R0, c[0], c[0].y;
MUL R0, R0.x, c[1];
FRC R0, R0;
MAD result.color, -R0.yzww, c[0].xxxz, R0;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 4 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c0, 0.00392157, 0.50000000, 0.00000000, 0
def c1, 1.00000000, 255.00000000, 65025.00000000, 160581376.00000000
dcl_texcoord0 v0.xy
texld r0.x, v0, s0
mad r0.x, r0, c0, c0.y
mul r0, r0.x, c1
frc r0, r0
mad oC0, -r0.yzww, c0.xxxz, r0
"
}
SubProgram "d3d11 " {
// Stats: 4 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecednbaddmoncckfmikdhbjkielehmiondhaabaaaaaamaabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaabaaaa
eaaaaaaaeaaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
ibiaiadlabeaaaaaaaaaaadpdiaaaaakpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaahpedaaabhoehhacebjenbkaaaaafpcaabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaanpccabaaaaaaaaaaajgapbaiaebaaaaaaaaaaaaaa
aceaaaaaibiaiadlibiaiadlibiaiadlaaaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //      opengl : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 4 math, 1 texture
 //        d3d9 : 4 math, 1 texture
 //      opengl : 5 math, 1 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
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

uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float g_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).y;
  g_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((g_1 / 255.0) + 0.5);
  g_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.60581e+08) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - (tmpvar_4.yzww * vec4(0.00392157, 0.00392157, 0.00392157, 0.0)));
  gl_FragData[0] = tmpvar_5;
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

uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float g_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).y;
  g_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((g_1 / 255.0) + 0.5);
  g_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.60581e+08) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - (tmpvar_4.yzww * vec4(0.00392157, 0.00392157, 0.00392157, 0.0)));
  gl_FragData[0] = tmpvar_5;
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
uniform sampler2D _MainTex;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float g_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).y;
  g_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((g_1 / 255.0) + 0.5);
  g_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.60581e+08) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - (tmpvar_4.yzww * vec4(0.00392157, 0.00392157, 0.00392157, 0.0)));
  _glesFragData[0] = tmpvar_5;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 5 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[2] = { { 0.0039215689, 0.5, 0 },
		{ 1, 255, 65025, 1.6058138e+008 } };
TEMP R0;
TEX R0.y, fragment.texcoord[0], texture[0], 2D;
MAD R0.x, R0.y, c[0], c[0].y;
MUL R0, R0.x, c[1];
FRC R0, R0;
MAD result.color, -R0.yzww, c[0].xxxz, R0;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 4 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c0, 0.00392157, 0.50000000, 0.00000000, 0
def c1, 1.00000000, 255.00000000, 65025.00000000, 160581376.00000000
dcl_texcoord0 v0.xy
texld r0.y, v0, s0
mad r0.x, r0.y, c0, c0.y
mul r0, r0.x, c1
frc r0, r0
mad oC0, -r0.yzww, c0.xxxz, r0
"
}
SubProgram "d3d11 " {
// Stats: 4 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedealdcecfhckfneoplgnjncadijhkflobabaaaaaamaabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaabaaaa
eaaaaaaaeaaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
ibiaiadlabeaaaaaaaaaaadpdiaaaaakpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaahpedaaabhoehhacebjenbkaaaaafpcaabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaanpccabaaaaaaaaaaajgapbaiaebaaaaaaaaaaaaaa
aceaaaaaibiaiadlibiaiadlibiaiadlaaaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //      opengl : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 4 math, 1 texture
 //        d3d9 : 4 math, 1 texture
 //      opengl : 5 math, 1 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
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

uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float b_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).z;
  b_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((b_1 / 255.0) + 0.5);
  b_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.60581e+08) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - (tmpvar_4.yzww * vec4(0.00392157, 0.00392157, 0.00392157, 0.0)));
  gl_FragData[0] = tmpvar_5;
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

uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float b_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).z;
  b_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((b_1 / 255.0) + 0.5);
  b_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.60581e+08) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - (tmpvar_4.yzww * vec4(0.00392157, 0.00392157, 0.00392157, 0.0)));
  gl_FragData[0] = tmpvar_5;
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
uniform sampler2D _MainTex;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float b_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).z;
  b_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((b_1 / 255.0) + 0.5);
  b_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.60581e+08) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - (tmpvar_4.yzww * vec4(0.00392157, 0.00392157, 0.00392157, 0.0)));
  _glesFragData[0] = tmpvar_5;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 5 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[2] = { { 0.0039215689, 0.5, 0 },
		{ 1, 255, 65025, 1.6058138e+008 } };
TEMP R0;
TEX R0.z, fragment.texcoord[0], texture[0], 2D;
MAD R0.x, R0.z, c[0], c[0].y;
MUL R0, R0.x, c[1];
FRC R0, R0;
MAD result.color, -R0.yzww, c[0].xxxz, R0;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 4 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c0, 0.00392157, 0.50000000, 0.00000000, 0
def c1, 1.00000000, 255.00000000, 65025.00000000, 160581376.00000000
dcl_texcoord0 v0.xy
texld r0.z, v0, s0
mad r0.x, r0.z, c0, c0.y
mul r0, r0.x, c1
frc r0, r0
mad oC0, -r0.yzww, c0.xxxz, r0
"
}
SubProgram "d3d11 " {
// Stats: 4 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedefgjbnhljlbnodapjbfndjghffhfnlcfabaaaaaamaabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaabaaaa
eaaaaaaaeaaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
ibiaiadlabeaaaaaaaaaaadpdiaaaaakpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaahpedaaabhoehhacebjenbkaaaaafpcaabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaanpccabaaaaaaaaaaajgapbaiaebaaaaaaaaaaaaaa
aceaaaaaibiaiadlibiaiadlibiaiadlaaaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //      opengl : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 4 math, 1 texture
 //        d3d9 : 4 math, 1 texture
 //      opengl : 5 math, 1 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
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

uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float a_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  a_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((a_1 / 255.0) + 0.5);
  a_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.60581e+08) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - (tmpvar_4.yzww * vec4(0.00392157, 0.00392157, 0.00392157, 0.0)));
  gl_FragData[0] = tmpvar_5;
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

uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float a_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  a_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((a_1 / 255.0) + 0.5);
  a_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.60581e+08) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - (tmpvar_4.yzww * vec4(0.00392157, 0.00392157, 0.00392157, 0.0)));
  gl_FragData[0] = tmpvar_5;
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
uniform sampler2D _MainTex;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp float a_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  a_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((a_1 / 255.0) + 0.5);
  a_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.60581e+08) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - (tmpvar_4.yzww * vec4(0.00392157, 0.00392157, 0.00392157, 0.0)));
  _glesFragData[0] = tmpvar_5;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 5 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[2] = { { 0.0039215689, 0.5, 0 },
		{ 1, 255, 65025, 1.6058138e+008 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MAD R0.x, R0.w, c[0], c[0].y;
MUL R0, R0.x, c[1];
FRC R0, R0;
MAD result.color, -R0.yzww, c[0].xxxz, R0;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 4 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c0, 0.00392157, 0.50000000, 0.00000000, 0
def c1, 1.00000000, 255.00000000, 65025.00000000, 160581376.00000000
dcl_texcoord0 v0.xy
texld r0.w, v0, s0
mad r0.x, r0.w, c0, c0.y
mul r0, r0.x, c1
frc r0, r0
mad oC0, -r0.yzww, c0.xxxz, r0
"
}
SubProgram "d3d11 " {
// Stats: 4 math, 1 textures
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedpaneljcgdcodohbhllnbpogoodfblgeaabaaaaaamaabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaabaaaa
eaaaaaaaeaaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
ibiaiadlabeaaaaaaaaaaadpdiaaaaakpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaahpedaaabhoehhacebjenbkaaaaafpcaabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaanpccabaaaaaaaaaaajgapbaiaebaaaaaaaaaaaaaa
aceaaaaaibiaiadlibiaiadlibiaiadlaaaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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