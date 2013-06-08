# Entry point for the application

require("./services")
require("./controllers")
require("./modules/alerts")

angular = require("./lib/angular")

app = angular.module("myApp", ["myApp.services", "myApp.controllers", "myApp.alerts"])
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

      .otherwise redirectTo: "/"
]
