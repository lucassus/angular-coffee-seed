describe "Controller `products.FormCtrl`", ->

  # stub external services
  beforeEach module "myApp", ($provide) ->
    $provide.factory "product", (Products) -> new Products(id: 123, name: "foo")

    $provide.decorator "$location", ($delegate) ->
      sinon.stub($delegate, "path")
      $delegate

    $provide.decorator "alerts", ($delegate) ->
      sinon.stub($delegate)

  $scope = null
  ctrl = null

  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()
    $scope.productForm = {}

    ctrl = $controller "products.FormCtrl", $scope: $scope

  describe "$scope", ->

    it "has a product", ->
      expect($scope.product).not.to.be.undefined
      expect($scope.product).to.have.property "id", 123
      expect($scope.product).to.have.property "name", "foo"

  describe "#save()", ->

    context "when the form is valid", ->

      itSavesAProduct = ->
        it "saves a product", inject ($httpBackend) ->
          $httpBackend.verifyNoOutstandingExpectation()
          $httpBackend.verifyNoOutstandingRequest()

      itSetsAnAlertTo = (message) ->
        it "sets an alert", inject (alerts) ->
          expect(alerts.success).to.be.calledWith message

      itRedirectsToTheProductsListPage = ->
        it "redirects to the products list page", inject ($location) ->
          expect($location.path).to.be.calledWith "/products"

      context "on update", ->
        beforeEach inject ($httpBackend, product) ->
          $httpBackend.expectPOST("/api/products/123.json", id: 123, name: "bar").respond id: 123, name: "bar"

          product.name = "bar"
          ctrl.save(product)
          $httpBackend.flush()

        itSavesAProduct()
        itSetsAnAlertTo "Product was updated"
        itRedirectsToTheProductsListPage()

      context "on create", ->
        beforeEach inject ($httpBackend, product) ->
          $httpBackend.expectPOST("/api/products.json", name: "foo").respond id: 124, name: "foo"

          product.id = undefined
          product.name = "foo"

          ctrl.save(product)
          $httpBackend.flush()

        itSavesAProduct()
        itSetsAnAlertTo "Product was created"
        itRedirectsToTheProductsListPage()

  describe "#reset()", ->

    it "rollbacks product changes", ->
      ctrl.product.name = "new name"
      ctrl.reset()
      expect(ctrl.product).to.have.property "name", "foo"

  describe "#delete()", ->
    beforeEach inject ($httpBackend) ->
      $httpBackend.expectDELETE("/api/products/123.json").respond id: 123, name: "foo"

      ctrl.delete()
      $httpBackend.flush()

    it "deletes the product", inject ($httpBackend) ->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

    it "sets an alert", inject (alerts) ->
      expect(alerts.info).to.be.calledWith "Product was deleted"

    it "redirects to the products list page", inject ($location) ->
      expect($location.path).to.be.calledWith "/products"
