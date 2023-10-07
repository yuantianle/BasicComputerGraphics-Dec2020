#version 330 compatibility

//uniform float	uTime;		// "Time", from Animate( )
uniform float	uA;	
uniform float	uB;	

out vec2  	vST;		// texture coords
out vec3    vN;
out vec3    vL;
out vec3    vE;

const float PI = 	3.14159265;
const float AMP = 	0.2;		// amplitude
const float W = 	2.;		// frequency
const vec3 LIGHTPOSITION = vec3( 5., 5., 0. );

void
main( )
{ 
	vST = gl_MultiTexCoord0.st;
	vec4 ECposition = gl_ModelViewMatrix * gl_Vertex;
	vN = normalize( gl_NormalMatrix * gl_Normal );
	vL = LIGHTPOSITION - ECposition.xyz;
	vE = vec3( 0., 0., 0. ) - ECposition.xyz; // normal vector

	vec3 vert = gl_Vertex.xyz;
	float angle1 = ((45.0*uA/360.0)*2*PI)*(vert.x)/1.5;
	vert.y = (cos(angle1)*vert.y-sin(angle1)*vert.z);
    vert.z = (sin(angle1)*vert.y+cos(angle1)*vert.z);

	float angle2 = ((45.0*uA/360.0)*2*PI)*(vert.y)/1.5;
	vert.x = (cos(angle2)*vert.x-sin(angle2)*vert.z);
    vert.z = (sin(angle2)*vert.x+cos(angle2)*vert.z);

	//float angle3 = ((45.0*uB/360.0)*2*PI)*(vert.z)/1.5;
	//vert.y = (cos(angle3)*vert.y-sin(angle3)*vert.x);
    //vert.x = (sin(angle3)*vert.y+cos(angle3)*vert.x);

	float angle3 = ((45.0*uA/360.0)*2*PI)*(vert.z)/1.5;
	vert.y = (cos(angle3)*vert.y-sin(angle3)*vert.x);
	vert.x = (sin(angle3)*vert.y+cos(angle3)*vert.x);
  
	gl_Position = gl_ModelViewProjectionMatrix * vec4( vert, 1. );
}

