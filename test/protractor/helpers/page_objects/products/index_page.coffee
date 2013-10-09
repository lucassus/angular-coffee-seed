PageObject = require("../../page_object")

class ProductsListPage extends PageObject

  greeting: ->
    @findElement "binding", "You have {{index.products.length}} products"

  productNames: ->
    locator = @getter("repeater", "product in index.products").column("product.name")
    @ptor.findElements(locator)

  nthProduct: (index) ->
    locator = @getter("repeater", "product in index.products").row(index)

    byBinding = (binding) =>
      @ptor.findElement(locator.column(binding))

    getId: ->
      byBinding("product.id").getText()

    getName: ->
      byBinding("product.name").getText()

    getDescription: ->
      byBinding("product.description").getText()

    getEditButton: =>
      @ptor.findElement(locator).findElement(@getter("css", "a.btn-success"))

    getDeleteButton: =>
      @ptor.findElement(locator).findElement(@getter("css", "button.btn-danger"))

  clickCreateButton: ->
    createButton = @findElement "xpath", "//a[contains(text(), 'Create')]"
    createButton.click()

module.exports = ProductsListPage
