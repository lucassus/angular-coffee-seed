util = require("util")
fixtures = require("./helpers/fixtures")

describe "Products page", ->
  ptor = null
  indexPage = null

  beforeEach ->
    indexPage = require("./helpers/page_objects/products/index_page")(protractor)
    ptor = protractor.getInstance()

    fixtures.load -> ptor.get "/"

  it "displays a valid page title", ->
    expect(ptor.getCurrentUrl()).toEqual "http://localhost:9001/#/products"
    expect(ptor.getTitle()).toEqual "Angular Seed"

  describe "products list page", ->

    it "displays the list of products", ->
      expect(indexPage.greeting().getText()).toEqual "You have 6 products"

      indexPage.productNames().then (productNames) ->
        expect(productNames.length).toEqual 6

        expect(productNames[0].getText()).toEqual "HTC Wildfire"
        expect(productNames[1].getText()).toEqual "Nexus One"

    it "displays correct columns", ->
      product = indexPage.nthProduct(1)

      expect(product.id.isDisplayed()).toBeTruthy()
      expect(product.name.getText()).toEqual "HTC Wildfire"
      expect(product.description.isDisplayed()).toBeTruthy()

  describe "create new product", ->
    formPage = null

    beforeEach ->
      indexPage.clickCreateButton()
      formPage = require("./helpers/page_objects/products/form_page")(protractor)

    it "creates new product", ->
      formPage.setName "New product"
      formPage.setPrice "9.99"
      formPage.setDescription "this is the description"
      formPage.submit()

      expect(indexPage.alert.success().isDisplayed()).toBeTruthy()
      expect(indexPage.alert.success().getText()).toEqual "Product was created"
      expect(indexPage.greeting().getText()).toEqual "You have 7 products"

  describe "edit a product", ->
    formPage = null

    beforeEach ->
      thirdProduct = indexPage.nthProduct(3)
      thirdProduct.editButton.click()

      formPage = require("./helpers/page_objects/products/form_page")(protractor)

    it "updates a product", ->
      formPage.setName "New name"
      formPage.setPrice "199.99"
      formPage.setDescription "this is the new description"
      formPage.submit()

      expect(indexPage.alert.success().isDisplayed()).toBeTruthy()
      expect(indexPage.alert.success().getText()).toEqual "Product was updated"

  describe "delete a product", ->

    it "deletes a product", ->
      secondProduct = indexPage.nthProduct(2)
      secondProduct.deleteButton.click()

      expect(indexPage.alert.info().isDisplayed()).toBeTruthy()
      expect(indexPage.alert.info().getText()).toEqual "Product was deleted"
      expect(indexPage.greeting().getText()).toEqual "You have 5 products"
