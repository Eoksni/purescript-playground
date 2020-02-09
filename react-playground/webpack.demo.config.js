const path = require('path');
const copyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  mode: 'development',
  entry: './demo/Main.purs',
  output: {
    path: path.join(__dirname, "dist-demo"),
    filename: "bundle-demo.js"
  },
  plugins: [
    new copyWebpackPlugin([
      { from: 'demo/index.html', to: '.' }
    ])
  ],
  devServer: {
    contentBase: path.join(__dirname, "dist-demo"),
    port: 8082
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
