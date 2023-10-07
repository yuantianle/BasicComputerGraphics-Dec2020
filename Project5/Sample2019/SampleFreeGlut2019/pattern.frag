#version 330 compatibility

//uniform float	uTime;		// "Time", from Animate( )
uniform float	uC;	
uniform float	uD;	
const   vec3    uSpecularColor = vec3(1,1,1); 
const   float   uShininess = 20;
const   float   uKa = 0.5, uKd = 0.8, uKs = 0.6;


in vec2  	vST;		// texture coords
in vec3     vN; 
in vec3     vL;
in vec3     vE;

void
main( )
{
	vec3 myColor = vec3(1,1,1);
	//if(vST.x >0.5)
	if(((vST.x - 0.5)*(vST.x - 0.5) +(vST.y - 0.5)*(vST.y - 0.5)) < (uC*uC+ uD*uD) )
	{
		myColor = vec3(0.5,0.1,0);
	}
//----------------Light-------------------
vec3 Normal = normalize(vN); 
vec3 Light  = normalize(vL);
vec3 Eye    = normalize(vE);
vec3 ambient = uKa * myColor; 

float d = max( dot(Normal,Light), 0. );  //only do diffuse if the light can see the point
vec3 diffuse = uKd * d * myColor;

float s = 0.;
if(dot(Normal,Light)>0.)
{
	vec3 ref = normalize(reflect(-Light,Normal));
	s = pow(max(dot(Eye,ref),0.),uShininess);
}
vec3 specular = uKs*s*uSpecularColor;

//----------------------------------------

gl_FragColor = (vec4(ambient+diffuse+ specular,1.f) );
}

