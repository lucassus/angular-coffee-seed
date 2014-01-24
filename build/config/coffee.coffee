module.exports = (grunt) ->

  # compile coffeescript sources
  dist:
    files: [
      expand: true
      cwd: "<%= appConfig.app %>/scripts"
      src: "**/*.coffee"
      dest: "<%= appConfig.dev %>/scripts"
      ext: ".js"
    ]
