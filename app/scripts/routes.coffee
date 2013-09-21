# Defines routes for the application

app = angular.module "myApp"

app.config [
  "$routeProvider", ($routeProvider) ->

    $routeProvider
      .when "/",
        templateUrl: "templates/views/main.html"
        controller: "MainCtrl as main"

        # TODO create Products service
        # TODO write specs for this case
        resolve: products: ["$resource", ($resource) ->
          Products = $resource("/api/products.json")
          Products.query()
        ]

      .when "/other",
        templateUrl: "templates/views/other.html"
        controller: "OtherCtrl as other"

      .when "/tasks",
        templateUrl: "templates/views/tasks.html"
        controller: "TasksCtrl as tasks"

      .otherwise redirectTo: "/"
]
