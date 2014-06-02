module.exports = (grunt) ->

  # compile coffeescript sources
  dev:
    options:
      sourceMap: true

    files: [
      expand: true
      cwd: "<%= appConfig.dev %>/scripts"
      src: "**/*.coffee"
      dest: "<%= appConfig.dev %>/scripts"
      ext: ".js"
    ]
