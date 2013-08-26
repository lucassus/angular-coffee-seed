module.exports = (grunt) ->

  dist:
    files:
      "<%= appConfig.dev %>/styles/style.css": "<%= appConfig.app %>/styles/style.less"
