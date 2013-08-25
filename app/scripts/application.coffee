# The entry point for the application

app = angular.module "myApp", [
  "ngAnimate"
  "ngRoute"
  "ngRoute"
  "myApp.templates"
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
        templateUrl: "templates/views/main.html"
        controller: "MainCtrl as main"

      .when "/other",
        templateUrl: "templates/views/other.html"
        controller: "OtherCtrl as other"

      .when "/tasks",
        templateUrl: "templates/views/tasks.html"
        controller: "TasksCtrl as tasks"

      .otherwise redirectTo: "/"
]
