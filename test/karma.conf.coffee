# Karma configuration
module.exports = (config) ->
  config.set
    basePath: "../"

    frameworks: [
      "mocha"
      "chai"
    ]

    # list of files / patterns to load in the browser
    files: [
      "bower_components/jquery/jquery.js"
      "bower_components/lodash/dist/lodash.js"

      "bower_components/angular/angular.js"
      "bower_components/angular-mocks/angular-mocks.js"
      "bower_components/angular-resource/angular-resource.js"
      "bower_components/angular-route/angular-route.js"
      "bower_components/angular-animate/angular-animate.js"

      "bower_components/sinon/lib/sinon.js"
      "bower_components/sinon/lib/sinon/spy.js"
      "bower_components/sinon/lib/sinon/call.js"
      "bower_components/sinon/lib/sinon/stub.js"
      "bower_components/sinon/lib/sinon/mock.js"
      "bower_components/sinon/lib/sinon/assert.js"

      "app/templates/**/*.html"

      "app/scripts/modules/**/*.coffee"
      "app/scripts/application.coffee"
      "app/scripts/routes.coffee"
      "app/scripts/controllers/**/*.coffee"

      "test/unit/helpers/**/*.coffee"
      "test/unit/**/*_spec.coffee"
    ]

    preprocessors:
      "**/*.coffee": ["coffee"]
      "**/*.html": ["html2js"]

    ngHtml2JsPreprocessor:
      stripPrefix: "app/"
      moduleName: "myApp.templates"

    reporters: ["dots"]

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

    plugins: [
      "karma-coffee-preprocessor"
      "karma-ng-html2js-preprocessor"

      "karma-mocha"
      "karma-chai-plugins"
      "karma-spec-reporter"

      "karma-phantomjs-launcher"
      "karma-chrome-launcher"
      "karma-firefox-launcher"
      "karma-opera-launcher"
    ]
