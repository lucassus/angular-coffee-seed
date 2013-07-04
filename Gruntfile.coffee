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
    dev: "./dev"

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

      html:
        files: [
          "<%= appConfig.app %>/index.html"
          "<%= appConfig.app %>/views/*.html"
        ]
        tasks: ["copy:dev"]

      templates:
        files: ["<%= appConfig.app %>/templates/**/*.tpl.html"]
        tasks: ["html2js"]

      css:
        files: ["<%= appConfig.app %>/styles/**/*.less"]
        tasks: ["less"]

      livereload:
        files: ["<%= appConfig.dev %>/**/*"]
        tasks: ["livereload"]

    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= appConfig.app %>/scripts"
          src: "**/*.coffee"
          dest: "<%= appConfig.dev %>/scripts"
          ext: ".js"
        ]

      test:
        files: [
          expand: true
          cwd: "<%= appConfig.test %>"
          src: "**/*.coffee"
          dest: "<%= appConfig.dev %>/test"
          ext: ".js"
        ]

    less:
      dist:
        files:
          "<%= appConfig.dev %>/styles/style.css": "<%= appConfig.app %>/styles/style.less"

    concat:
      dist:
        files:
          "<%= appConfig.dev %>/scripts/scripts.js": [
            "<%= appConfig.dev %>/scripts/**/*.js"
            "!<%= appConfig.dev %>/scripts/templates.js" # do not include complited templates
            "!<%= appConfig.dev %>/scripts/application_test.js" # do not include test application module
            "<%= appConfig.app %>/scripts/**/*.js"
          ]

    useminPrepare:
      html: "<%= appConfig.dev %>/index.html"
      options:
        dest: "<%= appConfig.dist %>"

    usemin:
      html: ["<%= appConfig.dist %>/index.html"]
      css: ["<%= appConfig.dist %>/styles/**/*.css"]
      options:
        dirs: ["<%= appConfig.dist %>"]

    htmlmin:
      dist:
        files: [
          expand: true,
          cwd: "<%= appConfig.app %>",
          src: ["*.html", "views/*.html", "templates/*.tpl.html"],
          dest: "<%= appConfig.dist %>"
        ]

    copy:
      dev:
        files: [
          expand: true
          dot: true
          cwd: "<%= appConfig.app %>"
          dest: "<%= appConfig.dev %>"
          src: [
            "*.{ico,txt}"
            "**/*.html"
            "components/**/*"
            "images/**/*.{gif,webp}"
            "styles/fonts/*"
          ]
        ]

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
        dest: "<%= appConfig.dev %>/scripts/templates.js"

    bower:
      install:
        options:
          targetDir: "<%= appConfig.dev %>/components"
          layout: "byComponent"
          cleanTargetDir: true
          install: false

    karma:
      options:
        configFile: "<%= appConfig.test %>/karma.conf.coffee"
        basePath: "../<%= appConfig.dev %>"
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
        singleRun: true # `false` for debugging

      watch:
        singleRun: false
        autoWatch: true

    casperjs:
      files: ["<%= appConfig.dev %>/test/casperjs/**/*_scenario.js"]

    clean:
      options:
        files: [
          dot: true
          src: [
            "<%= appConfig.dev %>"
            "!<%= appConfig.dev %>/.git*"

            "<%= appConfig.dist %>/*"
            "!<%= appConfig.dist %>/.git*"
          ]
        ]

    connect:
      options:
        hostname: "localhost"

      e2e:
        options:
          port: 9001
          middleware: (connect) ->
            [mountFolder(connect, appConfig.dev)]

      livereload:
        options:
          port: 9000
          middleware: (connect) ->
            [
              livereloadSnippet
              mountFolder(connect, appConfig.dev)
            ]

  grunt.renameTask "regarde", "watch"

  grunt.registerTask "build:dev", [
    "clean"
    "bower"
    "coffeelint"
    "coffee"
    "less"
    "copy:dev"
  ]

  grunt.registerTask "server", [
    "build:dev"

    "livereload-start"
    "connect:livereload"
    "watch"
  ]

  grunt.registerTask "test", [
    "build:dev"
    "html2js"
    "karma:unit"
  ]

  grunt.registerTask "test:e2e", [
    "build:dev"
    "connect:e2e"
    "karma:e2e"
  ]

  grunt.registerTask "test:casperjs", [
    "build:dev"
    "connect:e2e"
    "casperjs"
  ]

  # run all tests on the ci server
  grunt.registerTask "test:ci", [
    "build:dev"
    "html2js"

    # run unit tests
    "karma:unit"

    # run e2e tests
    "connect:e2e"
    "karma:e2e"

    # run casperjs integration tests
    "casperjs"
  ]

  grunt.registerTask "build:dist", [
    "test:ci"
    "useminPrepare"
    "htmlmin"
    "concat"
    "usemin"
    "uglify"
    "cssmin"
  ]

  grunt.registerTask "test:watch", [
    "coffee:test"
    "karma:watch"
  ]

  grunt.renameTask "build:dist", "build"

  # Used during heroku deployment
  grunt.registerTask "heroku:production", ["build"]

  grunt.registerTask "default", ["test"]
