describe "Controller `products.IndexCtrl`", ->

  beforeEach module "myApp"
  ctrl = null

  # Initialize the controller and a mock scope
  beforeEach inject ($controller) ->
    ctrl = $controller "products.IndexCtrl",
      products: [{ name: "one" }, { name: "two" }]

  it "has a list of products", ->
    expect(ctrl.products.length).to.equal 2
