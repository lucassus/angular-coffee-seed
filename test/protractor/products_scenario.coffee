util = require("util")
fixtures = require("./helpers/fixtures")

PageObject = require("./helpers/page_object/products_list_page")

describe "Products page", ->
  ptor = null
  po = null

  beforeEach ->
    po = new PageObject(protractor)
    ptor = protractor.getInstance()

    fixtures.load -> ptor.get "/"

  it "displays a valid page title", ->
    expect(ptor.getTitle()).toEqual "Angular Seed"

  it "displays the list of products", ->
    po.greeting().then (greeting) ->
      expect(greeting.getText()).toEqual "You have 6 products"

    po.productNames().then (productNames) ->
      expect(productNames.length).toEqual 6

      expect(productNames[0].getText()).toEqual "HTC Wildfire"
      expect(productNames[1].getText()).toEqual "Nexus One"

    firstProduct = po.nthProduct(1)

    firstProduct.getId().then (id) ->
      expect(id).not.toBeUndefined()

    firstProduct.getName().then (name) ->
      expect(name).toEqual "HTC Wildfire"

    firstProduct.getDescription().then (description) ->
      expect(description).not.toBeUndefined()

  describe "create new product", ->

    beforeEach -> po.clickCreateButton()

    it "creates a new product", ->
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
