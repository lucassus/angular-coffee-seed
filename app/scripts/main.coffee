require.config
  paths:
    jquery: "../components/jquery/jquery"
    angular: "../components/angular/angular"

  baseUrl: "/scripts"

  shim:
    "jquery": { "exports": "$" }
    "angular": { "exports": "angular", deps: ["jquery"] }

require [
  "jquery"
  "angular"
  "app"
], ($, angular, app) ->

  $ ->
    $html = $("html")
    angular.bootstrap($html, [app["name"]])
