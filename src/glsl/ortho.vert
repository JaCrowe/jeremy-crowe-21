uniform float time;

varying vec2 vUv;
varying vec3 vNormal;


void main()	{
  vUv = uv;
  gl_Position =  vec4(position, 1.0);
}
        