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

  # common options for all karma's modes (unit, watch, coverage, e2e)
  options:
    configFile: "<%= appConfig.test %>/karma-conf.coffee"
    browsers: parseBrowsers(default: "PhantomJS")
    colors: true

    coverageReporter:
      type: grunt.option("coverage-reporter") || "text"
      dir: "coverage"

    # If browser does not capture in given timeout [ms], kill it
    captureTimeout: 5000

  # single run karma for unit tests
  unit:
    singleRun: true

  # run karma for unit tests in watch mode
  watch:
    singleRun: false
    autoWatch: true
