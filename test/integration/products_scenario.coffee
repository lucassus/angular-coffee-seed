require("jasmine-only")
utils = require("./helpers/utils")

describe "Products page", ->
  indexPage = null
  alertView = null

  beforeEach ->
    indexPage = require("./helpers/page_objects/products/index_page")
    alertView = require("./helpers/page_objects/alert_view")

    utils.loadFixtures -> browser.get "/"

  it "displays a valid page title", ->
    expect(browser.getCurrentUrl()).toEqual "http://localhost:9001/#/products"
    expect(browser.getTitle()).toEqual "Angular Seed"

  describe "products list page", ->

    it "displays the list of products", ->
      expect(indexPage.greeting.getText()).toEqual "You have 6 products"

      indexPage.table.productNames.then (names) ->
        expect(names.length).toEqual 6

        expect(names[0].getText()).toEqual "HTC Wildfire"
        expect(names[1].getText()).toEqual "Nexus One"
        expect(names[2].getText()).toEqual "Nexus 7"
        expect(names[3].getText()).toEqual "iPhone"
        expect(names[4].getText()).toEqual "Samsung Galaxy Note"
        expect(names[5].getText()).toEqual "Samsung S4"

    it "displays correct columns", ->
      tableRow = indexPage.table.nthProduct(0)

      expect(tableRow.id.isDisplayed()).toBeTruthy()

      expect(tableRow.name.isDisplayed()).toBeTruthy()
      expect(tableRow.name.getText()).toEqual "HTC Wildfire"

      expect(tableRow.description.isDisplayed()).toBeTruthy()
      expect(tableRow.description.isDisplayed()).toBeTruthy()

    describe "delete product button", ->

      it "deletes the product", ->
        tableRow = indexPage.table.nthProduct(1)
        tableRow.deleteButton.click()

        expect(alertView.info.isDisplayed()).toBeTruthy()
        expect(alertView.info.getText()).toEqual "Product was deleted"
        expect(indexPage.greeting.getText()).toEqual "You have 5 products"

  describe "create new product", ->
    formPage = null

    beforeEach ->
      indexPage.createButton.click()
      formPage = require("./helpers/page_objects/products/form_page")

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
      tableRow = indexPage.table.nthProduct(2)
      tableRow.editButton.click()

      formPage = require("./helpers/page_objects/products/form_page")

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
      tableRow = indexPage.table.nthProduct(0)
      tableRow.showButton.click()

      showPage = require("./helpers/page_objects/products/show_page")

    it "displays product details", ->
      expect(showPage.product.name.getText()).toEqual "HTC Wildfire"
      expect(showPage.product.description.getText()).toEqual "Old android phone"

    describe "edit button", ->

      it "navigates to edit product page", ->
        showPage.editButton.click()
        expect(browser.getCurrentUrl()).toMatch /products\/\d+\/edit/

    describe "delete button", ->

      it "deletes the product", ->
        showPage.deleteButton.click()

        expect(alertView.info.isDisplayed()).toBeTruthy()
        expect(alertView.info.getText()).toEqual "Product was deleted"
        expect(indexPage.greeting.getText()).toEqual "You have 5 products"
