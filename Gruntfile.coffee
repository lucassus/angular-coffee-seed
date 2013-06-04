module.exports = (grunt) ->
  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks)

  grunt.initConfig
    watch:
      options:
        livereload: true

      html:
        files: ["./app/**/*.html"]
        tasks: ["copy:dist"]

      css:
        files: ["./app/styles/**/*.css"]
        tasks: ["copy:dist"]

      coffee:
        files: ["./app/scripts/**/*.coffee"]
        tasks: ["coffee:dist"]

      coffeeTest:
        files: ["test/unit/**/*.coffee"]
        tasks: ["coffee:test"]

    coffee:
      dist:
        files: [
          expand: true
          cwd: "./app/scripts"
          src: "**/*.coffee"
          dest: "./dist/scripts"
          ext: ".js"
        ]

      test:
        files: [
          expand: true
          cwd: "./test/unit"
          src: "**/*.coffee"
          dest: "./dist/test"
          ext: ".js"
        ]

    requirejs:
      compile:
        options:
          name: "app"
          baseUrl: "./dist/scripts"
          mainConfigFile: "./dist/scripts/main.js"
          out: "./dist/scripts/dist.js"

    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: "./app"
          dest: "./dist"
          src: [
            "components/**/*"
            "**/*.html"
            "styles/**/*.css"
          ]
        ]

    karma:
      unit:
        configFile: "karma.conf.js"
        singleRun: true

    clean:
      dist: ["./dist"]

    connect:
      server:
        options:
          hostname: "localhost"
          port: 9000
          base: "./dist"

  grunt.registerTask "build", [
    "clean:dist"
    "copy:dist"
    "coffee:dist"
  ]

  grunt.registerTask "server", [
    "build"
    "connect"
    "watch"
  ]

  grunt.registerTask "test", [
    "build"
    "coffee:test"
    "karma:unit"
  ]

  grunt.registerTask "default", ["build"]
