app = angular.module("myApp")

class FormCtrl extends BaseCtrl

  @register app, "products.FormCtrl"
  @inject "$scope", "$location", "alerts", { "product": "remote" }

  initialize: ->
    @reset()

  save: (product) ->
    promise = product.$save()
    successMessage = if product.persisted() then "Product was updated" else "Product was created"

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
