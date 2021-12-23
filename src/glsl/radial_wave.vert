uniform float time;

varying vec2 vUv;
varying vec3 vNormal;


void main()	{
  vUv = uv;
  vec3 dP = vec3(position.x, 6.0*position.y, position.z);
  float theta = atan(position.y, position.x);
  float r = length(10.0*vec2(position.x, position.y));
  float r_dy = -1.*position.y/max(r, 0.001);
  float r_dx = -1.*position.x/max(r, 0.001);
  

  // float r = length(uv - 0.5);
  
  float height =  0.01*sin(r*20.0 + time);
  float height_dx =  0.01*cos(r*20.0 + time)*r*20.0*r_dx;
  float height_dy =  0.01*cos(r*20.0 + time)*r*20.0*r_dy;;

  vec3 dR = vec3(
    position.x,
    position.y, 
    position.z + height
  );
  vNormal = vec3(
    0.,0.,pow(height - 0.08, 2.)
  ); 

  gl_Position =  projectionMatrix * modelViewMatrix * vec4( dR, 1.0 );
}
        