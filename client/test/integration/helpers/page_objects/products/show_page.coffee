PageObject = require("./../page_object")

class ShowPage extends PageObject

  constructor: ->

  @has "editButton", ->
    browser.element @byLabel("Edit")

  @has "deleteButton", ->
    browser.element @byLabel("Delete", "button")

  @has "product", ->
    listElement = browser.element @By.xpath("//dl")

    byProperty = (name) =>
      listElement.element @By.binding("product.#{name}")

    Object.create Object::,
      name: get: -> byProperty("name")
      description: get: -> byProperty("description")
      manufacturer: get: -> byProperty("manufacturer")

  @has "tabs", ->
    browser.element @By.css(".nav-tabs")

  @has "tabDetails", ->
    @tabs.element @byLabel("Details")

  @has "tabActions", ->
    @tabs.element @byLabel("Actions")

module.exports = ShowPage
