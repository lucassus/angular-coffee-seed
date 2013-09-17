module.exports = (grunt) ->

  # Grunt build task to concatenate & pre-load your AngularJS templates
  # https://github.com/ericclemmons/grunt-angular-templates

  options:
    # strinp `app/` prefix from the path
    url: (url) -> url.replace /^app\//, ""

    module: "myApp.templates"
    standalone: true

    htmlmin:
      collapseWhitespace: true,
      collapseBooleanAttributes: true

  app:
    src: [
      "<%= appConfig.app %>/templates/**/*.html"
      "<%= appConfig.app %>/views/**/*.html"
    ]
    dest: "<%= appConfig.dev %>/scripts/templates.js"
