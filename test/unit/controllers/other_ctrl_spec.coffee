describe "Controller: OtherCtrl", ->

  beforeEach module("myApp")
  ctrl = null

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, alerts) ->
    ctrl = $controller "OtherCtrl"

    spyOn(alerts, "info")

  it "should attach a name", ->
    expect(ctrl.name).toBe "This is the other controller"

  it "should display the flash message", inject (alerts) ->
    ctrl.sayHello()
    expect(alerts.info).toHaveBeenCalledWith("Hello World!")
