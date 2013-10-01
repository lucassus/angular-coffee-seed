# Defines routes for the application

app = angular.module "myApp"

app.config [
  "$routeProvider", ($routeProvider) ->

    $routeProvider
      .when "/products",
        templateUrl: "templates/products/index.html"
        controller: "products.IndexCtrl as index"
        resolve:
          products: ["Products", (Products) -> Products.query().$promise]

      .when "/products/create",
        templateUrl: "templates/products/form.html"
        controller: "products.FormCtrl as form"
        resolve:
          product: ["Products", (Products) -> new Products()]

      .when "/products/:id/edit",
        templateUrl: "templates/products/form.html"
        controller: "products.FormCtrl as form"
        resolve:
          product: ["Products", "$route", (Products, $route) ->
            Products.get(id: $route.current.params.id).$promise
          ]

      .when "/products/:id",
        templateUrl: "templates/products/show.html"
        controller: "products.ShowCtrl as show"
        resolve:
          product: ["Products", "$route", (Products, $route) ->
            Products.get(id: $route.current.params.id).$promise
          ]

      .when "/other",
        templateUrl: "templates/other.html"
        controller: "OtherCtrl as other"

      .when "/tasks",
        templateUrl: "templates/tasks.html"
        controller: "TasksCtrl as tasks"

      .otherwise redirectTo: "/products"
]
