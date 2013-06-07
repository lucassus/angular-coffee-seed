module = angular.module("myApp.controllers")

class OtherCtrl

  @$inject = ["$scope"]
  constructor: ($scope) ->
    $scope.name = "This is the other controller"

module.controller "OtherCtrl", OtherCtrl
