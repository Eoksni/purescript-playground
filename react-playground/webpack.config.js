const path = require('path');
const copyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  mode: 'development',
  entry: {
    'main/bundle': './src/Main.purs',
    'demo/bundle-demo': './demo/Main.purs'
  },
  output: {
    path: path.join(__dirname, "dist"),
    filename: "[name].js"
    // sourceMapFilename: "index_bundle_demo.js.map"
  },
  plugins: [
    // new copyWebpackPlugin([
    //   { from: 'src/index.html', to: '.' },
    //   { from: "demo/index.html", to: "../dist-demo" },
    // ])
  ],
  devServer: {
    contentBase: [path.join(__dirname, "dist/main"), path.join(__dirname, "dist/demo")],
    port: 8083
  },
  module: {
    rules: [
      {
        test: /\.purs$/,
        use: [
          {
            loader: 'purs-loader',
            options: {
              pscIde: true
            }
          }
        ]
      }
    ]
  }
}
