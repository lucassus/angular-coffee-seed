class ShowCtrl

  @$inject = ["$scope", "product"]
  constructor: ($scope, product) ->
    $scope.product = product

angular.module("myApp")
  .controller("products.ShowCtrl", ShowCtrl)
