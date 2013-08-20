describe "Controller: MainCtrl", ->

  beforeEach module("myApp")
  ctrl = null

  # Initialize the controller and a mock scope
  beforeEach inject ($controller) ->
    ctrl = $controller "MainCtrl"

  it "should attach a list of products to the scope", ->
    expect(ctrl.products.length).toBe 6
