util = require("util")
fixtures = require("./helpers/fixtures")

IndexPage = require("./helpers/page_objects/products/index_page")
FormPage = require("./helpers/page_objects/products/form_page")

describe "Products page", ->
  ptor = null
  indexPage = null

  beforeEach ->
    indexPage = new IndexPage(protractor)
    ptor = protractor.getInstance()

    fixtures.load -> ptor.get "/"

  it "displays a valid page title", ->
    expect(ptor.getTitle()).toEqual "Angular Seed"

  describe "products list page", ->

    it "displays the list of products", ->
      indexPage.greeting().then (greeting) ->
        expect(greeting.getText()).toEqual "You have 6 products"

      indexPage.productNames().then (productNames) ->
        expect(productNames.length).toEqual 6

        expect(productNames[0].getText()).toEqual "HTC Wildfire"
        expect(productNames[1].getText()).toEqual "Nexus One"

    it "displays correct columns", ->
      firstProduct = indexPage.nthProduct(1)

      firstProduct.getId().then (id) ->
        expect(id).not.toBeUndefined()

      firstProduct.getName().then (name) ->
        expect(name).toEqual "HTC Wildfire"

      firstProduct.getDescription().then (description) ->
        expect(description).not.toBeUndefined()

  describe "create new product", ->
    formPage = null

    beforeEach ->
      indexPage.clickCreateButton()
      formPage = new FormPage(protractor)

    it "creates new product", ->
      formPage.setName "New product"
      formPage.setPrice "9.99"
      formPage.setDescription "this is the description"
      formPage.submit()

      indexPage.alert().success().then (alert) ->
        expect(alert.getText()).toEqual "Product was created"

      indexPage.greeting().then (greeting) ->
        expect(greeting.getText()).toEqual "You have 7 products"

  describe "edit a product", ->
    formPage = null

    beforeEach ->
      thirdProduct = indexPage.nthProduct(3)
      thirdProduct.getEditButton().click()

      formPage = new FormPage(protractor)

    it "updates a product", ->
      formPage.setName "New name"
      formPage.setPrice "199.99"
      formPage.setDescription "this is the new description"
      formPage.submit()

      indexPage.alert().success().then (alert) ->
        expect(alert.getText()).toEqual "Product was updated"

  describe "delete a product", ->

    it "deletes a product", ->
      secondProduct = indexPage.nthProduct(2)
      secondProduct.getDeleteButton().click()

      indexPage.alert().info().then (alert) ->
        expect(alert.getText()).toEqual "Product was deleted"

      indexPage.greeting().then (greeting) ->
        expect(greeting.getText()).toEqual "You have 5 products"
