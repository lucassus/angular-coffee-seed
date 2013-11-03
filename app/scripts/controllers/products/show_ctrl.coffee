class ShowCtrl

  @$inject = ["$scope", "$state", "alerts", "product"]
  constructor: (@$scope, @$state, @alerts, @product) ->
    $scope.product = product

  deleteProduct: ->
    promise = @product.$delete()
    promise.then =>
      @alerts.info "Product was deleted"
      @$state.go "products.list"

angular.module("myApp")
  .controller("products.ShowCtrl", ShowCtrl)
