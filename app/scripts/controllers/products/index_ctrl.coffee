class IndexCtrl

  @$inject = ["products"]
  constructor: (@products) ->

angular.module("myApp")
  .controller("products.IndexCtrl", IndexCtrl)
