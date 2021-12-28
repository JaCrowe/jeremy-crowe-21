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
  title: string;
  classes?: string;
};

export const socialLinks: SocialLink[] = [
  {
    title: "Github",
    link: "https://github.com/JaCrowe",
    src: "/images/github.svg",
    alt: "Jeremy Crowe's github account",
  },
  {
    title: "LinkedIn",
    link: "https://linkedin.com/in/jeremyacrowe/",
    src: "/images/linkedin.svg",
    alt: "Jeremy Crowe's LinkedIn profile",
    classes: " trimmed",
  },
  {
    title: "Instagram",
    link: "https://instagram.com/_crowe_magnon/",
    src: "/images/instagram.svg",
    alt: "Jeremy Crowe's Instagram profile",
  },
  {
    title: "Twitter",
    link: "https://www.twitter.com/_crowe_magnon/",
    src: "/images/twitter.svg",
    alt: "Jeremy Crowe's Twitter profile",
  },
  {
    title: "Shadertoy",
    link: "https://www.shadertoy.com/user/crowemagnon",
    src: "/images/shadertoy.png",
    alt: "Jeremy Crowe's Shadertoy profile",
    classes: " trimmed",
  },
  {
    title: "Solid Community",
    link: "https://jacrowe.solidcommunity.net/profile/card#me",
    src: "/images/solidproject.svg",
    alt: "Jeremy Crowe's Solid @solidcommunity.net account",
  },
  {
    title: "Mastodon",
    link: "https://mastodon.online/@JaCrowe",
    src: "/images/mastodon.svg",
    alt: "Jeremy Crowe's Mastodon @mastodon.online account",
  },
  {
    title: "Pixelfed",
    link: "https://pixelfed.social/JaCrowe",
    src: "/images/pixelfed-icon-color.svg",
    alt: "Jeremy Crowe's Pixelfed @pixelfed.social account",
  },
  {
    title: "Matrix Element",
    link: "https://matrix.to/#/@jacrowe:matrix.org",
    src: "/images/element.svg",
    alt: "Jeremy Crowe's element chat account",
  },
];

export default defineComponent({
  data: () => {
    return {
      publicPath: "", //process.env.BASE_URL,
      socialLinks,
    } as { socialLinks: SocialLink[] };
  },
});
</script>

<style lang="scss" scoped>
.socialContainer {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  width: 100%;
  max-width: 500px;
  justify-content: flex-start;
}

$colorOne: rgba(255, 255, 255, 1);
$colorTwo: rgba(200, 200, 200, 1);
$colorThree: rgba(80, 80, 80, 1);

a.socialLink {
  background-image: linear-gradient(150deg, $colorThree, $colorOne);
  margin: 0 8px 8px 0;
  padding: 4px;
  width: 24px;
  height: 24px;
  border-radius: 100%;
  transition: background-image 2s;

  &:hover {
    background-image: linear-gradient(150deg, $colorTwo, $colorOne);
  }

  .socialIcon {
    width: 100%;
    height: 100%;
    &.trimmed {
      border-radius: 100%;
    }
  }
}
</style>
