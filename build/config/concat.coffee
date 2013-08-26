module.exports = (grunt) ->

  dist:
    files:
      "<%= appConfig.dev %>/scripts/scripts.js": [
        "<%= appConfig.dev %>/scripts/**/*.js"
        "<%= appConfig.app %>/scripts/**/*.js"
      ]
