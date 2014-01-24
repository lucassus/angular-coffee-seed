module.exports = (grunt) ->

  # Preprocess files based off environment configuration

  env = grunt.option("env") or "development"
  useMocks = grunt.option("useMocks") or false

  env:
    src: [
      "<%= appConfig.dev %>/scripts/application.js"
      "<%= appConfig.dev %>/index.html"
    ]

    options:
      inline: true
      context:
        ENV: env
        USE_MOCKS: useMocks
