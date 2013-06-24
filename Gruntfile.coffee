livereloadSnippet = require("grunt-contrib-livereload/lib/utils").livereloadSnippet

mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)

module.exports = (grunt) ->
  # load all grunt tasks
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

  # configurable paths
  appConfig =
    app: "./app"
    test: "./test"
    dist: "./dist"

  grunt.initConfig
    appConfig: appConfig
    pkg: grunt.file.readJSON("package.json")

    watch:
      coffee:
        files: ["<%= appConfig.app %>/scripts/**/*.coffee"]
        tasks: ["coffee:dist"]

      coffeeTest:
        files: ["<%= appConfig.test %>/**/*.coffee"]
        tasks: ["coffee:test"]

      templates:
        files: ["<%= appConfig.app %>/templates/**/*.tpl.html"]
        tasks: ["html2js"]

      livereload:
        files: [
          # TODO use **/*
          "<%= appConfig.app %>/{,*/}{,*/}*.html"
          "{.tmp,<%= appConfig.app %>}/styles/{,*/}*.css"
          "{.tmp,<%= appConfig.app %>}/scripts/{,*/}*.js"
          "<%= appConfig.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}"
        ]
        tasks: ["livereload"]

      css:
        files: ["<%= appConfig.app %>/styles/**/*.scss"]
        tasks: ["sass:dist"]

    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= appConfig.app %>/scripts"
          src: "**/*.coffee"
          dest: ".tmp/scripts"
          ext: ".js"
        ]

      test:
        files: [
          expand: true
          cwd: "<%= appConfig.test %>"
          src: "**/*.coffee"
          dest: ".tmp/test"
          ext: ".js"
        ]

    sass:
      dist:
        files:
          ".tmp/styles/style.css": "<%= appConfig.app %>/styles/style.scss"

    concat:
      dist:
        files:
          ".tmp/scripts/scripts.js": [
            ".tmp/scripts/**/*.js"
            "!.tmp/scripts/templates.js" # do not include complited templates
            "!.tmp/scripts/application_test.js" # do not include test application module
            "<%= appConfig.app %>/scripts/**/*.js"
          ]

    useminPrepare:
      html: "<%= appConfig.app %>/index.html"
      options:
        dest: "<%= appConfig.dist %>"

    usemin:
      html: ["<%= appConfig.dist %>/index.html"]
      css: ["<%= appConfig.dist %>/styles/**/*.css"]
      options:
        dirs: ["<%= appConfig.dist %>"]

    imagemin:
      dist:
        files: [
          expand: true,
          cwd: "<%= appConfig.app %>/images",
          src: "**/*.{png,jpg,jpeg}",
          dest: "<%= appConfig.dist %>/images"
        ]

    htmlmin:
      dist:
        files: [
          expand: true,
          cwd: "<%= appConfig.app %>",
          src: ["*.html", "views/*.html", "templates/*.tpl.html"],
          dest: "<%= appConfig.dist %>"
        ]

    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: "<%= appConfig.app %>"
          dest: "<%= appConfig.dist %>"
          src: [
            "*.{ico,txt}"
            "components/**/*"
            "images/**/*.{gif,webp}"
            "styles/fonts/*"
          ]
        ]

      server:
        files: [
          expand: true
          dot: true
          cwd: "<%= appConfig.app %>"
          dest: ".tmp"
          src: [
            "*.{ico,txt}"
            "**/*.html"
            "components/**/*"
            "images/**/*.{gif,webp}"
            "styles/fonts/*"
          ]
        ]

    preprocess:

      html:
        options: context: E2E: false
        src: "<%= appConfig.app %>/index.html"
        dest: ".tmp/index.html"

      dist:
        options: context: E2E: false
        src: "<%= appConfig.dist %>/index.html"
        dest: "<%= appConfig.dist %>/index.html"

      e2e:
        options: context: E2E: true
        src: "<%= appConfig.app %>/index.html"
        dest: ".tmp/index.html"

    coffeelint:
      options:
        max_line_length:
          value: 120
          level: "warn"

      app: ["Gruntfile.coffee", "<%= appConfig.app %>/scripts/**/*.coffee"]
      test: ["<%= appConfig.test %>/**/*.coffee"]

    html2js:
      options:
        base: "app"
      main:
        src: ["<%= appConfig.app %>/templates/**/*.tpl.html"]
        dest: ".tmp/scripts/templates.js"

    bower:
      install:
        options:
          targetDir: ".tmp/components"
          install: false

    karma:
      options:
        configFile: "<%= appConfig.test %>/karma.conf.coffee"
        basePath: "../.tmp"
        browsers: parseBrowsers(defaultBrowser: "PhantomJS")
        colors: true
        # test results reporter to use
        # possible values: dots || progress || growl
        reporters: ["dots"]
        # If browser does not capture in given timeout [ms], kill it
        captureTimeout: 5000

      unit:
        reporters: ["dots", "coverage"]
        preprocessors:
          "scripts/**/*.js": "coverage"
        coverageReporter:
          type: "text"
          dir: "coverage"

        singleRun: true

      e2e:
        configFile: "<%= appConfig.test %>/karma-e2e.conf.coffee"
        singleRun: true

      watch:
        singleRun: false
        autoWatch: true

    casperjs:
      files: [".tmp/test/casperjs/**/*.js"]

    clean:
      dist:
        files: [
          dot: true
          src: [
            ".tmp"
            "<%= appConfig.dist %>/*"
            "!<%= appConfig.dist %>/.git*"
          ]
        ]

      server: ".tmp"

    connect:
      options:
        hostname: "localhost"

      e2e:
        options:
          port: 9001
          middleware: (connect) ->
            [mountFolder(connect, ".tmp")]

      livereload:
        options:
          port: 9000
          middleware: (connect) ->
            [
              livereloadSnippet
              mountFolder(connect, ".tmp")
            ]

  grunt.renameTask "regarde", "watch"

  grunt.registerTask "build", [
    "clean:dist"
    "coffeelint"
    "test"
    "coffee"
    "sass"
    "useminPrepare"
    "imagemin"
    "htmlmin"
    "concat"
    "copy"
    "usemin"
    "preprocess:dist"
    "uglify"
    "cssmin"
  ]

  grunt.registerTask "server", [
    "clean:server"
    "copy:server"
    "preprocess:html"
    "bower:install"
    "coffee:dist"
    "sass"
    "livereload-start"
    "connect:livereload"
    "watch"
  ]

  grunt.registerTask "test", [
    "clean:server"
    "bower:install"
    "coffee"
    "html2js"
    "coffeelint"

    "karma:unit"
  ]

  grunt.registerTask "test:e2e", [
    "clean:server"
    "copy:server"
    "bower:install"
    "preprocess:e2e"
    "coffee"
    "html2js"
    "coffeelint"

    "connect:e2e"
    "karma:e2e"
  ]

  grunt.registerTask "test:casperjs", [
    "clean:server"
    "copy:server"
    "bower:install"
    "coffee"
    "html2js"
    "coffeelint"

    "connect:e2e"
    "casperjs"
  ]

  # TODO this task is broken
  grunt.registerTask "test:watch", [
    "build"
    "coffee:test"
    "karma:watch"
  ]

  grunt.registerTask "default", ["test"]
