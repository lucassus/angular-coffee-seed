PageObject = require("./../../page_object")

class RowView extends PageObject

  constructor: (@table, @locator) ->
    @row = table.findElement locator

  # row values
  @has "id",          -> @byBinding("product.id")
  @has "name",        -> @byBinding("product.name")
  @has "description", -> @byBinding("product.description")

  # row action buttons
  @has "actionButton", ->
    @row.findElement protractor.By.xpath(".//button[contains(text(), 'Action')]")

  @has "showButton", ->
    @actionButton.click()
    @row.findElement protractor.By.xpath(".//a[contains(text(), 'Show')]")

  @has "editButton", ->
    @actionButton.click()
    @row.findElement protractor.By.xpath(".//a[contains(text(), 'Edit')]")

  @has "deleteButton", ->
    @actionButton.click()
    @row.findElement protractor.By.xpath(".//a[contains(text(), 'Delete')]")

  byBinding: (binding) ->
    @table.findElement @locator.column(binding)

module.exports = RowView
