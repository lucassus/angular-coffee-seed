module.exports = class OtherCtrl

  @$inject = ["$scope"]
  constructor: ($scope) ->
    $scope.name = "This is the other controller"
