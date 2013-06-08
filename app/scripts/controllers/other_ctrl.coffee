module.exports = (controllers) ->
  class OtherCtrl

    @$inject = ["$scope", "alerts"]
    constructor: ($scope, alerts) ->
      $scope.name = "This is the other controller"
      alerts.info("Hello World!")

  controllers.controller("OtherCtrl", OtherCtrl)
