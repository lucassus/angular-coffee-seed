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
    $html = $("html")
    angular.bootstrap($html, [app["name"]])
