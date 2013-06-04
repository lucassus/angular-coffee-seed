// Karma configuration

// base path, that will be used to resolve files and exclude
basePath = "./dist";

// list of files / patterns to load in the browser
files = [
  JASMINE,
  JASMINE_ADAPTER,

  REQUIRE,
  REQUIRE_ADAPTER,

  // load all external libraries
  { pattern: "components/**/*.js", included: false },
  // load all the sources
  { pattern: "scripts/**/*.js", included: false },
  // load all the tests
  { pattern: "test/**/*_spec.js", included: false },

  "test/test-main.js"
];

// list of files to exclude
exclude = [
  // we don't want to actually start the application in our tests
  "scripts/main.js"
];

// test results reporter to use
// possible values: dots || progress || growl
reporters = ["progress"];

// web server port
port = 8080;

// cli runner port
runnerPort = 9100;

// enable / disable colors in the output (reporters and logs)
colors = true;

// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;

// enable / disable watching file and executing tests whenever any file changes
autoWatch = false;

// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = ["Chrome"];

// If browser does not capture in given timeout [ms], kill it
captureTimeout = 5000;

// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = false;
