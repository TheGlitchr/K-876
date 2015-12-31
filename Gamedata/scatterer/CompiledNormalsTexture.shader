// Compiled shader for all platforms, uncompressed size: 10.2KB

Shader "Custom/NormalsTexture" {
Properties {
 _MainTex ("", 2D) = "white" {}
 _Cutoff ("", Float) = 0.5
 _Color ("", Color) = (1,1,1,1)
}
SubShader { 
 Tags { "RenderType"="Opaque" }


 // Stats for Vertex shader:
 //       d3d11 : 7 math
 //    d3d11_9x : 7 math
 //        d3d9 : 7 math
 //      opengl : 7 math
 // Stats for Fragment shader:
 //        d3d9 : 3 math
 //      opengl : 2 math
 Pass {
  Tags { "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 7 math
Bind "vertex" Vertex
Bind "normal" Normal
"!!ARBvp1.0
PARAM c[9] = { program.local[0],
		state.matrix.mvp,
		state.matrix.modelview[0].invtrans };
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP3 result.texcoord[0].z, vertex.normal, c[7];
DP3 result.texcoord[0].y, vertex.normal, c[6];
DP3 result.texcoord[0].x, vertex.normal, c[5];
END
# 7 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_invtrans_modelview0]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
dp3 oT0.z, v1, c6
dp3 oT0.y, v1, c5
dp3 oT0.x, v1, c4
"
}
SubProgram "d3d11 " {
// Stats: 7 math
Bind "vertex" Vertex
Bind "normal" Normal
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 128 [glstate_matrix_invtrans_modelview0]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedlghhcmmnjaikdgbdkfipckogkijcpjjjabaaaaaagaacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaa
eaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaagbabaaaabaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaa
egiccaaaaaaaaaaaakaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 7 math
Bind "vertex" Vertex
Bind "normal" Normal
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 128 [glstate_matrix_invtrans_modelview0]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedhhkggkecnbnmjiklidhkacpfhcbakfmiabaaaaaahaadaaaaaeaaaaaa
daaaaaaadmabaaaakeacaaaabiadaaaaebgpgodjaeabaaaaaeabaaaaaaacpopp
meaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaiaaadaaafaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaafaaaaadaaaaahiaabaaffja
agaaoekaaeaaaaaeaaaaahiaafaaoekaabaaaajaaaaaoeiaaeaaaaaeaaaaahoa
ahaaoekaabaakkjaaaaaoeiaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaae
aaaaapiaabaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
gaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
abaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaaagbabaaaabaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
abaaaaaaegiccaaaaaaaaaaaakaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahahaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafaepfdej
feejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklklepfdeheofaaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
eeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklkl"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_2[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_2[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_1.xyz = (tmpvar_2 * normalize(_glesNormal));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.x = xlv_TEXCOORD0.x;
  tmpvar_2.y = xlv_TEXCOORD0.y;
  tmpvar_2.z = xlv_TEXCOORD0.z;
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "flash " {
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_invtrans_modelview0]
"agal_vs
[bc]
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
bcaaaaaaaaaaaeaeabaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp3 v0.z, a1, c6
bcaaaaaaaaaaacaeabaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp3 v0.y, a1, c5
bcaaaaaaaaaaabaeabaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp3 v0.x, a1, c4
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_2[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_2[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_1.xyz = (tmpvar_2 * normalize(_glesNormal));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.x = xlv_TEXCOORD0.x;
  tmpvar_2.y = xlv_TEXCOORD0.y;
  tmpvar_2.z = xlv_TEXCOORD0.z;
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
out highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_2[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_2[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_1.xyz = (tmpvar_2 * normalize(_glesNormal));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
in highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.x = xlv_TEXCOORD0.x;
  tmpvar_2.y = xlv_TEXCOORD0.y;
  tmpvar_2.z = xlv_TEXCOORD0.z;
  tmpvar_1 = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 2 math
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
MOV result.color.xyz, fragment.texcoord[0];
MOV result.color.w, c[0].x;
END
# 2 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 3 math
"ps_2_0
def c0, 1.00000000, 0, 0, 0
dcl t0.xyz
mov_pp r0.w, c0.x
mov_pp r0.xyz, t0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
"ps_4_0
eefiecedgffknhibocfcehmfamledmglflgfmllnabaaaaaaamabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcemaaaaaa
eaaaaaaabdaaaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
dgaaaaafhccabaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
"ps_4_0_level_9_1
eefiecedblgcgkhfgnfkileeapehnmggpnejbppfabaaaaaaimabaaaaaeaaaaaa
daaaaaaakmaaaaaaaaabaaaafiabaaaaebgpgodjheaaaaaaheaaaaaaaaacpppp
faaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
fbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaacplaabaaaaacaaaachiaaaaaoelaabaaaaacaaaaciiaaaaaaakaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcemaaaaaaeaaaaaaabdaaaaaagcbaaaad
hcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaafhccabaaaaaaaaaaa
egbcbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
ejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapahaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "flash " {
"agal_ps
c0 1.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacaaaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c0.x
aaaaaaaaaaaaahacaaaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, v0
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
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