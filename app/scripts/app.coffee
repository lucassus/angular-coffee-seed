app = angular.module("myApp", ["myApp.services", "myApp.controllers"])
app.config [
  "$routeProvider", ($routeProvider) ->
    $routeProvider
      .when "/",
        templateUrl: "views/main.html",
        controller: "MainCtrl"

      .when "/other",
        templateUrl: "views/other.html",
        controller: "OtherCtrl"

      .otherwise redirectTo: "/"
]
