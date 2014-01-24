expect = require("./helpers/expect")
utils = require("./helpers/utils")

AlertView = require("./helpers/page_objects/alert_view")
IndexPage = require("./helpers/page_objects/products/index_page")
FormPage = require("./helpers/page_objects/products/form_page")
ShowPage = require("./helpers/page_objects/products/show_page")

describe "Products page", ->
  alertView = null
  indexPage = null

  beforeEach ->
    alertView = new AlertView()
    indexPage = new IndexPage()

    utils.loadFixtures()
    browser.get "/"

  it "displays a valid page title", ->
    expect(browser.getCurrentUrl()).to.eventually.match /#\/products$/
    expect(browser.getTitle()).to.eventually.eq "Angular Seed"

  describe "products list page", ->

    it "displays the list of products", ->
      expect(indexPage.greeting.getText()).to.eventually.eq "You have 6 products"

      indexPage.table.productNames.then (names) ->
        expect(names.length).to.eq 6

        expect(names[0].getText()).to.eventually.eq "HTC Wildfire"
        expect(names[1].getText()).to.eventually.eq "Nexus One"
        expect(names[2].getText()).to.eventually.eq "Nexus 7"
        expect(names[3].getText()).to.eventually.eq "iPhone"
        expect(names[4].getText()).to.eventually.eq "Samsung Galaxy Note"
        expect(names[5].getText()).to.eventually.eq "Samsung S4"

    it "displays correct columns", ->
      row = indexPage.table.rowAt(0)

      expect(row.id.isDisplayed()).to.eventually.be.true

      expect(row.name.isDisplayed()).to.eventually.be.true
      expect(row.name.getText()).to.eventually.eq "HTC Wildfire"

      expect(row.description.isDisplayed()).to.eventually.be.true
      expect(row.description.isDisplayed()).to.eventually.be.true

    describe "click on `delete` button", ->
      beforeEach ->
        row = indexPage.table.rowAt(1)
        row.deleteButton.click()

      it "deletes the product", ->
        expect(indexPage.greeting.getText()).to.eventually.eq "You have 5 products"

      it "sets an alert message ", ->
        expect(alertView.info.isDisplayed()).to.eventually.be.true
        expect(alertView.info.getText()).to.eventually.eq "Product was deleted"

  describe "create new product", ->
    formPage = null

    beforeEach ->
      indexPage.createButton.click()
      formPage = new FormPage()

    it "displays a form for creating a new product", ->
      expect(formPage.nameField.getAttribute("value")).to.eventually.eq ""
      expect(formPage.descriptionField.getAttribute("value")).to.eventually.eq ""
      expect(formPage.submitButton.getText()).to.eventually.eq "Create"

    describe "click on `create` button", ->
      beforeEach ->
        formPage.setName "New product"
        formPage.setPrice "9.99"
        formPage.setDescription "this is the description"
        formPage.submitButton.click()

      it "creates new product", ->
        expect(alertView.success.isDisplayed()).to.eventually.be.true
        expect(alertView.success.getText()).to.eventually.eq "Product was created"
        expect(indexPage.greeting.getText()).to.eventually.eq "You have 7 products"

      it "redirects to the products page", ->
        expect(browser.getCurrentUrl()).to.eventually.match /#\/products$/

    describe "click on `reset` button", ->
      beforeEach ->
        formPage.setName "New product"
        formPage.setPrice "9.99"
        formPage.setDescription "this is the description"

      it "clears the form", ->
        formPage.resetButton.click()

        expect(formPage.nameField.getAttribute("value")).to.eventually.eq ""
        expect(formPage.priceField.getAttribute("value")).to.eventually.eq ""
        expect(formPage.descriptionField.getText()).to.eventually.eq ""

  describe "edit a product", ->
    formPage = null

    beforeEach ->
      row = indexPage.table.rowAt(2)
      row.editButton.click()

      formPage = new FormPage()

    it "displays a form for updating the product", ->
      expect(formPage.nameField.getAttribute("value")).to.eventually.eq "Nexus 7"
      expect(formPage.priceField.getAttribute("value")).to.eventually.eq "1200"
      expect(formPage.discountField.getAttribute("value")).to.eventually.eq "12"
      expect(formPage.submitButton.getText()).to.eventually.eq "Update"

    describe "click on `update` button", ->
      beforeEach ->
        formPage.setName "New name"
        formPage.setPrice "199.99"
        formPage.setDescription "this is the new description"
        formPage.submitButton.click()

      it "updates the product", ->
        expect(alertView.success.isDisplayed()).to.eventually.be.true
        expect(alertView.success.getText()).to.eventually.eq "Product was updated"

      it "redirects to the products page", ->
        expect(browser.getCurrentUrl()).to.eventually.match /#\/products$/

    describe "click on `reset` button", ->
      beforeEach ->
        formPage.setName "New name"
        formPage.setPrice "199.99"

      it "rollbacks all changes", ->
        formPage.resetButton.click()

        expect(formPage.nameField.getAttribute("value")).to.eventually.eq "Nexus 7"
        expect(formPage.priceField.getAttribute("value")).to.eventually.eq "1200"

  describe "show a product", ->
    showPage = null

    beforeEach ->
      row = indexPage.table.rowAt(0)
      row.showButton.click()

      showPage = new ShowPage()

    it "displays the product basic info", ->
      expect(showPage.product.name.getText()).to.eventually.eq "HTC Wildfire"
      expect(showPage.product.description.getText()).to.eventually.eq "Old android phone"

    describe "switch to details tab", ->
      beforeEach -> showPage.tabDetails.click()

      it "displays product details", ->
        expect(browser.getCurrentUrl()).to.eventually.match /#\/products\/\d+\/details/
        expect(showPage.product.manufacturer.getText()).to.eventually.eq "HTC"

    describe "`Actions` tab", ->
      beforeEach -> showPage.tabActions.click()

      describe "click on `edit` button", ->
        beforeEach -> showPage.editButton.click()

        it "navigates to edit product page", ->
          expect(browser.getCurrentUrl()).to.eventually.match /#\/products\/\d+\/edit/

      describe "click on `delete` button", ->
        beforeEach ->
          # click on the delete button
          showPage.deleteButton.click()

          # ..verify that the confirmation dialog is present
          alert = browser.switchTo().alert()
          expect(alert.getText()).to.eventually.eq "Are you sure?"

          # ..accept the confirmation
          alert.accept()

        it "deletes the product", ->
          expect(alertView.info.isDisplayed()).to.eventually.be.true
          expect(alertView.info.getText()).to.eventually.eq "Product was deleted"
          expect(indexPage.greeting.getText()).to.eventually.eq "You have 5 products"

        it "redirects to the products page", ->
          expect(browser.getCurrentUrl()).to.eventually.match /#\/products$/
