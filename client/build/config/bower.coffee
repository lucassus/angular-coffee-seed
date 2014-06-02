module.exports = (grunt) ->

  install:
    options:
      targetDir: "<%= appConfig.dev %>/components"
      layout: "byComponent"
      cleanTargetDir: true
      install: false
