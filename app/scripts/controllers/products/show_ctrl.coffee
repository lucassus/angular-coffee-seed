class ShowCtrl

  @$inject = ["product"]
  constructor: (@product) ->

angular.module("myApp")
  .controller("products.ShowCtrl", ShowCtrl)
