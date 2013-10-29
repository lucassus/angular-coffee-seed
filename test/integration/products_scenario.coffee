require("jasmine-only")
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

      indexPage.table.productNames.then (names) ->
        expect(names.length).toEqual 6

        expect(names[0].getText()).toEqual "HTC Wildfire"
        expect(names[1].getText()).toEqual "Nexus One"

    it "displays correct columns", ->
      tableRow = indexPage.table.nthProduct(1)

      expect(tableRow.id.isDisplayed()).toBeTruthy()

      expect(tableRow.name.isDisplayed()).toBeTruthy()
      expect(tableRow.name.getText()).toEqual "HTC Wildfire"

      expect(tableRow.description.isDisplayed()).toBeTruthy()
      expect(tableRow.description.isDisplayed()).toBeTruthy()

    describe "delete product button", ->

      it "deletes the product", ->
        tableRow = indexPage.table.nthProduct(2)
        tableRow.deleteButton.click()

        expect(alertView.info.isDisplayed()).toBeTruthy()
        expect(alertView.info.getText()).toEqual "Product was deleted"
        expect(indexPage.greeting.getText()).toEqual "You have 5 products"

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
      tableRow = indexPage.table.nthProduct(3)
      tableRow.editButton.click()

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
      tableRow = indexPage.table.nthProduct(3)
      tableRow.showButton.click()

      showPage = require("./helpers/page_objects/products/show_page")(protractor)

    it "displays product details", ->
      expect(showPage.product.name.getText()).toEqual "HTC Wildfire"
      expect(showPage.product.description.getText()).toEqual "Old android phone"

    describe "edit button", ->

      it "navigates to edit product page", ->
        showPage.editButton.click()
        expect(ptor.getCurrentUrl()).toMatch /products\/\d+\/edit/

    describe "delete button", ->

      it "deletes the product", ->
        showPage.deleteButton.click()

        expect(alertView.info.isDisplayed()).toBeTruthy()
        expect(alertView.info.getText()).toEqual "Product was deleted"
        expect(indexPage.greeting.getText()).toEqual "You have 5 products"
