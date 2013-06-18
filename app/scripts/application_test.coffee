angular.module("myApp")
  .config [
    "$provide", ($provide) ->
      $provide.value("alertTimeout", null)
  ]
