require.config
  baseUrl: "/scripts"

  paths:
    jquery: "../components/jquery/jquery"
    angular: "../components/angular/angular"

  shim:
    "jquery": { "exports": "$" }
    "angular": { "exports": "angular", deps: ["jquery"] }

require [
  "jquery"
  "angular"
  "app"
], ($, angular, app) ->

  $ ->
    $body = $("body")
    angular.bootstrap($body, [app["name"]])

    # Because of RequireJS we need to bootstrap the app app manually
    # and Angular Scenario runner won't be able to communicate with our app
    # unless we explicitely mark the container as app holder
    # More info: https://groups.google.com/forum/#!msg/angular/yslVnZh9Yjk/MLi3VGXZLeMJ
    $body.addClass("ng-app");
