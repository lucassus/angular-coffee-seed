# The entry point for the application

app = angular.module("myApp", ["myApp.controllers", "myApp.alerts"])
app.config [
  "$provide", "$routeProvider", ($provide, $routeProvider) ->
    $provide.value("alertTimeout", 3000)

    $routeProvider
      .when "/",
        templateUrl: "views/main.html",
        controller: "MainCtrl"

      .when "/other",
        templateUrl: "views/other.html",
        controller: "OtherCtrl"

      .when "/todos",
        templateUrl: "views/todos.html",
        controller: "TodosCtrl"

      .otherwise redirectTo: "/"
]
