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

  # compile integration specs
  testIntegration:
    files: [
      expand: true
      cwd: "<%= appConfig.test %>"
      src: [
        "integration/**/*.coffee",
        "protractor-conf.coffee"
      ]
      dest: "<%= appConfig.dev %>/test"
      ext: ".js"
    ]
