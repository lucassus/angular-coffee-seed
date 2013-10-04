util = require("util")

describe "angularjs homepage", ->
  ptor = null

  beforeEach ->
    ptor = protractor.getInstance()
    ptor.get "http://localhost:9001"

  it "displays the list of products", ->
    greeting = ptor.findElement(protractor.By.binding("{{index.products.length}}"))
    expect(greeting.getText()).toEqual "You have 6 products"

    results = ptor.findElements(protractor.By.repeater("product in index.products").column("product.name"))
    results.then (products) ->
      expect(products.length).toEqual 6

      firstProduct = products[0]
      firstProduct.getText().then (text) ->
        expect(text).toEqual "HTC Wildfire"
