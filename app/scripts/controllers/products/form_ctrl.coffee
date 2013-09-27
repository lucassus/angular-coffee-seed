# TODO test it
class FormCtrl

  @$inject = ["$scope", "product"]
  constructor: (@$scope, @product) ->
    @$scope.product = @product

  save: (product) ->
    @$scope.productForm.$submitted = true
    return unless @$scope.productForm?.$valid

    product.$save()

angular.module("myApp")
  .controller("products.FormCtrl", FormCtrl)
