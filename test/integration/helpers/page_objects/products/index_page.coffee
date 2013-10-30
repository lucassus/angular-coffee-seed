PageObject = require("./../page_object")
RowView = require("./index_page/row_view")

class IndexPage extends PageObject

  @has "greeting", ->
    browser.findElement protractor.By.binding("You have {{index.products.length}} products")

  @has "createButton", ->
    browser.findElement protractor.By.xpath("//a[contains(text(), 'Create new product')]")

  @has "table", ->
    table = browser.findElement protractor.By.css "table.products"
    locator = protractor.By.repeater("product in index.products")

    Object.create table,
      nthProduct: value: (index) ->
        new RowView(table, locator.row(index))

      productNames: get: ->
        @findElements locator.column("product.name")

module.exports = IndexPage
