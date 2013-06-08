module.exports = (grunt) ->
  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks)

  # Extract browsers list from the command line
  # For example `grunt test --browsers=Chrome,Firefox`
  # Currently available browsers:
  # - Chrome
  # - ChromeCanary
  # - Firefox
  # - Opera
  # - Safari (only Mac)
  # - PhantomJS
  # - IE (only Windows)
  parseBrowsers = (opts = {}) ->
    opts.defaultBrowser or= "PhantomJS"

    browsers = grunt.option("browsers") || opts.defaultBrowser
    browsers = browsers.replace(/[\s\[\]]/, "")
    browsers.split(",")

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
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
        tasks: ["coffee:dist", "browserify2:dist"]

      coffeeTest:
        files: ["test/**/*.coffee"]
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
          cwd: "./test"
          src: "**/*.coffee"
          dest: "./dist/test"
          ext: ".js"
        ]

    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: "./app"
          dest: "./dist"
          src: [
            "**/*.html"
            "styles/**/*.css"
          ]
        ]

    browserify2:
      dist:
        entry: "./dist/scripts/application.js"
        compile: "./dist/scripts/<%= pkg.name %>.js"

    bower:
      install:
        options:
          targetDir: "./dist/components"
          install: false

    karma:
      options:
        configFile: "./test/karma.conf.js"
        browsers: parseBrowsers(defaultBrowser: "PhantomJS")

      unit:
        singleRun: true

      e2e:
        configFile: "./test/karma-e2e.conf.js"
        singleRun: true

      watch:
        singleRun: false
        autoWatch: true

    clean:
      dist: ["./dist"]

    connect:
      options:
        hostname: "localhost"
        base: "./dist"

      server:
        options: port: 9000

      e2e:
        options: port: 9001

  grunt.registerTask "build", [
    "clean:dist"
    "bower:install"
    "copy:dist"
    "coffee:dist"
    "browserify2:dist"
  ]

  grunt.registerTask "server", [
    "build"
    "coffee:test"
    "connect"
    "watch"
  ]

  grunt.registerTask "test", [
    "build"
    "coffee:test"
    "karma:unit"
  ]

  grunt.registerTask "test:e2e", [
    "build"
    "coffee:test"
    "connect:e2e"
    "karma:e2e"
  ]

  grunt.registerTask "test:watch", [
    "build"
    "coffee:test"
    "karma:watch"
  ]

  grunt.registerTask "default", ["build"]
