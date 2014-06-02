app = angular.module("myApp")

class OtherCtrl extends BaseCtrl

  @register app, "OtherCtrl"
  @inject "alerts"

  initialize: ->
    @name = "This is the other controller"

  sayHello: ->
    @alerts.info("Hello World!")
