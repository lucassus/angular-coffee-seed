exports.config =
  # Run with selenium standalone server
  # seleniumServerJar: null # use default location
  # seleniumPort: 4444

  chromeOnly: false

  capabilities:
    browserName: "firefox"

  # spec patterns
  specs: [
    "integration/*_scenario.coffee"
  ]

  # A base URL for your application under test. Calls to protractor.get()
  # with relative paths will be prepended with this.
  baseUrl: "http://localhost:9001"

  # Use mocha (currently in beta)
  framework: "mocha"

  # Options to be passed to mocha
  # See the full list at http://visionmedia.github.io/mocha/
  mochaOpts:
    ui: "bdd"
    reporter: "list"
