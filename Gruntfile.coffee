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
    pkg: grunt.file.readJSON("package.json")
    appConfig:
      app: "./app"
      test: "./test"
      dist: "./dist"

    watch:
      options:
        livereload: true

      html:
        files: ["<%= appConfig.app %>/**/*.html"]
        tasks: ["copy:dist"]

      templates:
        files: ["<%= appConfig.app %>/templates/**/*.tpl.html"]
        tasks: ["html2js"]

      css:
        files: ["<%= appConfig.app %>/styles/**/*.scss"]
        tasks: ["sass:dist"]

      coffee:
        files: ["<%= appConfig.app %>/scripts/**/*.coffee"]
        tasks: ["coffee:dist", "browserify2:dist"]

      coffeeTest:
        files: ["<%= appConfig.test %>/**/*.coffee"]
        tasks: ["coffee:test"]

    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= appConfig.app %>/scripts"
          src: "**/*.coffee"
          dest: "<%= appConfig.dist %>/scripts"
          ext: ".js"
        ]

      test:
        files: [
          expand: true
          cwd: "<%= appConfig.test %>"
          src: "**/*.coffee"
          dest: "<%= appConfig.dist %>/test"
          ext: ".js"
        ]

    sass:
      dist:
        files:
          "<%= appConfig.dist %>/styles/style.css": "<%= appConfig.app %>/styles/style.scss"

    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: "<%= appConfig.app %>"
          dest: "<%= appConfig.dist %>"
          src: [
            "**/*.html"
          ]
        ]

    coffeelint:
      options:
        max_line_length:
          value: 120
          level: "warn"

      app: ["Gruntfile.coffee", "<%= appConfig.app %>/scripts/**/*.coffee"]
      test: ["<%= appConfig.test %>/**/*.coffee"]

    browserify2:
      dist:
        entry: "<%= appConfig.dist %>/scripts/application.js"
        compile: "<%= appConfig.dist %>/scripts/<%= pkg.name %>.js"

    html2js:
      options:
        base: "app"
      main:
        src: ["<%= appConfig.app %>/templates/**/*.tpl.html"]
        dest: "<%= appConfig.dist %>/scripts/templates.js"

    bower:
      install:
        options:
          targetDir: "<%= appConfig.dist %>/components"
          install: false

    karma:
      options:
        configFile: "<%= appConfig.test %>/karma.conf.js"
        browsers: parseBrowsers(defaultBrowser: "PhantomJS")

      unit:
        singleRun: true

      e2e:
        configFile: "<%= appConfig.test %>/karma-e2e.conf.js"
        singleRun: true

      watch:
        singleRun: false
        autoWatch: true

    clean:
      dist: ["<%= appConfig.dist %>"]

    connect:
      options:
        hostname: "localhost"
        base: "<%= appConfig.dist %>"

      server:
        options: port: 9000

      e2e:
        options: port: 9001

  grunt.registerTask "build", [
    "clean:dist"
    "coffeelint"
    "bower:install"
    "copy:dist"
    "coffee:dist"
    "sass:dist"
    "browserify2:dist"
    "html2js"
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

  grunt.registerTask "default", ["test"]
