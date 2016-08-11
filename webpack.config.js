var webpack = require('webpack');
var path = require("path");
var autoprefixer = require('autoprefixer');

var SRC_DIR = "./web/static";
var JS_SRC_DIR = SRC_DIR + "/js";
var CSS_SRC_DIR = SRC_DIR + "/css";

var DEST_DIR = "./priv/static";

module.exports = {
  entry: {
    "app": ["./web/static/css/app.less", "./web/static/js/app.js"],
    "chat": ["./web/static/js/socket.js"]
  },

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
        test: /\.css$/,
        loader: 'style-loader!css-loader!postcss-loader',
        include: path.resolve(CSS_SRC_DIR)
      },
      {
        test: /\.less$/,
        loader: 'style-loader!css-loader!postcss-loader!less',
        include: path.resolve(CSS_SRC_DIR)
      }
    ]
  },

  postcss: function() {
    return {
      defaults: [autoprefixer],
      cleaner: [autoprefixer({browsers: ["last 3 versions", "safari 5", "ie 8", "ie 9", "opera 12.1", "ios 6", "android 4"]})]
    };
  },

  plugins: [
    new webpack.optimize.CommonsChunkPlugin('chat', 'chat.js', Infinity)
  ],

  output: {
    path: DEST_DIR + "/js",
    filename: "app.js"
  }
};
