#version 120

uniform float gridWidth;
uniform float texWidth;

uniform sampler2D heightMap;

uniform float test;

varying float waterBlend;
varying float grassBlend;
varying float snowBlend;


void main()
{
	vec4 pos=gl_Vertex;
	
	

	vec4 h=texture2D(heightMap,gl_MultiTexCoord0.st);

	pos.y=h.r;
		
	//Calulate normal
	vec4 a=pos;
	vec4 b=pos;
	vec2 ta=gl_MultiTexCoord0.st;
	vec2 tb=gl_MultiTexCoord0.st;



	ta.s+=texWidth;
    
	a.x+=gridWidth;
	a.y=texture2D(heightMap,ta).r;
	
	tb.t+=texWidth;

    b.z+=gridWidth;
	b.y=texture2D(heightMap,tb).r;

	vec3 normal=cross(vec3(b-pos),vec3(a-pos));
	//normal=-normal;

	normal=normalize(normal);
	
	vec3 light=vec3(normalize(vec3(0,2,0)-(gl_ModelViewMatrix*pos).xyz));

	float l=dot(normal,light);
	
	gl_FrontColor=vec4(l,l,l,1);

	waterBlend=0.0;
	snowBlend=0.0;
	grassBlend=0.0;
	
	
	//Grass
	if(h.r<0.1) grassBlend=clamp((h.r-0.05)/0.05,0.0,1.0);
	if(h.r>=0.1 && h.r<0.6) grassBlend=1.0;
	if(h.r>=0.6){ grassBlend=clamp((1.0-(h.r-0.6)/0.15),0.0,1.0);}
		
	//water
	if(h.r <=0.1) waterBlend=1.0-grassBlend;
		
	//Snow
	if(h.r>=0.6)
		snowBlend=1-grassBlend;

	gl_TexCoord[0]=gl_MultiTexCoord0;

	gl_Position = gl_ProjectionMatrix*gl_ModelViewMatrix*pos;
}