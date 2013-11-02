# The entry point for the application

app = angular.module "myApp", [
  "ngAnimate"
  "ui.router"

  "myApp.templates"
  "myApp.alerts"
  "myApp.resources"
]

app.config [

  "$provide", ($provide) ->
    $provide.value("alertTimeout", 3000)

    # workarounds e2e scenarios
    e2eScenarioRunner = window.location.port is "9001"
    if e2eScenarioRunner
      # disable timeouts, see https://github.com/angular/angular.js/issues/2402
      $provide.value("alertTimeout", null)

]

# TODO spec it
app.controller "MainCtrl", [
  "$scope", "$state", "$stateParams", ($scope, $state, $stateParams) ->
    # Enable access to `$state` and `$stateParams` in the templates
    $scope.$state = $state
    $scope.$stateParams = $stateParams
]
