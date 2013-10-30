module.exports = Object.create Object::,

  greeting: get: ->
    browser.findElement protractor.By.binding("You have {{index.products.length}} products")

  createButton: get: ->
    browser.findElement protractor.By.xpath("//a[contains(text(), 'Create new product')]")

  table: get: ->
    table = browser.findElement protractor.By.css "table.products"
    locator = protractor.By.repeater("product in index.products")

    Object.create table,
      nthProduct: value: (index) =>
        require("./index_page/row_view")(table, locator.row(index))

      productNames: get: ->
        @findElements locator.column("product.name")
