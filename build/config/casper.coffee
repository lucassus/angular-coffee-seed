module.exports = (grunt) ->

  files: [
    "<%= appConfig.dev %>/test/casperjs/**/*_scenario.js"
  ]
