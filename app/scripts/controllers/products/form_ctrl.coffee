class FormCtrl

  @$inject = ["$scope", "$location", "alerts", "product"]
  constructor: (@$scope, @$location, @alerts, @remote) ->
    @reset()

  isClean: ->
    angular.equals(@product, @remote)

  save: (form, product) ->
    return if @isClean()

    form.$submitted = true
    return unless form.$valid

    promise = product.$save()
    successMessage = if product.id? then "Product was updated" else "Product was created"

    promise.then =>
      @alerts.success successMessage
      @$location.path "/products"

  reset: ->
    return if @isClean()

    @product = angular.copy(@remote)
    @$scope.product = @product

  delete: ->
    promise = @product.$delete()
    promise.then =>
      @alerts.info "Product was deleted"
      @$location.path "/products"

angular.module("myApp")
  .controller("products.FormCtrl", FormCtrl)
