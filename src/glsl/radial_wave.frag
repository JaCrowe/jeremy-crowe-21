uniform float time;
varying vec2 vUv;
varying vec3 vNormal;
void main(){
 gl_FragColor = vec4(vec3(100.0*vNormal.z), 1.0);
}