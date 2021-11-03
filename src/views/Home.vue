<template>
  <h1>Jeremy Crowe</h1>
  <div ref="container" class="container" />
</template>

<script lang="ts">
import { defineComponent } from "vue";
import * as THREE from "three";

export default defineComponent({
  name: "Home",
  mounted() {
    let camera: THREE.Camera, scene: THREE.Scene, renderer: THREE.WebGLRenderer;
    let geometry: THREE.BoxGeometry, material: THREE.Material, mesh: THREE.Mesh;

    const init = () => {
      camera = new THREE.PerspectiveCamera(
        70,
        window.innerWidth / window.innerHeight,
        0.01,
        10
      );
      camera.position.z = 1;

      scene = new THREE.Scene();

      geometry = new THREE.BoxGeometry(0.2, 0.2, 0.2);
      material = new THREE.MeshNormalMaterial();

      mesh = new THREE.Mesh(geometry, material);
      scene.add(mesh);

      renderer = new THREE.WebGLRenderer({ antialias: true });
      renderer.setSize(window.innerWidth / 4, window.innerHeight / 4);
      renderer.setAnimationLoop(animation);

      (this.$refs.container as HTMLDivElement).appendChild(renderer.domElement);
    };

    function animation(time: number) {
      mesh.rotation.x = time / 2000;
      mesh.rotation.y = time / 1000;

      renderer.render(scene, camera);
    }

    init();
  },
});
</script>

<style lang="scss">
.container {
  width: 100%;
  margin: auto;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
