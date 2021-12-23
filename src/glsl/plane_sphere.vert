#define PI 3.14159
#define sqrttwo 1.41421
uniform float time;

varying vec2 vUv;
varying vec3 vNormal;

void main()	{
  vUv = uv;

  vec2 uv_c = uv - 0.5;

  float theta = atan(uv_c.y, uv_c.x);
  float radius_uv = 2.0*max(
    abs(uv_c.x), 
    abs(uv_c.y)
  );
  float phi = radius_uv*PI;

  vec3 sphere_coords = 0.03*vec3(
    sin(phi)*cos(theta),
    sin(phi)*sin(theta),
    cos(phi)
  );

  float alpha = (1.0 - min(
    1.,
    max(
      -1., 
      -10.0*cos(time/5.0)
    )
  ))/2.;

  vec3 real_coords = alpha*sphere_coords 
    + (0.7 - 0.7*alpha)*position;

  vNormal = vec3(
    0.,
    0.,
    (alpha*radius_uv +
      (1.0 - alpha)*length(uv_c)
    )
  ); 

  gl_Position =  projectionMatrix * modelViewMatrix * vec4( real_coords, 1.0 );
}
        