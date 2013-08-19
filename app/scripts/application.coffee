# The entry point for the application

app = angular.module "myApp", [
  "ngRoute"
  "myApp.alerts"
  "myApp.navigation"
]

app.config [
  "$provide", "$routeProvider", ($provide, $routeProvider) ->
    $provide.value("alertTimeout", 3000)

    # workarounds e2e scenarios
    e2eScenarioRunner = window.location.port is "8090"
    if e2eScenarioRunner
      # disable timeouts, see https://github.com/angular/angular.js/issues/2402
      $provide.value("alertTimeout", null)

    $routeProvider
      .when "/",
        templateUrl: "templates/views/main.html",
        controller: "MainCtrl"

      .when "/other",
        templateUrl: "templates/views/other.html",
        controller: "OtherCtrl"

      .when "/todos",
        templateUrl: "templates/views/todos.html",
        controller: "TodosCtrl"

      .otherwise redirectTo: "/"
]
