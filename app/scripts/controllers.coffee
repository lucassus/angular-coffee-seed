controllers =
  main: "controllers/main_ctrl"
  other: "controllers/other_ctrl"

define [
  "angular"
  "require"

  "services"
  "controllers/main_ctrl"
  "controllers/other_ctrl"
], (angular, require) ->

  # Load controllers
  module = angular.module("myApp.controllers", ["myApp.services"])
  for name, file of controllers
    module.controller(name, require(file))
