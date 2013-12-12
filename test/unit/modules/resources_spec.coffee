describe "Module `myApp.resources`", ->

  beforeEach module "myApp.resources"

  describe "Service `Products`", ->
    $rootScope = null
    $httpBackend = null
    Products = null

    beforeEach inject (_$rootScope_, _$httpBackend_, _Products_) ->
      $rootScope = _$rootScope_
      $httpBackend = _$httpBackend_
      Products = _Products_

    it "is defined", ->
      expect(Products).to.not.be.undefined

    describe ".query()", ->
      before -> @products = [{ name: "foo" }, { name: "bar" }]

      it "is defined", ->
        expect(Products.query).to.not.be.undefined

      it "queries for the records", ->
        $httpBackend.whenGET("/api/products.json").respond(@products)
        promise = Products.query().$promise
        $httpBackend.flush()

        products = null
        $rootScope.$apply ->
          promise.then (_products_) -> products = _products_

        expect(products).to.have.length 2

    describe ".get()", ->
      before -> @product = id: 123, name: "foo bar"

      it "is defined", ->
        expect(Products.get).to.not.be.undefined

      it "quries for a product", ->
        $httpBackend.whenGET("/api/products/123.json").respond(@product)
        promise = Products.get(id: 123).$promise
        expect(promise).to.not.be.undefined
        $httpBackend.flush()

        product = null
        $rootScope.$apply ->
          promise.then (_product_) -> product = _product_

        expect(product).to.not.be.null
        expect(product.id).to.equal 123
        expect(product.name).to.equal "foo bar"

    describe "#$save()", ->
      product = null

      context "when the `id` is not given", ->
        beforeEach inject (Products) ->
          product = new Products(name: "foo")

        it "creates a new record", ->
          $httpBackend.whenPOST("/api/products.json").respond({})

          promise = product.$save()
          expect(promise).to.not.be.undefined

          $httpBackend.flush()

      context "when the `id` is given", ->
        beforeEach inject (Products) ->
          product = new Products(id: 4567, name: "foo")

        it "updates the record", ->
          $httpBackend.whenPOST("/api/products/4567.json").respond({})

          promise = product.$save()
          expect(promise).to.not.be.undefined

          $httpBackend.flush()

    describe "#persisted()", ->
      product = null
      beforeEach -> product = new Products(id: @id)

      context "when the product has an id", ->
        before -> @id = 123

        it "returns true", ->
          expect(product.persisted()).to.be.true

      context "when the product does not have an id", ->
        before -> @id = null

        it "returns false", ->
          expect(product.persisted()).to.be.false

    describe "#priceWithDiscount()", ->
      product = null
      beforeEach inject (Products) ->
        product = new Products(price: @price, discount: @discount)

      it "is defined", ->
        expect(product.priceWithDiscount).to.not.be.undefined

      context "when discount is not defined", ->
        before ->
          @discount = undefined
          @price = 9.99

        it "returns the base price", ->
          expect(product.priceWithDiscount()).to.equal 9.99

      context "when discount is defined", ->
        before ->
          @discount = 22
          @price = 100

        it "returns price with discount", ->
          expect(product.priceWithDiscount()).to.equal 78

    describe "#hasDiscount()", ->
      # custom chai property for checking product's discount
      chai.Assertion.addProperty "discount", ->
        subject = @_obj

        @assert subject.hasDiscount(),
          "expected #\{this} to have discount",
          "expected #\{this} to not have discount"

      product = null
      beforeEach inject (Products) ->
        product = new Products(discount: @discount)

      it "is defined", ->
        expect(product.hasDiscount).to.not.be.undefined

      context "when the discount is not defined", ->
        before -> @discount = undefined

        it "returns false", ->
          expect(product).to.not.have.discount

      context "when the @discount is null", ->
        before -> @discount = null

        it "returns false", ->
          expect(product).to.not.have.discount

      context "when the @discount is 0", ->
        before -> @discount = 0

        it "returns false", ->
          expect(product).to.not.have.discount

      context "when the @discount < 0", ->
        before -> @discount = -10

        it "returns false", ->
          expect(product).to.not.have.discount

      context "when the @discount is > 0", ->
        before -> @discount = 10

        it "returns true", ->
          expect(product).to.have.discount
