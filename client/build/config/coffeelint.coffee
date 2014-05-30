module.exports = (grunt) ->

  options:
    max_line_length:
      value: 120
      level: "warn"

  app: ["Gruntfile.coffee", "<%= appConfig.app %>/scripts/**/*.coffee"]
  test: ["<%= appConfig.test %>/**/*.coffee"]
