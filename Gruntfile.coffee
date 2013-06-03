module.exports = (grunt) ->
  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks)

  grunt.initConfig
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
          src: ["*.{ico,txt,html}", ".htaccess", "components/**/*", "images/{,*/}*.{gif,webp}", "styles/fonts/*"]
        ]

    connect:
      server:
        options:
          hostname: "localhost"
          port: 9000
          base: "./dist"
          keepalive: true

  grunt.registerTask "build", [
    "copy:dist",
    "coffee:dist"
  ]

  grunt.registerTask "server", [
    "build",
    "connect"
  ]

  grunt.registerTask "default", ["build"]
