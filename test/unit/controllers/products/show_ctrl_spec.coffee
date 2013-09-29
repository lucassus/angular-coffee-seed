describe "Controller `products.ShowCtrl`", ->

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

  # Initialize the controller and a mock scope
  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()

    ctrl = $controller "products.ShowCtrl",
      $scope: $scope

  describe "$scope", ->

    it "has a product", ->
      expect($scope.product).to.not.be.undefined
      expect($scope.product.id).to.equal 1
      expect($scope.product.name).to.equal "foo"

  describe "#deleteProduct()", ->
    beforeEach ->
      $scope.$apply -> ctrl.deleteProduct()

    it "deletes the product", inject (product) ->
      expect(product.$delete).to.be.called

    it "sets an alert", inject (alerts) ->
      expect(alerts.info).to.be.calledWith "Product was deleted"

    it "redirects to the products list page", inject ($location) ->
      expect($location.path).to.be.calledWith "/products"
