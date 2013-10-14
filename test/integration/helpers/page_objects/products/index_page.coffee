module.exports = (protractor) ->
  ptor = protractor.getInstance()

  alert: require("../alert_view")(protractor)

  greeting: ->
    ptor.findElement protractor.By.binding("You have {{index.products.length}} products")

  productNames: ->
    ptor.findElements protractor.By.repeater("product in index.products").column("product.name")

  nthProduct: (index) ->
    locator = protractor.By.repeater("product in index.products").row(index)

    byBinding = (binding) =>
      ptor.findElement locator.column(binding)

    id: byBinding("product.id")
    name: byBinding("product.name")
    description: byBinding("product.description")

    editButton: ptor.findElement(locator).findElement protractor.By.css("a.btn-success")
    deleteButton: ptor.findElement(locator).findElement protractor.By.css("button.btn-danger")

  createButton: ->
    ptor.findElement protractor.By.xpath("//a[contains(text(), 'Create')]")

  clickCreateButton: ->
    @createButton().click()
