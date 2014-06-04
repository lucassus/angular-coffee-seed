app = angular.module "myApp"

app.config [

  "$provide", ($provide) ->
    # disable timeouts, see https://github.com/angular/angular.js/issues/2402
    $provide.value("alertTimeout", null)

]
