describe "Controller `products.ShowCtrl`", ->

  # stub external services
  beforeEach module "myApp", ($provide) ->
    $state = sinon.stub(go: ->)
    $provide.value "$state", $state

    $provide.decorator "alerts", ($delegate) ->
      sinon.stub($delegate)
      $delegate

  $scope = null
  ctrl = null

  beforeEach inject ($rootScope, $controller, Products) ->
    $scope = $rootScope.$new()
    product = new Products(id: 123, name: "foo")

    ctrl = $controller "products.ShowCtrl",
      $scope: $scope
      product: product

  describe "$scope", ->

    it "has a product", ->
      expect($scope.product).to.not.be.undefined
      expect($scope.product).to.have.property "id", 123
      expect($scope.product).to.have.property "name", "foo"

  describe "#deleteProduct()", ->
    beforeEach inject ($httpBackend) ->
      $httpBackend.expectDELETE("/api/products/123.json").respond 200

      ctrl.deleteProduct()
      $httpBackend.flush()

    it "deletes the product", inject ($httpBackend) ->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

    it "sets an alert", inject (alerts) ->
      expect(alerts.info).to.be.calledWith "Product was deleted"

    it "redirects to the products list page", inject ($state) ->
      expect($state.go).to.be.calledWith "products"
