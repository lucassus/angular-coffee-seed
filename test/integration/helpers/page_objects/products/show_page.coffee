PageObject = require("./../page_object")

class ShowPage extends PageObject

  constructor: ->

  @has "editButton", ->
    browser.findElement @byLabel "Edit"

  @has "deleteButton", ->
    browser.findElement @byLabel "Delete", "button"

  @has "product", ->
    listElement = browser.findElement protractor.By.xpath("//dl")

    byProperty = (name) ->
      listElement.findElement protractor.By.binding("product.#{name}")

    name: byProperty("name")
    description: byProperty("description")

module.exports = ShowPage
