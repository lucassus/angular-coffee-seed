require.config
  # karma server files from `/base` directory
  baseUrl: "/base/scripts"

  paths:
    angular: "../components/angular/angular"
    "angular-mocks": "../components/angular-mocks/angular-mocks"

  shim:
    "angular": { "exports": "angular" }
    "angular-mocks": { "exports": "angular-mocks", deps: ["angular"] }

# load the tests
dependencies = []
for file, timestamp of window.__karma__.files
  dependencies.push(file) if /_spec\.js$/.test(file)

# load the main app module
dependencies.push("app")

# start test run
require dependencies, ->
  window.__karma__.start()
