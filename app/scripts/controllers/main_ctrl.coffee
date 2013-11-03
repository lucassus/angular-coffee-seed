class MainCtrl

  @$inject = ["$scope", "$state", "$stateParams"]
  constructor: ($scope, $state, $stateParams) ->
    # Enable access to `$state` and `$stateParams` in the templates
    $scope.$state = $state
    $scope.$stateParams = $stateParams

angular.module("myApp")
  .controller("MainCtrl", MainCtrl)
