livereloadSnippet = require("grunt-contrib-livereload/lib/utils").livereloadSnippet
proxySnippet = require("grunt-connect-proxy/lib/utils").proxyRequest

mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)

module.exports = (grunt, appConfig) ->

  options:
    hostname: "localhost"

  proxies: [
    context: "/api"
    host: "localhost"
    port: 5000
    https: false
    changeOrigin: false
  ]

  integration:
    options:
      port: 9010
      middleware: (connect) ->
        [
          proxySnippet
          mountFolder(connect, appConfig.dev)
        ]

  livereload:
    options:
      port: 9000
      middleware: (connect) ->
        [
          livereloadSnippet
          proxySnippet
          mountFolder(connect, appConfig.dev)
        ]
