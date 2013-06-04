tests = Object.keys(window.__karma__.files).filter (file) ->
  /_spec\.js$/.test(file)

tests.push("app")

require.config
  baseUrl: "/base/scripts"

  paths:
    angular: "../components/angular/angular"
    "angular-mocks": "../components/angular-mocks/angular-mocks"

  shim:
    "angular": { "exports": "angular" }
    "angular-mocks": { "exports": "angular-mocks", deps: ["angular"] }

  # ask Require.js to load these files (all our tests)
#  deps: tests

# start test run, once Require.js is done
require tests, ->
  window.__karma__.start()
