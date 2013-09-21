describe "Controller: MainCtrl", ->

  beforeEach module("myApp")
  ctrl = null

  # Initialize the controller and a mock scope
  beforeEach inject ($controller) ->
    ctrl = $controller "MainCtrl"

  it "has a list of products to the scope", ->
    expect(ctrl.products.length).to.equal 6
