livereloadSnippet = require("grunt-contrib-livereload/lib/utils").livereloadSnippet

mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)

module.exports = (grunt, appConfig) ->

  options:
    hostname: "localhost"

  e2e:
    options:
      port: 9001
      middleware: (connect) ->
        [
          mountFolder(connect, appConfig.dev)
        ]

  livereload:
    options:
      port: 9000
      middleware: (connect) ->
        [
          livereloadSnippet
          mountFolder(connect, appConfig.dev)
        ]
