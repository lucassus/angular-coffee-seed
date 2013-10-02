module.exports = (grunt) ->

  _extractOptions = (key, opts = {}) ->
    options = grunt.option(key) or opts.default
    options = options.replace(/[\s\[\]]/, "")
    options.split(",")

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
    opts.default or= "PhantomJS"
    _extractOptions("browsers", opts)

  # Possible values: dots, spec, progress, junit, growl, coverage
  parseReporters = (opts = {}) ->
    opts.default or= "dots"
    _extractOptions("reporters", opts)

  # common options for all karma's modes (unit, watch, coverage, e2e)
  options:
    browsers: parseBrowsers(default: "PhantomJS")
    colors: true
    # test results reporter to use
    # possible values: dots || progress || growl
    reporters: parseReporters(defaultReporter: "dots")
    # If browser does not capture in given timeout [ms], kill it
    captureTimeout: 5000

  # single run karma for unit tests
  unit:
    configFile: "<%= appConfig.test %>/karma.conf.coffee"
    reporters: parseReporters(default: "dots")
    singleRun: true

  # run karma for unit tests in watch mode
  watch:
    configFile: "<%= appConfig.test %>/karma.conf.coffee"
    reporters: parseReporters(default: "dots")
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
