var path = require("path");
var HtmlWebpackPlugin = require("html-webpack-plugin");
var ExtractTextPlugin = require("extract-text-webpack-plugin");

// Purescript Config
var psc = {
  srcs: [ "src[]=bower_components/purescript-*/src/**/*.purs",
          "src[]=src/**/*.purs",
          "src[]=ex/**/*.purs" ],
  ffis: [ "ffi[]=bower_components/purescript-*/src/**/*.js",
          "ffi[]=src/**/*.js",
          "ffi[]=ex/**/*.js"],
  output: "output"
};

module.exports = {

  entry: "./ex/index.js",
  output: {
    path: path.join(__dirname, "public"),
    filename: "app.js"
  },

  module: {
    loaders: [
      {
        test: /\.purs$/,
        loader: "purs-loader?output=" + psc.output + "&" + psc.srcs.concat(psc.ffis).join("&")
      }
    ]
  },

  resolve: {
    modulesDirectories: [
      "node_modules",
      "ex"
    ],
    extensions: ["", ".js"]
  },

  plugins: [
    new ExtractTextPlugin("styles.css"),
    new HtmlWebpackPlugin({
      title: "Purs Test",
      hash: true,
      template: "./ex/index.html",
      inject: "body"
    })
  ],

  devServer: {
    contentBase: "./public",
    historyApiFallback: true
  }
}
