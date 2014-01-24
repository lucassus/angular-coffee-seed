livereloadSnippet = require("grunt-contrib-livereload/lib/utils").livereloadSnippet
proxySnippet = require("grunt-connect-proxy/lib/utils").proxyRequest

mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)

module.exports = (grunt, appConfig) ->

  env = grunt.option("env") or "development"
  port = if env is "test" then 9001 else 9000

  options:
    hostname: "localhost"

  proxies: [
    context: "/api"
    host: "localhost"
    port: 5000
    https: false
    changeOrigin: false
  ]

  livereload:
    options:
      port: port
      middleware: (connect) ->
        [
          livereloadSnippet
          proxySnippet
          mountFolder(connect, appConfig.dev)
        ]
