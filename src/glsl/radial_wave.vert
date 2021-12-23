uniform float time;

varying vec2 vUv;
varying vec3 vNormal;


void main()	{
  vUv = uv;
  float theta = atan(position.y, position.x);
  
  float r = length(
    10.0*vec2(
      position.x,
      position.y
    )
  );
    
  float height =  0.01*sin(r*20.0 + time);

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
        