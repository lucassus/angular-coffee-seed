module.exports = (grunt) ->
  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks)
  grunt.loadTasks("build/tasks")

  # configurable paths
  appConfig =
    app: "app"
    test: "test"
    dist: "dist"
    dev: "dev"

  loadMoule = (name) ->
    require("./build/config/#{name}")(grunt, appConfig)

  grunt.initConfig
    appConfig: appConfig
    pkg: grunt.file.readJSON("package.json")

    watch:         loadMoule "watch"
    coffee:        loadMoule "coffee"
    less:          loadMoule "less"
    concat:        loadMoule "concat"
    useminPrepare: loadMoule "usemin_prepare"
    usemin:        loadMoule "usemin"
    htmlmin:       loadMoule "htmlmin"
    copy:          loadMoule "copy"
    coffeelint:    loadMoule "coffeelint"
    ngtemplates:   loadMoule "ngtemplates"
    bower:         loadMoule "bower"
    karma:         loadMoule "karma"
    jasminehtml:   loadMoule "jasminehtml"
    casperjs:      loadMoule "casperjs"
    clean:         loadMoule "clean"
    connect:       loadMoule "connect"

  grunt.renameTask "regarde", "watch"

  grunt.registerTask "timestamp", -> grunt.log.subhead "--- timestamp: #{new Date()}"

  grunt.registerTask "build:dev", [
    "clean"
    "bower"
    "coffeelint"
    "coffee"
    "less"
    "copy:dev"
    "ngtemplates"
    "jasminehtml"
  ]

  grunt.registerTask "server", [
    "build:dev"

    "livereload-start"
    "connect:livereload"
    "watch"
  ]

  # run unit tests
  grunt.registerTask "test:unit", [
    "karma:unit"
  ]

  # run unit tests in the watch mode
  grunt.registerTask "test:unit:watch", [
    "karma:watch"
  ]

  # run unit tests against compiled develepment release
  # and generate code coverage report
  grunt.registerTask "test:unit:coverage", [
    "build:dev"
    "karma:coverage"
  ]

  grunt.registerTask "test:coverage", [
    "test:unit:coverage"
  ]

  # run e2e integration tests
  grunt.registerTask "test:e2e", [
    "build:dev"
    "connect:e2e"
    "karma:e2e"
  ]

  # run casperjs integration tests
  grunt.registerTask "test:casperjs", [
    "build:dev"
    "connect:e2e"
    "casperjs"
  ]

  # run all tests on the ci server
  grunt.registerTask "test:ci", [
    "build:dev"

    # run unit tests and generate code coverage report
    "karma:coverage"

    # run all integration tests
    "connect:e2e"
    "karma:e2e"
    "casperjs"
  ]

  grunt.registerTask "test", [
    "karma:unit"
  ]

  grunt.registerTask "build:dist", [
    "test:ci"
    "useminPrepare"
    "htmlmin"
    "concat"
    "copy:dist"
    "usemin"
    "uglify"
    "cssmin"
  ]

  grunt.renameTask "build:dist", "build"

  # Used during heroku deployment
  grunt.registerTask "heroku:production", ["build"]

  grunt.registerTask "default", ["test"]
