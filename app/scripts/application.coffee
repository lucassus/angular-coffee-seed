# The entry point for the application

# TODO bee fup readme

app = angular.module "myApp", [
  "ngAnimate"
  "ui.router"
  "pasvaz.bindonce"

  "myApp.templates"
  "myApp.alerts"
  "myApp.resources"
]

# application environment
app.constant "env", "/* @echo ENV */" or "production"

app.config [

  "$provide", "env", ($provide) ->

    # set alerts timeout to 3 secounds
    $provide.value("alertTimeout", 3000)

]

app.run [
  "$log", "$animate", "env",
  ($log, $animate, env) ->
    $log.debug "Running the app in the `#{env}` mode.."

    # disable animations in the test env
    $animate.enabled(false) is env is "test"
]
