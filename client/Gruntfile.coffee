module.exports = (grunt) ->
  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks)
  grunt.loadTasks("build/tasks")

  # configurable paths
  appConfig =
    app: "app"
    test: "test"
    dist: "../server/public"
    dev: ".tmp"

  config = (name) ->
    require("./build/config/#{name}")(grunt, appConfig)

  grunt.initConfig
    appConfig: appConfig
    pkg: grunt.file.readJSON("package.json")

    watch:         config("watch")
    coffee:        config("coffee")
    less:          config("less")
    concat:        config("concat")
    useminPrepare: config("usemin_prepare")
    usemin:        config("usemin")
    htmlmin:       config("htmlmin")
    copy:          config("copy")
    coffeelint:    config("coffeelint")
    ngtemplates:   config("ngtemplates")
    bower:         config("bower")
    karma:         config("karma")
    clean:         config("clean")
    connect:       config("connect")
    shell:         config("shell")
    devUpdate:     config("devUpdate")

  grunt.renameTask "regarde", "watch"

  grunt.registerTask "timestamp", -> grunt.log.subhead "--- timestamp: #{new Date()}"

  grunt.registerTask "build:dev", [
    "clean"
    "bower"
    "coffeelint"
    "copy:coffee"
    "coffee"
    "less"
    "copy:dev"
    "ngtemplates"
  ]

  grunt.registerTask "server", [
    "build:dev"

    "configureProxies"
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

  # run unit tests in the watch mode
  grunt.registerTask "test:watch", [
    "test:unit:watch"
  ]

  grunt.registerTask "test", [
    "karma:unit"
  ]

  grunt.registerTask "build:dist", [
    "test:unit"

    "build:dev"
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
