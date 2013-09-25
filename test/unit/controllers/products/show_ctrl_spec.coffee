describe "Controller `products.ShowCtrl`", ->

  beforeEach module "myApp"

  ctrl = null
  $scope = null

  # Initialize the controller and a mock scope
  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()

    ctrl = $controller "products.ShowCtrl",
      $scope: $scope
      product: id: 1, name: "one"

  describe "$scope", ->

    it "has a product", ->
      expect($scope.product).to.not.be.undefined
      expect($scope.product.id).to.equal 1
      expect($scope.product.name).to.equal "one"
