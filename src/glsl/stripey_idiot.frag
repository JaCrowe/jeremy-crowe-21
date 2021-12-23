uniform float time;
varying vec2 vUv;
varying vec3 vNormal;
void main(){
  gl_FragColor = vec4(
    vec3(
      smoothstep(
        0.05,
        -0.05,
        sin(vNormal.z*60.0 + 3.0*time)
      ) - 0.5*vNormal.z
    ),
    1.0
  );
}