#version 120

uniform sampler2D texture;

//get texture
void main()
{
	vec4 c=texture2D(texture,gl_TexCoord[0].st);
	gl_FragColor=gl_Color*c;
}