PageObject = require("./../../page_object")

class RowView extends PageObject

  constructor: (@table, @locator) ->
    @row = table.findElement locator

  # row values
  @has "id",          -> @findField("product.id")
  @has "name",        -> @findField("product.name")
  @has "description", -> @findField("product.description")

  # row action buttons
  @has "actionButton", ->
    @row.findElement @byLabel "Action", "button"

  @has "showButton", ->
    @actionButton.click()
    @row.findElement @byLabel "Show"

  @has "editButton", ->
    @actionButton.click()
    @row.findElement @byLabel "Edit"

  @has "deleteButton", ->
    @actionButton.click()
    @row.findElement @byLabel "Delete"

  findField: (binding) ->
    @table.findElement @locator.column(binding)

module.exports = RowView
