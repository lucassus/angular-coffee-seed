require("jasmine-only")

util = require("util")
fixtures = require("./helpers/fixtures")

describe "Products page", ->
  ptor = null

  indexPage = null
  alertView = null

  beforeEach ->
    ptor = protractor.getInstance()

    indexPage = require("./helpers/page_objects/products/index_page")(protractor)
    alertView = require("./helpers/page_objects/alert_view")(protractor)

    fixtures.load -> ptor.get "/"

  it "displays a valid page title", ->
    expect(ptor.getCurrentUrl()).toEqual "http://localhost:9001/#/products"
    expect(ptor.getTitle()).toEqual "Angular Seed"

  describe "products list page", ->

    it "displays the list of products", ->
      expect(indexPage.greeting.getText()).toEqual "You have 6 products"

      indexPage.productNames.then (productNames) ->
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
      indexPage.createButton.click()
      formPage = require("./helpers/page_objects/products/form_page")(protractor)

    it "creates new product", ->
      formPage.setName "New product"
      formPage.setPrice "9.99"
      formPage.setDescription "this is the description"
      formPage.submitButton.click()

      expect(alertView.success.isDisplayed()).toBeTruthy()
      expect(alertView.success.getText()).toEqual "Product was created"
      expect(indexPage.greeting.getText()).toEqual "You have 7 products"

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
      formPage.submitButton.click()

      expect(alertView.success.isDisplayed()).toBeTruthy()
      expect(alertView.success.getText()).toEqual "Product was updated"

  describe "show a product", ->
    showPage = null

    beforeEach ->
      thirdProduct = indexPage.nthProduct(3)
      thirdProduct.showButton.click()

      showPage = require("./helpers/page_objects/products/show_page")(protractor)

    it "displays product page", ->
      expect(showPage.product.name.getText()).toEqual "HTC Wildfire"
      expect(showPage.product.description.getText()).toEqual "Old android phone"

  describe "delete a product", ->

    it "deletes a product", ->
      secondProduct = indexPage.nthProduct(2)
      secondProduct.deleteButton.click()

      expect(alertView.info.isDisplayed()).toBeTruthy()
      expect(alertView.info.getText()).toEqual "Product was deleted"
      expect(indexPage.greeting.getText()).toEqual "You have 5 products"
