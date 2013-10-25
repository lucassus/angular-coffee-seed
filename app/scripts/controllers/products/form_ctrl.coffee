class FormCtrl

  @$inject = ["$scope", "$location", "alerts", "product"]
  constructor: (@$scope, @$location, @alerts, @product) ->
    $scope.product = product

  save: (product) ->
    @$scope.productForm.$submitted = true
    return unless @$scope.productForm?.$valid

    promise = product.$save()

    successMessage = if product.id? then "Product was updated" else "Product was created"
    promise.then =>
      @alerts.success successMessage
      @$location.path "/products"

  deleteProduct: ->
    promise = @product.$delete()
    promise.then =>
      @alerts.info "Product was deleted"
      @$location.path "/products"

angular.module("myApp")
  .controller("products.FormCtrl", FormCtrl)
