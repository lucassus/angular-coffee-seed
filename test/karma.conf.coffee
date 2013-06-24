# Karma configuration

# list of files / patterns to load in the browser
files = [
  JASMINE
  JASMINE_ADAPTER

  "components/jquery/jquery.js"
  "components/angular/angular.js"
  "components/angular-mocks/angular-mocks.js"

  "scripts/templates.js"
  "scripts/modules/**/*.js"
  "scripts/controllers.js"
  "scripts/controllers/**/*.js"
  "scripts/application.js"

  "test/unit/helpers/**/*.js"
  "test/unit/**/*_spec.js"
]

# web server port
port = 8080

# cli runner port
runnerPort = 9100

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

# level of logging
# possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_WARN
