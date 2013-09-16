module.exports = (grunt) ->

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

  # common options for all karma's modes (unit, watch, coverage, e2e)
  options:
    browsers: parseBrowsers(defaultBrowser: "PhantomJS")
    colors: true
    # test results reporter to use
    # possible values: dots || progress || growl
    reporters: ["dots"]
    # If browser does not capture in given timeout [ms], kill it
    captureTimeout: 5000

  # single run karma for unit tests
  unit:
    configFile: "<%= appConfig.test %>/karma.conf.coffee"
    reporters: ["dots"]
    singleRun: true

  # run karma for unit tests in watch mode
  watch:
    configFile: "<%= appConfig.test %>/karma.conf.coffee"
    reporters: ["dots"]
    singleRun: false
    autoWatch: true

  # generate test code coverage for compiled javascripts
  coverage:
    basePath: "../<%= appConfig.dev %>"
    configFile: "<%= appConfig.test %>/karma-coverage.conf.coffee"
    reporters: ["dots", "coverage"]
    coverageReporter:
      type: grunt.option("coverage-reporter") || "text"
      dir: "coverage"

    singleRun: true

  # run e2e specs
  e2e:
    basePath: "../<%= appConfig.dev %>"
    configFile: "<%= appConfig.test %>/karma-e2e.conf.coffee"
    singleRun: true
