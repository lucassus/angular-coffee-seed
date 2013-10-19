PageObject = require("../../page_object")

class ProductsListPage extends PageObject

  greeting: ->
    @ptor.findElement @By.binding("You have {{index.products.length}} products")

  productNames: ->
    @ptor.findElements @By.repeater("product in index.products").column("product.name")

  nthProduct: (index) ->
    locator = @By.repeater("product in index.products").row(index)

    byBinding = (binding) =>
      @ptor.findElement locator.column(binding)

    id: byBinding("product.id")
    name: byBinding("product.name")
    description: byBinding("product.description")

    editButton: @ptor.findElement(locator).findElement @By.css("a.btn-success")
    deleteButton: @ptor.findElement(locator).findElement @By.css("button.btn-danger")

  clickCreateButton: ->
    createButton = @ptor.findElement @By.xpath("//a[contains(text(), 'Create')]")
    createButton.click()

module.exports = ProductsListPage
