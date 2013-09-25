describe "Controller `products.ShowCtrl`", ->

  beforeEach module "myApp"
  ctrl = null

  # Initialize the controller and a mock scope
  beforeEach inject ($controller) ->
    ctrl = $controller "products.ShowCtrl",
      product: id: 1, name: "one"

  it "has a product", ->
    expect(ctrl.product).to.not.be.undefined
    expect(ctrl.product.id).to.equal 1
    expect(ctrl.product.name).to.equal "one"
