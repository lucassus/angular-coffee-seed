# Defines routes for the application

app = angular.module "myApp"

app.config [
  "$routeProvider", ($routeProvider) ->

    $routeProvider
      .when "/products",
        templateUrl: "templates/views/products/index.html"
        controller: "products.IndexCtrl as index"
        resolve:
          products: ["Products", (Products) -> Products.query().$promise]

      .when "/products/create",
        templateUrl: "templates/views/products/form.html"
        controller: "products.FormCtrl as form"
        resolve:
          product: ["Products", (Products) -> new Products()]

      .when "/products/:id/edit",
        templateUrl: "templates/views/products/form.html"
        controller: "products.FormCtrl as form"
        resolve:
          product: ["Products", "$route", (Products, $route) ->
            Products.get(id: $route.current.params.id).$promise
          ]

      .when "/products/:id",
        templateUrl: "templates/views/products/show.html"
        controller: "products.ShowCtrl as show"
        resolve:
          product: ["Products", "$route", (Products, $route) ->
            Products.get(id: $route.current.params.id).$promise
          ]

      .when "/other",
        templateUrl: "templates/views/other.html"
        controller: "OtherCtrl as other"

      .when "/tasks",
        templateUrl: "templates/views/tasks.html"
        controller: "TasksCtrl as tasks"

      .otherwise redirectTo: "/products"
]
