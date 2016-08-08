var path = require("path");

var SRC_DIR = "./web/static";
var JS_SRC_DIR = SRC_DIR + "/js";

var DEST_DIR = "./priv/static";

module.exports = {
  entry: JS_SRC_DIR + "/app.js",

  resolve: {
    extensions: ["", ".js", ".jsx"]
  },

  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        loader: ["babel-loader"],
        exclude: /(node_modules|bower_components)/,
        query: {
          presets: ['es2015', 'react']
        },
        include: path.resolve(JS_SRC_DIR)
      },
      {
        test: /\.less$/,
        loader: 'style!css!autoprefixer?{browsers: ["last 3 versions", "safari 5", "ie 8", "ie 9", "opera 12.1", "ios 6", "android 4"]}!less',
        include: path.resolve(SRC_DIR)
      }
    ]
  },

  output: {
    path: DEST_DIR + "/js",
    filename: "app.js"
  }
};
