class OtherCtrl

  @$inject = ["$scope", "alerts"]
  constructor: ($scope, alerts) ->
    $scope.name = "This is the other controller"

    $scope.sayHello = ->
      alerts.info("Hello World!")

angular.module("myApp")
  .controller("OtherCtrl", OtherCtrl)
