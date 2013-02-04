#version 120

uniform sampler2D grassTex;
uniform sampler2D snowTex;
uniform sampler2D waterTex;

varying float waterBlend;
varying float grassBlend;
varying float snowBlend;



void main()
{

	vec4 c=	texture2D(grassTex,gl_TexCoord[0].st)*grassBlend+
			texture2D(snowTex,gl_TexCoord[0].st)*snowBlend+
			texture2D(waterTex,gl_TexCoord[0].st)*waterBlend;

	gl_FragColor=c*gl_Color;
}