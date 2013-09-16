module.exports = (grunt) ->

  options:
    base: "<%= appConfig.app %>"
    module:
      name: "myApp.templates"
      define: true
    htmlmin:
      collapseWhitespace: true,
      collapseBooleanAttributes: true

  myApp:
    src: [
      "<%= appConfig.app %>/templates/**/*.html"
      "<%= appConfig.app %>/views/**/*.html"
    ]
    dest: "<%= appConfig.dev %>/scripts/templates.js"
