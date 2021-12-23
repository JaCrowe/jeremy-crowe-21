<template>
  <div ref="container" class="container" />
  <div class="content">
    <h1>Jeremy Crowe</h1>
    <p>
      "Jeremy says sentances that no one has ever said before" - My favorite
      quote about me right now
    </p>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import * as THREE from "three";
import planeSphereVert from "../glsl/plane_sphere.vert";
import planeSphereAlmostVert from "../glsl/plane_sphere_almost.vert";
import radialWave from "../glsl/radial_wave.vert";

type MaterialUniform = { time: { value: number } };
type ParticleFrameData = {
  uniforms: MaterialUniform;
  mesh: THREE.Mesh;
  velocity: { x: number; y: number; z: number };
};

export default defineComponent({
  name: "Home",
  data() {
    return {
      radialWave: `
uniform float time;
varying vec2 vUv;
varying vec3 vNormal;
void main(){
 gl_FragColor = vec4(vec3(100.0*vNormal.z), 1.0);
}
`,
      sphere: `
uniform float time;
varying vec2 vUv;
varying vec3 vNormal;
void main(){
 gl_FragColor = vec4(vec3(vNormal.z), 1.0);
}
`,
      stripeyIdiot: `
uniform float time;
varying vec2 vUv;
varying vec3 vNormal;
void main(){
  gl_FragColor = vec4(
    vec3(
      smoothstep(
        0.6,
        0.5,
        sin(vNormal.z*100.0)
      ) - vNormal.z
    ),
    1.0
  );
}
`,
      swirlyFragment: `
          varying vec2 vUv;

          uniform float time;

          void main()	{

            vec2 p = - 1.0 + 2.0 * vUv;
            float a = time * 40.0;
            float d, e, f, g = 1.0 / 40.0 ,h ,i ,r ,q;

            e = 400.0 * ( p.x * 0.5 + 0.5 );
            f = 400.0 * ( p.y * 0.5 + 0.5 );
            i = 200.0 + sin( e * g + a / 150.0 ) * 20.0;
            d = 200.0 + cos( f * g / 2.0 ) * 18.0 + cos( e * g ) * 7.0;
            r = sqrt( pow( abs( i - e ), 2.0 ) + pow( abs( d - f ), 2.0 ) );
            q = f / r;
            e = ( r * cos( q ) ) - a / 2.0;
            f = ( r * sin( q ) ) - a / 2.0;
            d = sin( e * g ) * 176.0 + sin( e * g ) * 164.0 + r;
            h = ( ( f + d ) + a / 2.0 ) * g;
            i = cos( h + r * p.x / 1.3 ) * ( e + e + a ) + cos( q * g * 6.0 ) * ( r + h / 3.0 );
            h = sin( f * g ) * 144.0 - sin( e * g ) * 212.0 * p.x;
            h = ( h + ( f - e ) * q + sin( r - ( a + h ) / 7.0 ) * 10.0 + i / 4.0 ) * g;
            i += cos( h * 2.3 * sin( a / 350.0 - q ) ) * 184.0 * sin( q - ( r * 4.3 + a / 12.0 ) * g ) + tan( r * g + h ) * 184.0 * cos( r * g + h );
            i = mod( i / 5.6, 256.0 ) / 64.0;
            if ( i < 0.0 ) i += 4.0;
            if ( i >= 2.0 ) i = 4.0 - i;
            d = r / 350.0;
            d += sin( d * d * 8.0 ) * 0.52;
            f = ( sin( a * g ) + 1.0 ) / 2.0;
            gl_FragColor = vec4( vec3( f * i / 1.6, i / 2.0 + d / 13.0, i ) * d * p.x + vec3( i / 1.3 + d / 8.0, i / 2.0 + d / 18.0, i ) * d * ( 1.0 - p.x ), 1.0 );
          }
        `,
    };
  },
  methods: {
    setupOrthoShaderScene() {
      let camera: THREE.Camera,
        scene: THREE.Scene,
        renderer: THREE.WebGLRenderer;
      let geometry: THREE.PlaneGeometry,
        material: THREE.Material,
        mesh: THREE.Mesh;

      const uniforms: MaterialUniform = { time: { value: 0 } };

      const init = () => {
        const aspect = window.innerWidth / window.innerHeight;
        const girth = 1;
        camera = new THREE.OrthographicCamera(
          -girth,
          girth,
          -girth / aspect,
          girth / aspect,
          0.01,
          70
        );
        camera.position.z = 0.5;

        scene = new THREE.Scene();

        geometry = new THREE.PlaneBufferGeometry(
          girth * 2,
          girth * 2,
          256,
          256
        );

        material = new THREE.ShaderMaterial({
          uniforms,
          vertexShader: planeSphereVert,
          fragmentShader: this.swirlyFragment,
        });

        mesh = new THREE.Mesh(geometry, material);
        scene.add(mesh);

        renderer = new THREE.WebGLRenderer({ antialias: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setAnimationLoop(animation);

        (this.$refs.container as HTMLDivElement).appendChild(
          renderer.domElement
        );
      };

      function animation(time: number) {
        uniforms.time.value += 0.01;
        mesh.rotation.y += 0.8;
        renderer.render(scene, camera);
      }

      init();
    },
    setupPerspectiveScene() {
      let camera: THREE.Camera,
        scene: THREE.Scene,
        renderer: THREE.WebGLRenderer;
      let geometry: THREE.PlaneBufferGeometry,
        material: THREE.Material,
        mesh: THREE.Mesh;

      const planes: ParticleFrameData[] = [];

      const init = () => {
        camera = new THREE.PerspectiveCamera(
          70,
          window.innerWidth / window.innerHeight,
          0.01,
          10
        );
        camera.position.z = 0.12;
        camera.position.x = -0.0125;
        scene = new THREE.Scene();
        geometry = new THREE.PlaneBufferGeometry(0.1, 0.1, 256, 256);

        const makeWaveyThing = () => {
          const uniforms: MaterialUniform = { time: { value: Math.random() } };

          material = new THREE.ShaderMaterial({
            uniforms,
            vertexShader: radialWave,
            fragmentShader: this.radialWave,
            side: THREE.DoubleSide,
          });

          mesh = new THREE.Mesh(geometry, material);
          mesh.position.y = -0.01;

          mesh.rotation.x = 90.0;

          scene.add(mesh);
          planes.push({
            mesh,
            uniforms,
            velocity: { x: Math.random(), y: Math.random(), z: Math.random() },
          });
        };
        const makeplaneSphere = () => {
          const uniforms: MaterialUniform = { time: { value: Math.random() } };

          material = new THREE.ShaderMaterial({
            uniforms,
            vertexShader: planeSphereVert,
            // vertexShader: planeSphereAlmostVert,
            fragmentShader: this.stripeyIdiot,
            side: THREE.DoubleSide,
          });

          mesh = new THREE.Mesh(geometry, material);
          mesh.position.x = -0.08;
          mesh.position.y = 0.02;
          mesh.position.z = 0;

          // mesh.rotation.z = 2.0;
          mesh.rotation.y = 180.0;
          scene.add(mesh);
          planes.push({
            mesh,
            uniforms,
            velocity: { x: Math.random(), y: Math.random(), z: Math.random() },
          });
        };

        makeWaveyThing();
        makeplaneSphere();

        renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setAnimationLoop(animation);
        (this.$refs.container as HTMLDivElement).appendChild(
          renderer.domElement
        );
      };
      function animation(time: number) {
        planes.forEach((plane) => {
          const { uniforms, mesh, velocity } = plane;
          // const { rotation, position } = mesh;
          uniforms.time.value += 0.01;
        });

        planes[1].mesh.rotation.z += 0.0025;

        renderer.render(scene, camera);
      }
      init();
    },
  },
  mounted() {
    // this.setupOrthoShaderScene();
    this.setupPerspectiveScene();
  },
});
</script>

<style lang="scss">
.container {
  width: 100vw;
  height: 100vh;
  position: fixed;
  top: 0;
  left: 0;
  margin: 0;
  padding: 0;
  z-index: 1;
  background-color: black;
}
.content {
  position: relative;
  z-index: 2;
  h1,
  p {
    color: white;
  }
}
</style>
