# Compile LESS files to CSS

module.exports = (grunt) ->

  dist:
    files:
      "<%= appConfig.dev %>/styles/style.css": "<%= appConfig.app %>/styles/style.less"
      "<%= appConfig.dev %>/styles/animation.css": "<%= appConfig.app %>/styles/animation.less"
