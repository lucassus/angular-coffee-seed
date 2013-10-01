module.exports = (grunt) ->

  coffee:
    files: [
      "<%= appConfig.app %>/scripts/**/*.coffee"
      "<%= appConfig.test %>/**/*.coffee"
    ]
    tasks: [
      "coffee:dist"
      "coffee:test"
      "ngtemplates"
      "timestamp"
    ]

  html:
    files: [
      "<%= appConfig.app %>/**/*.html"
      "!<%= appConfig.app %>/templates/**/*.html"
    ]
    tasks: ["copy:dev", "timestamp"]

  templates:
    files: ["<%= appConfig.app %>/templates/**/*.html"]
    tasks: ["ngtemplates", "timestamp"]

  css:
    files: ["<%= appConfig.app %>/styles/**/*.less"]
    tasks: ["less", "timestamp"]

  livereload:
    files: ["<%= appConfig.dev %>/**/*"]
    tasks: ["livereload", "timestamp"]
