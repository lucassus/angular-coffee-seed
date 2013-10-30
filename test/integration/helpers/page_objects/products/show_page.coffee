PageObject = require("./../page_object")

class ShowPage extends PageObject

  constructor: ->

  @has "editButton", ->
    browser.findElement protractor.By.xpath("//a[contains(text(), 'Edit')]")

  @has "deleteButton", ->
    browser.findElement protractor.By.xpath("//button[contains(text(), 'Delete')]")

  @has "product", ->
    listElement = browser.findElement protractor.By.xpath("//dl")

    byProperty = (name) ->
      listElement.findElement protractor.By.binding("product.#{name}")

    name: byProperty("name")
    description: byProperty("description")

module.exports = ShowPage
