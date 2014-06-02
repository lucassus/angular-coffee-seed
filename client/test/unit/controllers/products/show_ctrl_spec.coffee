describe "Controller `products.ShowCtrl`", ->

  beforeEach module "myApp", ->

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
