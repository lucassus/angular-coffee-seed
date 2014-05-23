expect = require("chai").expect
ProductProvider = require("../lib/product_provider")

describe "ProductProvider", ->
  productProvider = null
  beforeEach ->
    products = [
      { name: "one" }
      { name: "two" }
    ]
    productProvider = new ProductProvider(products)

  describe "a new instance", ->

    it "saves a prducts", ->
      expect(productProvider.products.length).to.equal 2

    describe "saved products", ->

      it "generates ids", ->
        products = productProvider.products
        expect(products[0].id).to.equal 1
        expect(products[1].id).to.equal 2

      it "assings createdAt date", ->
        products = productProvider.products
        expect(products[0].createdAt).to.not.be.undefined
        expect(products[1].createdAt).to.not.be.undefined

  describe "#findAll()", ->

    it "finds all products", (done) ->

      productProvider.findAll (error, products) ->
        expect(products.length).to.equal 2
        done()

  describe "#findAllPaged()", ->

    it "finds all products", (done) ->

      options = currentPage: 1
      productProvider.findAllPaged options, (error, result) ->
        products = result.rows
        expect(products.length).to.equal 2
        done()

  describe "#findById()", ->

    context "when the product can be found", ->

      it "returns the product", (done) ->

        productProvider.findById 1, (error, product) ->
          expect(product).not.to.be.undefined
          expect(product.id).to.equal 1
          expect(product.name).to.equal "one"
          done()

    context "when the product cannot be found", ->

      it "returns undefined", (done) ->

        productProvider.findById 3, (error, product) ->
          expect(product).to.be.undefined
          done()

  describe "#save()", ->

    context "when the single product is given", ->
      product = null
      beforeEach (done) ->
        productProvider.save name: "third", (error, _newProducts_) ->
          product = _newProducts_[0]
          done()

      it "saves a product", ->
          expect(product).not.to.be.undefined
          expect(product.name).to.equal "third"

      describe "new record", ->

        it "generates an id for the product", ->
            expect(product.id).to.equal 3

        it "assigns createdAt date", ->
            expect(product.createdAt).to.not.be.undefined

    context "when the array of products is given", ->
      products = null
      beforeEach (done) ->
        productProvider.save [{ name: "third" }, { name: "forth" }], (error, _newProducts_) ->
          products = _newProducts_
          done()

      it "saves the products", ->
          expect(products.length).to.equal 2
          expect(products[0].name).to.equal "third"
          expect(products[1].name).to.equal "forth"

      describe "new records", ->

        it "generates ids for all new records", ->
            expect(products[0].id).to.equal 3
            expect(products[1].id).to.equal 4

        it "assigns createdAt date for all new records", ->
            expect(products[0].createdAt).to.not.be.undefined
            expect(products[1].createdAt).to.not.be.undefined

  describe "#update()", ->

    it "updates a product", (done) ->
      params =
        id: "unknown"
        name: "New name"
        description: "New description"
        price: 99.99

      productProvider.update 1, params, (error, product) ->
        expect(product).to.not.be.undefined

        expect(product.id).to.equal 1
        expect(product.name).to.equal params.name
        expect(product.description).to.equal params.description
        expect(product.price).to.equal params.price

        done()

  describe "#destroy()", ->

    it "deletes a product", (done) ->

      productProvider.destroy 1, (error, product) ->
        expect(product).to.not.be.undefined
        expect(product.id).to.equal 1

        productProvider.findById product.id, (error, product) ->
          expect(product).to.be.undefined
          done()

  describe "#destroyAll()", ->

    it "deletes all products", (done) ->

      productProvider.destroyAll ->
        expect(productProvider.products.length).to.equal 0
        done()
