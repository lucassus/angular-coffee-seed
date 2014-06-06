PageObject = require("./../page_object")
TableView = require("./index_page/table_view")

class IndexPage extends PageObject

  @has "greeting", ->
    browser.element @By.binding("You have {{index.products.length}} products")

  @has "createButton", ->
    browser.element @byLabel("Create new product")

  @has "table", ->
    table = browser.element @By.css("table.products")
    new TableView(table)

module.exports = IndexPage
