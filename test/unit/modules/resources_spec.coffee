# TODO use this convention for the other specs
describe "module: myApp.resources", ->
  beforeEach module "myApp.resources"

  describe "service: Products", ->
    $rootScope = null
    $httpBackend = null
    Products = null

    beforeEach inject (_$rootScope_, _$httpBackend_, _Products_) ->
      $rootScope = _$rootScope_
      $httpBackend = _$httpBackend_
      Products = _Products_

    it "is defined", ->
      expect(Products).to.not.be.undefined

    describe "#query", ->
      products = null
      beforeEach -> products = [{ name: "foo" }, { name: "bar" }]

      it "is defined", ->
        expect(Products.query).to.not.be.undefined

      it "queries for the record", ->
        $httpBackend.whenGET("/api/products.json").respond(products)

        promise = Products.query().$promise

        $httpBackend.flush()

        products = null
        $rootScope.$apply ->
          promise.then (_products_) -> products = _products_

        expect(products).to.have.length 2

        # TODO write specs for `product.priceWithDiscount` and `product.hasDiscount`
        product = products[0]
        expect(product).to.be.an.instanceof(Products)

        expect(product.hasDiscount).to.not.be.undefined
        expect(product.hasDiscount()).to.be.false
