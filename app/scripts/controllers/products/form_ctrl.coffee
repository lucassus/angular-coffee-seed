class FormCtrl

  @$inject = ["$scope", "$location", "alerts", "product"]
  constructor: (@$scope, @$location, @alerts, @remote) ->
    @reset()

  save: (form, product) ->
    promise = product.$save()
    successMessage = if product.id? then "Product was updated" else "Product was created"

    promise.then =>
      @alerts.success successMessage
      @$location.path "/products"

  reset: ->
    @product = angular.copy(@remote)
    @$scope.product = @product

  delete: ->
    promise = @product.$delete()
    promise.then =>
      @alerts.info "Product was deleted"
      @$location.path "/products"

angular.module("myApp")
  .controller("products.FormCtrl", FormCtrl)
