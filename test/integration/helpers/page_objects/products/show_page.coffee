PageObject = require("./../page_object")

class ShowPage extends PageObject

  constructor: ->

  @has "editButton", ->
    browser.findElement @byLabel "Edit"

  @has "deleteButton", ->
    browser.findElement @byLabel "Delete", "button"

  @has "product", ->
    listElement = browser.findElement @By.xpath("//dl")

    byProperty = (name) =>
      listElement.findElement @By.binding("product.#{name}")

    Object.create Object::,
      name: get: -> byProperty("name")
      description: get: -> byProperty("description")
      manufacturer: get: -> byProperty("manufacturer")

  @has "tabs", ->
    browser.findElement @By.css(".nav-tabs")

  @has "tabDetails", ->
    @tabs.findElement @byLabel "Details"

  @has "tabActions", ->
    @tabs.findElement @byLabel "Actions"

module.exports = ShowPage
