exports.config =
  # Run with selenium standalone server
  # seleniumServerJar: "./selenium/selenium-server-standalone-2.37.0.jar"
  # seleniumPort: 4444,

  chromeDriver: "./selenium/chromedriver"
  chromeOnly: true

  # capabilities to be passed to the webdriver instance
  capabilities:
    browserName: "firefox"

  # spec patterns
  specs: [
    "integration/*_scenario.js"
  ]

  # A base URL for your application under test. Calls to protractor.get()
  # with relative paths will be prepended with this.
  baseUrl: "http://localhost:9001"

  # options to be passed to Jasmine-node
  jasmineNodeOpts:
    # default time to wait in ms before a test fails
    defaultTimeoutInterval: 10000

    showColors: true
    isVerbose: false
    includeStackTrace: true
