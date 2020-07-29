const webpack = require("webpack");

module.exports = {
    configureWebpack: {
        module: {
            rules: [
                {
                    test: /\.coffee$/,
                    loader: 'coffee-loader',
                }
            ]
        },
        plugins: [
            new webpack.DefinePlugin({
                __VUE_OPTIONS_API__: false,
                __VUE_PROD_DEVTOOLS__: true
            })
        ],
        devServer: {
            compress: true,
            disableHostCheck: true
        }
    },
    productionSourceMap: false
};
