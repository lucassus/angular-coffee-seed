app = require("../lib/app")
expect = require("chai").expect
request = require("supertest")

describe "The application", ->

  describe "GET /api/products.json", ->

    it "returns a list of products", (done) ->
      request(app)
        .get("/api/products.json")
        .set("Accept", "application/json")
        .expect("Content-Type", /json/)
        .expect(200)
        .end (error, resp) ->
          products = resp.body

          expect(products).to.not.be.undefined
          expect(products.rows.length).to.equal 6

          done()

  describe "POST /api/products.json", ->

    it "creates a product", (done) ->
      request(app)
        .post("/api/products.json")
        .set("Accept", "application/json")
        .send(name: "New product")
        .expect("Content-Type", /json/)
        .expect(200)
        .end (error, resp) ->
          product = resp.body

          expect(product).to.not.be.undefined
          expect(product.id).to.equal 7
          expect(product.name).to.equal "New product"

          done()

  describe "POST /api/products/:id.json", ->

    it "updates a product", (done) ->
      request(app)
        .post("/api/products/2.json")
        .set("Accept", "application/json")
        .send(name: "New name", description: "New description")
        .expect("Content-Type", /json/)
        .expect(200)
        .end (error, resp) ->
          product = resp.body

          expect(product).to.not.be.undefined
          expect(product.id).to.equal 2
          expect(product.name).to.equal "New name"
          expect(product.description).to.equal "New description"

          done()

  describe "GET /api/products/:id.json", ->

    context "when the prouct can be found", ->

      it "finds a product", (done) ->
        request(app)
          .get("/api/products/1.json")
          .set("Accept", "application/json")
          .expect("Content-Type", /json/)
          .expect(200)
          .end (error, resp) ->
            product = resp.body

            expect(product).to.not.be.undefined
            expect(product.id).to.equal 1
            expect(product.name).to.equal "HTC Wildfire"

            done()

    context "when the product cannot be found", ->

      it "raises 404 error", (done) ->
        request(app)
          .get("/api/products/123.json")
          .set("Accept", "application/json")
          .expect(404, done)

  xdescribe "DELETE /api/products/:id.json", ->

    context "when the product can be found", ->

      it "deletes the product", (done) ->
        request(app)
          .delete("/api/products/3.json")
          .set("Accept", "application/json")
          .expect("Content-Type", /json/)
          .expect(200)
          .end (error, resp) ->
            done()
