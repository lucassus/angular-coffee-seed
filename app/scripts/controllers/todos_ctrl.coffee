class TodosCtrl

  @$inject = ["$scope"]
  constructor: ($scope) ->

controllers = angular.module("myApp.controllers")
controllers.controller("TodosCtrl", TodosCtrl)
