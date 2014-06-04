# The entry point for the application

app = angular.module "myApp", [
  "ngAnimate"
  "ui.router"
  "pasvaz.bindonce"

  "myApp.templates"
  "myApp.alerts"
  "myApp.resources"
  "myApp.forms"
]

app.config [

  "$provide", ($provide) ->
    $provide.value("alertTimeout", 3000)

]
