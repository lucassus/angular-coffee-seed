# Produces html-output depending on grunt target

module.exports = (grunt) ->

  test:
    files:
      "<%= appConfig.dev %>/index.html": "<%= appConfig.dev %>/index.html"
