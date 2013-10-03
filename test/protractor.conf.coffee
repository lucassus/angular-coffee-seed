exports.config =
  # the address of a running selenium server
  seleniumAddress: "http://localhost:4444/wd/hub"

  # capabilities to be passed to the webdriver instance
  capabilities:
    browserName: "chrome"

  # spec patterns
  specs: [
    "protractor/*_scenario.js"
  ]

  # options to be passed to Jasmine-node
  jasmineNodeOpts:
    showColors: true
    # default time to wait in ms before a test fails
    defaultTimeoutInterval: 30000
