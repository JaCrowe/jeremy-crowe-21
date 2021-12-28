<template>
  <div ref="container" class="container" />
  <div class="content">
    <h1>Jeremy Crowe</h1>
    <div class="socialLinks">
      <SocialLinks />
    </div>
    <p>Curious guy</p>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import SocialLinks from "../components/SocialLinks.vue";
import * as THREE from "three";
import orthoVert from "../glsl/ortho.vert";
import planeSphereVert from "../glsl/plane_sphere.vert";
// import planeSphereAlmostVert from "../glsl/plane_sphere_almost.vert";
import radialWaveVert from "../glsl/radial_wave.vert";
import radialWaveFrag from "../glsl/radial_wave.frag";
// import sphereFrag from "../glsl/sphere.frag";
import stripeyIdiotFrag from "../glsl/stripey_idiot.frag";
import threeJSExample from "../glsl/three_js_example.frag";

type MaterialUniform = { time: { value: number } };
type ParticleFrameData = {
  uniforms: MaterialUniform;
  mesh: THREE.Mesh;
  velocity: { x: number; y: number; z: number };
};

export default defineComponent({
  name: "Home",
  components: {
    SocialLinks,
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
          vertexShader: orthoVert,
          fragmentShader: threeJSExample,
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
    setupPerspectiveScene() {
      let camera: THREE.PerspectiveCamera,
        scene: THREE.Scene,
        renderer: THREE.WebGLRenderer;
      let geometry: THREE.PlaneBufferGeometry,
        material: THREE.Material,
        mesh: THREE.Mesh;

      const meshes: ParticleFrameData[] = [];

      const init = () => {
        camera = new THREE.PerspectiveCamera(
          70,
          window.innerWidth / window.innerHeight,
          0.01,
          10
        );
        camera.position.z = 0.1;
        camera.position.x = -0.0;
        scene = new THREE.Scene();
        geometry = new THREE.PlaneBufferGeometry(0.1, 0.1, 256, 256);

        const makeWaveyThing = (upsidedown = false) => {
          const uniforms: MaterialUniform = { time: { value: Math.random() } };

          material = new THREE.ShaderMaterial({
            uniforms,
            vertexShader: radialWaveVert,
            fragmentShader: radialWaveFrag,
            side: THREE.DoubleSide,
          });

          mesh = new THREE.Mesh(geometry, material);
          mesh.position.y = upsidedown ? 0.07 : -0.07;

          mesh.rotation.x = upsidedown ? -90.0 : 90.0;

          scene.add(mesh);
          meshes.push({
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
            fragmentShader: stripeyIdiotFrag,
            side: THREE.DoubleSide,
          });

          mesh = new THREE.Mesh(geometry, material);
          // mesh.position.y = 0.03;

          scene.add(mesh);
          meshes.push({
            mesh,
            uniforms,
            velocity: { x: Math.random(), y: Math.random(), z: Math.random() },
          });
        };

        // makeWaveyThing();
        makeplaneSphere();

        function onWindowResize() {
          console.log(`We got ${window.innerHeight}, ${window.innerWidth}`);
          renderer.setSize(window.innerWidth, window.innerHeight, false);
          camera.aspect = window.innerWidth / window.innerHeight;
          camera.updateProjectionMatrix();
        }

        renderer = new THREE.WebGLRenderer({ antialias: true });

        onWindowResize();
        window.addEventListener("resize", onWindowResize);

        renderer.setAnimationLoop(animation);
        (this.$refs.container as HTMLDivElement).appendChild(
          renderer.domElement
        );
      };
      function animation(time: number) {
        meshes.forEach((mesh) => {
          const { uniforms } = mesh;
          uniforms.time.value += 0.01;
        });

        // meshes[0].mesh.rotation.z -= 0.0025;
        meshes[0].mesh.rotation.y -= 0.0025;

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

<style lang="scss" scoped>
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
  text-align: left;
  max-width: 512px;
  margin: 32px;
  z-index: 2;
  h1,
  p {
    color: white;
  }
}
</style>
