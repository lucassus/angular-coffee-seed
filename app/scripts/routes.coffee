# Defines routes for the application

app = angular.module "myApp"

app.config [
  "$stateProvider", "$urlRouterProvider", ($stateProvider, $urlRouterProvider) ->

    # For any unmatched url, redirect to /products
    $urlRouterProvider.otherwise "/products"

    $stateProvider
      .state "products",
        abstract: true
        url: "/products"
        template: "<ui-view/>"

      .state "products.list",
        url: ""
        templateUrl: "templates/products/list.html"
        controller: "products.IndexCtrl as index"

      .state "products.create",
        url: "/create"
        templateUrl: "templates/products/form.html"
        controller: "products.FormCtrl as form"
        resolve:
          product: ["Products", (Products) -> new Products()]

      .state "products.edit",
        url: "/:id/edit"
        templateUrl: "templates/products/form.html"
        controller: "products.FormCtrl as form"
        resolve:
          product: ["Products", "$stateParams", (Products, $stateParams) ->
            Products.get(id: $stateParams.id).$promise
          ]

      .state "products.show",
        abstract: true
        url: "/:id"
        templateUrl: "templates/products/show.html"
        controller: "products.ShowCtrl as show"
        resolve:
          product: ["Products", "$stateParams", (Products, $stateParams) ->
            Products.get(id: $stateParams.id).$promise
          ]

      .state "products.show.info",
        url: ""
        templateUrl: "templates/products/show/info.html"

      .state "products.show.details",
        url: "/details"
        templateUrl: "templates/products/show/details.html"

      .state "products.show.actions",
        url: "/actions"
        templateUrl: "templates/products/show/actions.html"
        controller: "products.ShowActionsCtrl as actions"

      .state "other",
        url: "/other",
        templateUrl: "templates/other.html"
        controller: "OtherCtrl as other"

      .state "tasks",
        url: "/tasks"
        templateUrl: "templates/tasks.html"
        controller: "TasksCtrl as tasks"
]
