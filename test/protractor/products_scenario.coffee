util = require("util")
fixtures = require("./helpers/fixtures")

describe "Products page", ->
  ptor = null

  beforeEach ->
    ptor = protractor.getInstance()
    fixtures.load -> ptor.get "/"

  it "displays the list of products", ->
    greeting = ptor.findElement(protractor.By.binding("{{index.products.length}}"))
    expect(greeting.getText()).toEqual "You have 6 products"

    results = ptor.findElements(protractor.By.repeater("product in index.products").column("product.name"))
    results.then (products) ->
      expect(products.length).toEqual 6

      firstProduct = products[0]
      firstProduct.getText().then (text) ->
        expect(text).toEqual "HTC Wildfire"

  describe "create new product", ->

    it "creates a new product", ->
      createButton = ptor.findElement(protractor.By.xpath("//a[contains(text(), 'Create')]"))
      createButton.click()

      name = ptor.findElement(protractor.By.input("product.name"))
      name.sendKeys "New product"

      price = ptor.findElement(protractor.By.input("product.price"))
      price.sendKeys "9.99"

      description = ptor.findElement(protractor.By.textarea("product.description"))
      description.sendKeys "this is the description"

      submitButton = ptor.findElement(protractor.By.xpath("//button[@type='submit']"))
      submitButton.click()

      results = ptor.findElement(protractor.By.css("div.alert-success span"))
      results.then (alert) ->
        expect(alert.getText()).toEqual "Product was saved"

      results = ptor.findElements(protractor.By.repeater("product in index.products").column("product.name"))
      results.then (products) ->
        expect(products.length).toEqual 7
