describe "Controller `products.FormCtrl`", ->

  beforeEach module "myApp"

  $scope = null
  ctrl = null
  product = null

  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()
    $scope.productForm = {}

    product = sinon.stub(id: 1, name: "foo", $save: angular.noop)

    ctrl = $controller "products.FormCtrl",
      $scope: $scope
      product: product

  describe "$scope", ->

    it "has a product", ->
      expect($scope.product).not.to.be.undefined
      expect($scope.product.id).to.equal 1
      expect($scope.product.name).to.equal "foo"

  describe "#save()", ->

    context "when the form is invalid", ->
      beforeEach -> ctrl.save(product)

      it "does nothing", ->
        expect(product.$save).not.to.be.called

    # TODO finish it
    xcontext "when the form is valid", ->
      beforeEach ->
        $scope.productForm = $valid: true
        ctrl.save(product)

      it "saves a product", ->
        expect(product.$save).to.be.called

      it "redirects to the list page"
