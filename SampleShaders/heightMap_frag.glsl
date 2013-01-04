#version 120

uniform sampler2D mapsurface;

void main()
{

	vec4 c=texture2D(mapsurface,gl_TexCoord[0].st);
	gl_FragColor=c;
}