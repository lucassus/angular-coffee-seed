# The entry point for the application

app = angular.module "myApp", [
  "ngRoute"
  "ngAnimate"

  "myApp.templates"
  "myApp.alerts"
  "myApp.navigation"
]

app.config [

  "$provide", ($provide) ->
    $provide.value("alertTimeout", 3000)

    # workarounds e2e scenarios
    e2eScenarioRunner = window.location.port is "8090"
    if e2eScenarioRunner
      # disable timeouts, see https://github.com/angular/angular.js/issues/2402
      $provide.value("alertTimeout", null)

]
