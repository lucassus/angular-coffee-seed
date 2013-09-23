# Defines routes for the application

app = angular.module "myApp"

app.config [
  "$routeProvider", ($routeProvider) ->

    $routeProvider
      .when "/",
        templateUrl: "templates/views/main.html"
        controller: "MainCtrl as main"
        resolve:
          products: ["Products", (Products) -> Products.query().$promise]

      .when "/other",
        templateUrl: "templates/views/other.html"
        controller: "OtherCtrl as other"

      .when "/tasks",
        templateUrl: "templates/views/tasks.html"
        controller: "TasksCtrl as tasks"

      .otherwise redirectTo: "/"
]
