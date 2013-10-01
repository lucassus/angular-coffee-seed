class ShowCtrl

  @$inject = ["$scope", "$location", "alerts", "product"]
  constructor: (@$scope, @$location, @alerts, @product) ->
    @$scope.product = @product

  deleteProduct: ->
    promise = @product.$delete()
    promise.then =>
      @alerts.info "Product was deleted"
      @$location.path "/products"

angular.module("myApp")
  .controller("products.ShowCtrl", ShowCtrl)
