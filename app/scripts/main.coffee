require.config
  baseUrl: "/scripts"

  paths:
    angular: "../components/angular/angular"

  shim:
    "angular": { "exports": "angular" }

require [
  "angular"
  "app"
], (angular, app) ->

  angular.element(document).ready ->
    angular.bootstrap(document, [app["name"]])

    # Because of RequireJS we need to bootstrap the app app manually
    # and Angular Scenario runner won't be able to communicate with our app
    # unless we explicitely mark the container as app holder
    # More info: https://groups.google.com/forum/#!msg/angular/yslVnZh9Yjk/MLi3VGXZLeMJ
    document.className = "ng-app"
