class OtherCtrl

  @$inject = ["alerts"]
  constructor: (@alerts) ->
    @name = "This is the other controller"

  sayHello: ->
    @alerts.info("Hello World!")

angular.module("myApp")
  .controller("OtherCtrl", OtherCtrl)
