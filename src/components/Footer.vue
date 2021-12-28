<template>
  <div ref="container" class="container">
    <span>Social Media</span>
    <div>
      <ul>
        <li v-for="{ link, title } in socialLinks" :key="title">
          <a :href="link">{{ title }}</a>
        </li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { socialLinks } from "./SocialLinks.vue";

export default defineComponent({
  name: "Footer",
  data: () => {
    return { socialLinks };
  },
});
</script>

<style lang="scss" scoped>
p,
li,
div {
  color: white;
}

li {
  margin-right: 16px;
  list-style-type: none;
  a {
    text-decoration: none;
    color: rgb(200, 8200, 200);
    &:visited {
      color: rgb(80, 80, 80);
    }
    &:hover {
      color: rgb(255, 255, 255);
    }
  }
}
div.container {
  span {
    font-weight: bold;
  }

  ul {
    display: flex;
    flex-direction: column;
    text-align: left;
    height: 50px;
    flex-wrap: wrap;
  }

  position: fixed;
  bottom: 0;
  left: 0;
  z-index: 100;
  > ul > li {
    text-align: left;
  }
}
</style>
