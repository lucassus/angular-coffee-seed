class IndexCtrl

  @$inject = ["alerts", "products"]
  constructor: (@alerts, @products) ->

  deleteProduct: (product) ->
    promise = product.$delete()
    promise.then =>
      index = @products.indexOf(product)
      @products.splice(index, 1) if index isnt -1

      @alerts.info "Product was deleted"

angular.module("myApp")
  .controller("products.IndexCtrl", IndexCtrl)
