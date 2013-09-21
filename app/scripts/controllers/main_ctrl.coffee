class MainCtrl

  @$inject = ["products"]
  constructor: (@products) ->

angular.module("myApp")
  .controller("MainCtrl", MainCtrl)
