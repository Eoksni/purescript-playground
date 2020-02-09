const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
  mode: 'development',
  entry: {
    'main': './src/Main.purs',
    'demo/main': './demo/Main.purs',
    '../dist-demo/main': './demo/Main.purs'
  },
  plugins: [
    new HtmlWebpackPlugin({ template: path.join(__dirname, 'src', 'index.ejs') })
  ],
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
