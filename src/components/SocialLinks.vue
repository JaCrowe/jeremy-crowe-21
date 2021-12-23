<template>
  <div class="socialContainer">
    <a
      rel="me"
      v-for="{ alt, link, src } in socialLinks"
      :href="link"
      :key="alt"
    >
      <img :src="`${publicPath}${src}`" :alt="alt" class="socialIcon" />
    </a>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";

type SocialLink = {
  link: string;
  src: string;
  alt: string;
};

export default defineComponent({
  data: () => {
    return {
      publicPath: "", //process.env.BASE_URL,
      socialLinks: [
        {
          link: "https://github.com/JaCrowe",
          src: "/images/github.svg",
          alt: "Jeremy Crowe's github account",
        },
        {
          link: "https://linkedin.com/in/jeremyacrowe/",
          src: "/images/linkedin.svg",
          alt: "Jeremy Crowe's LinkedIn profile",
        },
        {
          link: "https://instagram.com/_crowe_magnon/",
          src: "/images/instagram.svg",
          alt: "Jeremy Crowe's Instagram profile",
        },
        {
          link: "https://www.twitter.com/_crowe_magnon/",
          src: "/images/twitter.svg",
          alt: "Jeremy Crowe's Twitter profile",
        },
        {
          link: "https://www.shadertoy.com/user/crowemagnon",
          src: "/images/shadertoy.png",
          alt: "Jeremy Crowe's Shadertoy profile",
        },
        {
          link: "https://jacrowe.solidcommunity.net/profile/card#me",
          src: "/images/solidproject.svg",
          alt: "Jeremy Crowe's Solid @solidcommunity.net account",
        },
        {
          link: "https://mastodon.online/@JaCrowe",
          src: "/images/mastodon.svg",
          alt: "Jeremy Crowe's Mastodon @mastodon.online account",
        },
        {
          link: "https://pixelfed.social/JaCrowe",
          src: "/images/pixelfed-icon-color.svg",
          alt: "Jeremy Crowe's Pixelfed @pixelfed.social account",
        },
        {
          link: "https://matrix.to/#/@jacrowe:matrix.org",
          src: "/images/element.svg",
          alt: "Jeremy Crowe's element chat account",
        },
      ],
    } as { socialLinks: SocialLink[] };
  },
});
</script>

<style lang="scss" scoped>
.socialContainer {
  display: flex;
  flex-direction: row;
  width: 100%;
  max-width: 500px;
  justify-content: center;
}
.socialIcon {
  width: 32px;
  height: 32px;
  margin: 4px;
  padding: 8px;
  border-radius: 8px;
  background-image: linear-gradient(
    rgba(50, 50, 50, 0.5),
    rgba(150, 150, 150, 0.5)
  );
}
</style>
