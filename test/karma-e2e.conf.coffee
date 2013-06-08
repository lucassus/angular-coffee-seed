# Karma E2E configuration

# list of files / patterns to load in the browser
files = [
  ANGULAR_SCENARIO
  ANGULAR_SCENARIO_ADAPTER

  "test/e2e/**/*_spec.js"
]

# list of files to exclude
exclude = []

# web server port
port = 8080

# cli runner port
runnerPort = 9100

# enable / disable colors in the output (reporters and logs)
colors = true

# enable / disable watching file and executing tests whenever any file changes
autoWatch = false

# Start these browsers, currently available:
# - Chrome
# - ChromeCanary
# - Firefox
# - Opera
# - Safari (only Mac)
# - PhantomJS
# - IE (only Windows)
browsers = ["PhantomJS"]

# Continuous Integration mode
# if true, it capture browsers, run tests and exit
singleRun = false

# Running server address
urlRoot = "/__karma__/"
proxies = "/": "http://localhost:9001/"
