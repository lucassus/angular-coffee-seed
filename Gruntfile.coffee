module.exports = (grunt) ->
  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks)

  grunt.initConfig
    watch:
      options:
        livereload: true

      html:
        files: ["./app/{,*/}*.html"]
        tasks: ["copy:dist"]

      coffee:
        files: ["./app/scripts/{,*/}*.coffee"]
        tasks: ["coffee:dist"]

    coffee:
      dist:
        files: [
          expand: true
          cwd: "./app/scripts"
          src: "{,*/}*.coffee"
          dest: "./dist/scripts"
          ext: ".js"
        ]

    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: "./app"
          dest: "./dist"
          src: ["index.html", "components/**/*"]
        ]

    connect:
      server:
        options:
          hostname: "localhost"
          port: 9000
          base: "./dist"

  grunt.registerTask "build", [
    "copy:dist",
    "coffee:dist"
  ]

  grunt.registerTask "server", [
    "build",
    "connect",
    "watch"
  ]

  grunt.registerTask "default", ["build"]
