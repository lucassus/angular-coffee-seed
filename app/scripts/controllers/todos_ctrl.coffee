class TodosCtrl

  @$inject = ["$scope"]
  constructor: ($scope) ->
    $scope.todos = [
      { name: "First task", complete: false }
      { name: "Second task", complete: false }
      { name: "Completed task", complete: true }
    ]

controllers = angular.module("myApp.controllers")
controllers.controller("TodosCtrl", TodosCtrl)
