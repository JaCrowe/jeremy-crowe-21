module.exports = {
  chainWebpack: (config) => {
    config.module
      .rule("shaders")
      .test(/\.(vert|frag)$/)
      .use("raw-loader")
      .loader("raw-loader")
      .end();
  },
};
