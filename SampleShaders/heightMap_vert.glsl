#version 120


uniform sampler2D heightMap;
varying float waterBlend;
varying float grassBlend;
varying float snowBlend;


void main()
{
	vec4 pos=gl_Vertex;
	
	
	if(gl_MaxVertexTextureImageUnits>0){
		vec4 h=texture2D(heightMap,gl_MultiTexCoord0.st);

		pos.y=h.r;
		

		
		//Grass
		waterBlend=0.0;
		snowBlend=0.0;
		if(h.r<0.1) grassBlend=clamp((h.r-0.05)/0.1,0.0,1.0);
		if(h.r>=0.1 && h.r<0.6) grassBlend=1.0;
		if(h.r>=0.6){ grassBlend=clamp((1.0-(h.r-0.6)/0.15),0.0,1.0);}
			
		//water
		if(h.r <=0.1) waterBlend=1.0-grassBlend;
		
		//Snow
		if(h.r>=0.6)
			snowBlend=1-grassBlend;
	

	
	}

	gl_FrontColor=vec4(1);

	gl_TexCoord[0]=gl_MultiTexCoord0;

	gl_Position = gl_ProjectionMatrix*gl_ModelViewMatrix*pos;
}