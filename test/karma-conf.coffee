# Karma configuration
module.exports = (config) ->
  config.set
    basePath: "../"

    frameworks: [
      "mocha"
      "chai"
      "sinon"
    ]

    # list of files / patterns to load in the browser
    files: [
      "bower_components/jquery/jquery.js"
      "bower_components/lodash/dist/lodash.js"

      "bower_components/angular/angular.js"
      "bower_components/angular-mocks/angular-mocks.js"
      "bower_components/angular-resource/angular-resource.js"
      "bower_components/angular-animate/angular-animate.js"
      "app/scripts/angular-messages.js"
      "bower_components/angular-ui-router/release/angular-ui-router.js"
      "bower_components/angular-bindonce/bindonce.js"

      "app/templates/**/*.html"

      "app/scripts/modules/**/*.coffee"
      "app/scripts/application.coffee"
      "app/scripts/routes.coffee"
      "app/scripts/controllers/**/*.coffee"

      "test/unit/helpers/**/*.coffee"
      "test/unit/**/*_spec.coffee"
    ]

    preprocessors:
      "**/*.html": ["html2js"]

      "app/scripts/**/*.coffee": ["coverage"]
      "test/unit/**/*.coffee": ["coffee"]

    ngHtml2JsPreprocessor:
      stripPrefix: "app/"
      moduleName: "myApp.templates"

    # Test results reporter to use. Possible values: dots || progress || growl
    reporters: ["dots", "coverage"]

    # html - produces a bunch of HTML files with annotated source code
    # lcovonly - produces an lcov.info file
    # lcov - produces html + lcov files. This is the default format
    # cobertura - produces a cobertura-coverage.xml file for easy Hudson integration
    # text-summary - produces a compact text summary of coverage, typically to console
    # text - produces a detailed text table with coverage for all files
    coverageReporter:
      reporters: [
        { type: "html" }
        { type: "text", file: "karma-coverage.txt" }
        { type: "text-summary" }
        { type: "cobertura" }
      ]
      dir: "coverage"

    # web server port
    port: 8080

    # cli runner port
    runnerPort: 9100

    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true

    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera
    # - Safari (only Mac)
    # - PhantomJS
    # - IE (only Windows)
    browsers: ["PhantomJS"]

    # Continuous Integration mode
    # if true, it capture browsers, run tests and exit
    singleRun: false

    # level of logging
    # possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_WARN
