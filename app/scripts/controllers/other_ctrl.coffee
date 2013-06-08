module.exports = class OtherCtrl

  @$inject = ["$scope", "alerts"]
  constructor: ($scope, alerts) ->
    $scope.name = "This is the other controller"
    alerts.info("Hello World!")
