PageObject = require("./../../page_object")
RowView = require("./row_view")

class TableView extends PageObject

  constructor: (@table) ->
    @locator = @by.repeater("product in index.products")

  @has "productNames", ->
    @table.findElements @locator.column("product.name")

  rowAt: (index) ->
    new RowView(@table, @locator.row(index))

module.exports = TableView
