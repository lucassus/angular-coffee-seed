PageObject = require("./../page_object")
TableView = require("./index_page/table_view")

class IndexPage extends PageObject

  @has "greeting", ->
    browser.findElement protractor.By.binding("You have {{index.products.length}} products")

  @has "createButton", ->
    browser.findElement @byLabel "Create new product"

  @has "table", ->
    table = browser.findElement protractor.By.css "table.products"
    new TableView(table)

module.exports = IndexPage
