describe "Controller `products.ShowActionsCtrl`", ->

  # stub external services
  beforeEach module "myApp", ($provide) ->
    $provide.value "$state", sinon.stub(go: ->)
    $provide.value "$window", confirm: sinon.stub()

    $provide.decorator "alerts", ($delegate) ->
      sinon.stub($delegate)
      $delegate

  $scope = null
  ctrl = null

  beforeEach inject ($rootScope, $controller, Products) ->
    $scope = $rootScope.$new()
    product = new Products(id: 123, name: "foo")
    $scope.product = product

    ctrl = $controller "products.ShowActionsCtrl",
      $scope: $scope

  describe "$scope", ->

    it "has a product", ->
      expect($scope.product).to.not.be.undefined
      expect($scope.product).to.have.property "id", 123
      expect($scope.product).to.have.property "name", "foo"

  describe "#deleteProduct()", ->
    beforeEach inject ($window) ->
      $window.confirm.returns(false)

    it "displays a confirmation dialog", inject ($window) ->
      ctrl.deleteProduct()

      expect($window.confirm.called).to.be.true
      expect($window.confirm.calledWith("Are you sure?")).to.be.true

    context "when the confirmation dialog was accepted", ->
      beforeEach inject ($httpBackend) ->
        $httpBackend.expectDELETE("/api/products/123.json").respond 200

      beforeEach inject ($window, $httpBackend) ->
        $window.confirm.returns(true)

        ctrl.deleteProduct()
        $httpBackend.flush()

      it "deletes the product", inject ($httpBackend) ->
        $httpBackend.verifyNoOutstandingExpectation()
        $httpBackend.verifyNoOutstandingRequest()

      it "sets an alert", inject (alerts) ->
        expect(alerts.info).to.be.calledWith "Product was deleted"

      it "redirects to the products list page", inject ($state) ->
        expect($state.go).to.be.calledWith "products.list"

    context "when the confirmation was not accepted", ->
      beforeEach inject ($window) ->
        $window.confirm.returns(false)
        ctrl.deleteProduct()

      it "does not delete a product", inject ($httpBackend) ->
        $httpBackend.verifyNoOutstandingExpectation()
        $httpBackend.verifyNoOutstandingRequest()
