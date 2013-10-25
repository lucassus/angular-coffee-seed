describe "Controller `products.IndexCtrl`", ->

  # stub external services
  beforeEach module "myApp", ($provide) ->
    $provide.decorator "alerts", ($delegate) ->
      sinon.stub($delegate)
      $delegate

  $scope = null
  ctrl = null

  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()

    ctrl = $controller "products.IndexCtrl",
      $scope: $scope
      products: [{ name: "one" }, { name: "two" }]

  it "has a list of products", ->
    expect(ctrl.products).to.not.be.undefined
    expect(ctrl.products.length).to.equal 2

  describe "#deleteProduct()", ->
    product = null

    beforeEach inject ($q) ->
      deferred = $q.defer()
      deferred.resolve(true) # always resolved

      product = $delete: sinon.stub().returns deferred.promise
      $scope.$apply -> ctrl.deleteProduct(product)

    it "deletes the product", ->
      expect(product.$delete).to.be.called

    it "sets an alert", inject (alerts) ->
      expect(alerts.info).to.be.calledWith "Product was deleted"
