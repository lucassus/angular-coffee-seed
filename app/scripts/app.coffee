define ["angular", "services", "controllers"], (angular) ->
  app = angular.module("myApp", ["myApp.services", "myApp.controllers"])

  app.config [
    "$routeProvider", ($routeProvider) ->
      $routeProvider
        .when "/",
          templateUrl: "views/main.html",
          controller: "main"

        .when "/other",
          templateUrl: "views/other.html",
          controller: "other"

        .otherwise redirectTo: "/"
  ]
