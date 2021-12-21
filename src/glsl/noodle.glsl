varying vec2 vUv;
uniform float time;

void main()	{
  vec2 vUv = uv;
  vec3 dP = vec3(position.x, 6.0*position.y, position.z);
  float theta = atan(position.y, position.x);
  vec3 dR = vec3(
    position.x*(sin(theta) + cos(theta)), 
    position.x*(sin(theta) + cos(theta)), 
    position.z
  );
  gl_Position =  projectionMatrix * modelViewMatrix * vec4( dP, 1.0 );
}
        