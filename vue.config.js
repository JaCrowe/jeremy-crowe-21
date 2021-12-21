module.exports = {
  chainWebpack: (config) => {
    config.module
      .rule("glsl")
      .test(/\.glsl$/)
      .use("raw-loader")
      .loader("raw-loader")
      .end();
  },
};
