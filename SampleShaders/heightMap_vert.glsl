#version 120
#extension GL_EXT_gpu_shader4:enable

uniform sampler2D heightMap;
varying float waterBlend;
varying float grassBlend;
varying float snowBlend;


void main()
{
	vec4 pos=gl_Vertex;
	
	

	vec4 h=texture2D(heightMap,gl_MultiTexCoord0.st);

	pos.y=h.r;
		

		
	
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

    /*
	int ih=int(h.r*10);
	if(ih%2 == 0 ) waterBlend=1.0;


	//if(h.r < 0.1) waterBlend=1.0;
	if(h.r > 0.1 && h.r< 0.6) grassBlend=1.0;
	if(h.r > 0.6) snowBlend=1.0;
	*/
	    
	

	
	

	
	gl_TexCoord[0]=gl_MultiTexCoord0;

	gl_Position = gl_ProjectionMatrix*gl_ModelViewMatrix*pos;
}