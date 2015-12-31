// Compiled shader for all platforms, uncompressed size: 11.3KB

Shader "Custom/DepthTexture2" {
SubShader { 
 Tags { "RenderType"="Opaque" }


 // Stats for Vertex shader:
 //       d3d11 : 10 math
 //    d3d11_9x : 10 math
 //        d3d9 : 7 math
 //      opengl : 7 math
 // Stats for Fragment shader:
 //       d3d11 : 1 math
 //    d3d11_9x : 1 math
 //        d3d9 : 5 math
 //      opengl : 4 math
 Pass {
  Tags { "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 7 math
Bind "vertex" Vertex
Vector 9 [_ProjectionParams]
"!!ARBvp1.0
PARAM c[10] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
DP4 R0.x, vertex.position, c[3];
MUL R0.x, R0, c[9].w;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[0].w, -R0.x;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
"vs_2_0
dcl_position0 v0
dp4 r0.x, v0, c2
mul r0.x, r0, c8.w
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT0.w, -r0.x
"
}
SubProgram "d3d11 " {
// Stats: 10 math
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgmhmkmogifpjfjdjagafjeppfdllbjceabaaaaaameacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapahaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefcmeabaaaa
eaaaabaahbaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaa
aaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
abaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaadkbabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
aaaaaaaaafaaaaaadgaaaaagiccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 10 math
Bind "vertex" Vertex
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "UnityPerCamera" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedjddnmmfhfdpheopeeomjbacoohcfldgjabaaaaaapiadaaaaaeaaaaaa
daaaaaaagaabaaaacmadaaaakaadaaaaebgpgodjciabaaaaciabaaaaaaacpopp
oiaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaafaa
abaaabaaaaaaaaaaabaaaaaaaiaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjaafaaaaadaaaaabiaaaaaffjaahaakkkaaeaaaaaeaaaaabia
agaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabiaaiaakkkaaaaakkjaaaaaaaia
aeaaaaaeaaaaabiaajaakkkaaaaappjaaaaaaaiaafaaaaadaaaaabiaaaaaaaia
abaappkaabaaaaacaaaaaioaaaaaaaibafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefcmeabaaaaeaaaabaahbaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadiccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaafaaaaaadgaaaaagiccabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapahaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = -(((glstate_matrix_modelview0 * _glesVertex).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 result_1;
  result_1 = vec4(1.0, 1.0, 1.0, 1.0);
  if ((xlv_TEXCOORD0.w < 1.0)) {
    highp vec4 tmpvar_2;
    tmpvar_2.w = 1.0;
    tmpvar_2.x = xlv_TEXCOORD0.w;
    tmpvar_2.y = xlv_TEXCOORD0.w;
    tmpvar_2.z = xlv_TEXCOORD0.w;
    result_1 = tmpvar_2;
  };
  gl_FragData[0] = result_1;
}



#endif"
}
SubProgram "flash " {
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
"agal_vs
[bc]
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.x, a0, c2
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaiaaaappabaaaaaa mul r0.x, r0.x, c8.w
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 o0.w, a0, c7
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 o0.z, a0, c6
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 o0.y, a0, c5
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 o0.x, a0, c4
bfaaaaaaaaaaaiaeaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg v0.w, r0.x
aaaaaaaaaaaaahaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.xyz, c0
"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = -(((glstate_matrix_modelview0 * _glesVertex).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 result_1;
  result_1 = vec4(1.0, 1.0, 1.0, 1.0);
  if ((xlv_TEXCOORD0.w < 1.0)) {
    highp vec4 tmpvar_2;
    tmpvar_2.w = 1.0;
    tmpvar_2.x = xlv_TEXCOORD0.w;
    tmpvar_2.y = xlv_TEXCOORD0.w;
    tmpvar_2.z = xlv_TEXCOORD0.w;
    result_1 = tmpvar_2;
  };
  gl_FragData[0] = result_1;
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
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = -(((glstate_matrix_modelview0 * _glesVertex).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
in highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 result_1;
  result_1 = vec4(1.0, 1.0, 1.0, 1.0);
  if ((xlv_TEXCOORD0.w < 1.0)) {
    highp vec4 tmpvar_2;
    tmpvar_2.w = 1.0;
    tmpvar_2.x = xlv_TEXCOORD0.w;
    tmpvar_2.y = xlv_TEXCOORD0.w;
    tmpvar_2.z = xlv_TEXCOORD0.w;
    result_1 = tmpvar_2;
  };
  _glesFragData[0] = result_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 4 math
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEMP R1;
MOV R0.xyz, fragment.texcoord[0].w;
MOV R0.w, c[0].x;
ADD R1.x, fragment.texcoord[0].w, -c[0];
CMP result.color, R1.x, R0, c[0].x;
END
# 4 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 5 math
"ps_2_0
def c0, -1.00000000, 1.00000000, 0, 0
dcl t0.xyzw
mov_pp r0.xyz, t0.w
mov_pp r0.w, c0.y
add r1.x, t0.w, c0
cmp_pp r0, r1.x, c0.y, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 1 math
"ps_4_0
eefiecedpddhlalhempmohllhcgicohegijiepkgabaaaaaagaabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckaaaaaaa
eaaaaaaaciaaaaaagcbaaaadicbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaadbaaaaahbcaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaa
aaaaiadpdgaaaaafhcaabaaaabaaaaaapgbpbaaaabaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaaaaaaiadpdhaaaaampccabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 1 math
"ps_4_0_level_9_1
eefiecedeihiddhpkgkhhadebgcjpinjnbdgcmlkabaaaaaaoeabaaaaaeaaaaaa
daaaaaaalaaaaaaafiabaaaalaabaaaaebgpgodjhiaaaaaahiaaaaaaaaacpppp
feaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
fbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaacplaakaaaaadaaaachiaaaaapplaaaaaaakaabaaaaacaaaaciiaaaaaaaka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefckaaaaaaaeaaaaaaaciaaaaaa
gcbaaaadicbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
dbaaaaahbcaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaaaaiadpdgaaaaaf
hcaabaaaabaaaaaapgbpbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaiadpdhaaaaampccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaabejfdeheofaaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
eeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "flash " {
"agal_ps
c0 -1.0 1.0 0.0 0.0
[bc]
aaaaaaaaaaaaahacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, v0.w
aaaaaaaaaaaaaiacaaaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c0.y
abaaaaaaabaaabacaaaaaappaeaaaaaaaaaaaaoeabaaaaaa add r1.x, v0.w, c0
ckaaaaaaabaaapacabaaaaaaacaaaaaaaaaaaakkabaaaaaa slt r1, r1.x, c0.z
acaaaaaaacaaapacaaaaaaoeacaaaaaaaaaaaaffabaaaaaa sub r2, r0, c0.y
adaaaaaaaaaaapacacaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r2, r1
abaaaaaaaaaaapacaaaaaaoeacaaaaaaaaaaaaffabaaaaaa add r0, r0, c0.y
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