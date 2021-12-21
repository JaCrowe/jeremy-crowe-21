<template>
  <div ref="container" class="container" />
  <div class="content"><h1>Jeremy Crowe</h1></div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import * as THREE from "three";
import noodle from "../glsl/noodle.glsl";

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
      objectVertex: `
          varying vec2 vUv;
          uniform float time;
          void main()	{
            vUv = uv;
            gl_Position =  projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
          }
        `,
      trippyVertex: `
          varying vec2 vUv;
          uniform float time;
          void main()	{
            vUv = uv;
            vec3 dP = vec3(position.x, 6.0*position.y, position.z);
            float theta = atan(position.y, position.x);
            vec3 dR = vec3(
              position.x*(sin(theta) + cos(theta)), 
              position.x*(sin(theta) + cos(theta)), 
              position.z);
            gl_Position =  projectionMatrix * modelViewMatrix * vec4( dP, 1.0 );
          }
        `,
      fuckyObjectVertex: `
          varying vec2 vUv;
          uniform float time;
          void main()	{
            vUv = uv;
            vec3 newPosition = vec3(position.x, position.y, position.z + sin(time + vUv.x));
            gl_Position =  projectionMatrix * modelViewMatrix * vec4( newPosition, 1.0 );
          }
        `,
      worldVertex: `
          varying vec2 vUv;
          uniform float time;

          void main()	{
            vUv = uv;
            gl_Position =  position;
          }
        `,
      cheapFragment: `
        void main(){
          gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
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
    setupShaderScene() {
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
          10
        );
        camera.position.z = 1;

        scene = new THREE.Scene();

        geometry = new THREE.PlaneBufferGeometry(
          girth * 2,
          girth * 2,
          256,
          256
        );

        material = new THREE.ShaderMaterial({
          uniforms,
          vertexShader: this.objectVertex,
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
        renderer.render(scene, camera);
      }

      init();
    },
    setupNormalSceneLol() {
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
        camera.position.z = 1;
        scene = new THREE.Scene();
        geometry = new THREE.PlaneBufferGeometry(0.1, 0.1, 256, 256);

        const N_PLANES = 1;

        for (let i = 0; i < N_PLANES; i++) {
          const uniforms: MaterialUniform = { time: { value: Math.random() } };

          console.log(`WE GOT ${noodle}\n\n\n`);

          material = new THREE.ShaderMaterial({
            uniforms,
            vertexShader: noodle,
            fragmentShader: this.cheapFragment,
            side: THREE.DoubleSide,
          });

          mesh = new THREE.Mesh(geometry, material);
          // mesh.position.x = 1.3 * (1 - 2 * Math.random());
          // mesh.position.y = 0.6 * (1 - 2 * Math.random());
          mesh.position.z = 0;

          mesh.rotation.x = 2.0;
          mesh.rotation.z = 2.0;
          // mesh.rotation.x = 2 * Math.PI * Math.random();
          // mesh.rotation.z = 2 * Math.PI * Math.random();
          // mesh.rotation.y = 2 * Math.PI * Math.random();
          scene.add(mesh);
          planes.push({
            mesh,
            uniforms,
            velocity: { x: Math.random(), y: Math.random(), z: Math.random() },
          });
        }

        renderer = new THREE.WebGLRenderer({ antialias: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setAnimationLoop(animation);
        (this.$refs.container as HTMLDivElement).appendChild(
          renderer.domElement
        );
      };
      function animation(time: number) {
        planes.forEach((plane) => {
          const { uniforms, mesh, velocity } = plane;
          const { rotation, position } = mesh;

          uniforms.time.value += 0.01;
          // rotation.x += 0.01;
          // rotation.y += 0.01;
          // position.y -= 0.001 + 0.001 * velocity.y;
          // if (position.y < -0.6) {
          //   position.y += 1.2;
          //   position.x = 2.8 * (0.5 - Math.random());
          // }
        });

        renderer.render(scene, camera);
      }
      init();
    },
  },
  mounted() {
    this.setupNormalSceneLol();
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
}
.content {
  position: relative;
  z-index: 2;
  h1 {
    color: white;
  }
}
</style>
