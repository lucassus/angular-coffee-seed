module.exports = (grunt) ->
  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks)

  grunt.initConfig
    connect:
      server:
        options:
          hostname: "localhost"
          port: 9000
          base: "./app"
          keepalive: true

  grunt.registerTask "default", []
