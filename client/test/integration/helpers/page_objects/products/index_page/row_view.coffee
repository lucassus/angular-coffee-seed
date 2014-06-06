PageObject = require("./../../page_object")

class RowView extends PageObject

  constructor: (@table, @locator) ->
    @row = table.element(locator)

  # row values
  @has "id",          -> @findField("product.id")
  @has "name",        -> @findField("product.name")
  @has "description", -> @findField("product.description")

  # row action buttons
  @has "actionButton", ->
    @row.element @byLabel("Action", "button")

  @has "showButton", ->
    @actionButton.click()
    @row.element @byLabel("Show")

  @has "editButton", ->
    @actionButton.click()
    @row.element @byLabel("Edit")

  @has "deleteButton", ->
    @actionButton.click()
    @row.element @byLabel("Delete")

  findField: (binding) ->
    @table.element @locator.column(binding)

module.exports = RowView
