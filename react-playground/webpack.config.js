const path = require('path');
const copyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  mode: 'development',
  entry: './src/Main.purs',
  output: {
    path: path.join(__dirname, "dist"),
    filename: "bundle.js"
  },
  plugins: [
    new copyWebpackPlugin([
      { from: 'src/index.html', to: '.' }
    ])
  ],
  devServer: {
    contentBase: path.join(__dirname, "dist"),
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
