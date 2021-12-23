uniform float time;
varying vec2 vUv;
varying vec3 vNormal;
void main(){
  gl_FragColor = vec4(
    vec3(
      smoothstep(
        0.15,
        -0.15,
        sin(vNormal.z*160.0)
      ) - 0.5*vNormal.z
    ),
    1.0
  );
}