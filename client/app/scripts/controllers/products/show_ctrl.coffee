app = angular.module("myApp")

class ShowCtrl extends BaseCtrl

  @register app, "products.ShowCtrl"
  @inject "$scope", "product"

  initialize: ->
    @$scope.product = @product
