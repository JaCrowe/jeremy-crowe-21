<template>
  <div class="socialContainer">
    <a
      rel="me"
      v-for="{ alt, link, src, classes } in socialLinks"
      :href="link"
      :key="alt"
      class="socialLink"
    >
      <img
        :src="`${publicPath}${src}`"
        :alt="alt"
        :class="`socialIcon${classes ?? ''}`"
      />
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
          classes: " trimmed",
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
          classes: " trimmed",
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
  justify-content: flex-start;
}

$colorOne: rgba(255, 255, 255, 1);
$colorTwo: rgba(205, 205, 205, 1);

a.socialLink {
  background-image: linear-gradient(150deg, $colorOne, $colorOne);
  margin-right: 8px;
  padding: 4px;
  width: 24px;
  height: 24px;
  border-radius: 100%;

  .socialIcon {
    width: 100%;
    height: 100%;
    &.trimmed {
      border-radius: 100%;
    }
    // margin-right: 8px;
    //padding: 4px;
    // border-radius: 100%;
    //border-radius: 2px;
    // box-shadow: 0px 0px 3px black;
    transition: box-shadow 0.25s, transform 0.25s;
    // transform: translate(-0px, -0px);
    &:hover {
      // transform: translate(-3px, -3px);
      //box-shadow: -3px -2px 0px white;
      // background-image: linear-gradient(100deg, $colorOne, $colorTwo);
    }
  }
}
</style>
