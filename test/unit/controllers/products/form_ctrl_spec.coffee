describe "Controller `products.FormCtrl`", ->

  # stub external services
  beforeEach module "myApp", ($provide) ->
    $provide.factory "product", ($q) ->
      promise = ->
        deferred = $q.defer()
        deferred.resolve(true) # always resolved
        deferred.promise

      id: 1, name: "foo"
      $save: sinon.stub().returns promise()
      $delete: sinon.stub().returns promise()

    $provide.value "$location", sinon.stub(path: angular.noop)
    $provide.value "alerts", sinon.stub(success: angular.noop, info: angular.noop)

    return

  $scope = null
  ctrl = null

  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()
    $scope.productForm = {}

    ctrl = $controller "products.FormCtrl", $scope: $scope

  describe "$scope", ->

    it "has a product", ->
      expect($scope.product).not.to.be.undefined
      expect($scope.product.id).to.equal 1
      expect($scope.product.name).to.equal "foo"

  describe "#save()", ->

    context "when the form is invalid", ->
      beforeEach inject (product) -> ctrl.save(product)

      it "does nothing", inject (product) ->
        expect(product.$save).not.to.be.called

    context "when the form is valid", ->
      beforeEach inject (product) ->
        $scope.productForm = $valid: true
        $scope.$apply -> ctrl.save(product)

      it "saves a product", inject (product) ->
        expect(product.$save).to.be.called

      it "sets an alert", inject (alerts) ->
        expect(alerts.success).to.be.calledWith "Product was updated"

      it "redirects to the products list page", inject ($location) ->
        expect($location.path).to.be.calledWith "/products"

  describe "#deleteProduct()", ->
    beforeEach ->
      $scope.$apply -> ctrl.deleteProduct()

    it "deletes the product", inject (product) ->
      expect(product.$delete).to.be.called

    it "sets an alert", inject (alerts) ->
      expect(alerts.info).to.be.calledWith "Product was deleted"

    it "redirects to the products list page", inject ($location) ->
      expect($location.path).to.be.calledWith "/products"
