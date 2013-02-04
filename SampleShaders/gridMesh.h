#include "stdafx.h" 
#include "SFML/OpenGL.hpp" 
#include <cmath>

#define U_STEPS 50 // resolution of the mesh
#define V_STEPS 50  // resolution of the mesh


GLint gridNumQuads=U_STEPS*V_STEPS*4;
GLfloat gridVertices[U_STEPS][V_STEPS][3];
GLfloat gridTexCoords[U_STEPS][V_STEPS][2];
GLuint gridTriangles[(U_STEPS-1)*(V_STEPS-1)*2][3];
int numGridTriangles;


int createGrid(){
	// generate array of points for the flat grid

     
	
    //double u,v ;
 
    //int t=0;
 
 
	float scale=3.0f/U_STEPS;
	float origin=-U_STEPS/2.0f;
 
	int t=0;
    for(int u=0; u< U_STEPS;u++){
        for(int v=0; v< V_STEPS;v++){
            
 
           
            gridVertices[u][v][0]=(u+origin)*scale;
            gridVertices[u][v][1]=0;
            gridVertices[u][v][2]=(v+origin)*scale;

            gridTexCoords[u][v][0]=(float)u/U_STEPS;
            gridTexCoords[u][v][1]=(float)v/V_STEPS;

 
 /*
            // compute normal for each vertex
            torusNormals[U][V][0]=torusVertices[U][V][0]-(GLfloat)(R*cos(v));
            torusNormals[U][V][1]=torusVertices[U][V][1]-0;
            torusNormals[U][V][2]=torusVertices[U][V][2]-(GLfloat)(R*sin(v));
        */ 
             
            // create a mesh, the quads array contains indices to the vertices array
            //// each group of 3 for each t
            int V1=(v+1)%V_STEPS;
            int U1=(u+1)%U_STEPS;
 
			if((V1!=0 && U1!=0)){
				gridTriangles[t][0]=v + u*V_STEPS;
				gridTriangles[t][1]=V1 + u*V_STEPS;
				gridTriangles[t][2]=V1 + U1*V_STEPS;
				t++;
				gridTriangles[t][0]=V1 + U1*V_STEPS;
				gridTriangles[t][1]=v + u*V_STEPS;
				gridTriangles[t][2]=v + U1*V_STEPS;
				t++;
				}
             
            
            
        }
    }

	numGridTriangles=t;
	return U_STEPS*V_STEPS;

}

