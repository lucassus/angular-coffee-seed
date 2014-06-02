module.exports = (grunt) ->

  options:
    dirs: ["<%= appConfig.dist %>"]

  html: [
    "<%= appConfig.dist %>/**/*.html"
    "!<%= appConfig.dist %>/templates/**/*.html"
  ]

  css: ["<%= appConfig.dist %>/styles/**/*.css"]
