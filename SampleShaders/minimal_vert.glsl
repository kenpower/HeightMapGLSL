#version 120

//simplest possible vertex shader
void main()
{
    gl_Position = gl_ProjectionMatrix*gl_ModelViewMatrix*gl_Vertex;

}