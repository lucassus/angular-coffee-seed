module.exports = (grunt) ->

  options:
    dest: "<%= appConfig.dist %>"

  html: [
    "<%= appConfig.dev %>/**/*.html"
    "!<%= appConfig.dev %>/templates/**/*.html"
  ]
