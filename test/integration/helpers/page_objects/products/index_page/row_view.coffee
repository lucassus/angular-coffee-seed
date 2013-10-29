module.exports = (protractor, table, locator) ->

  row = table.findElement locator

  byBinding = (binding) ->
    table.findElement locator.column(binding)

  Object.create Object::,

    # row values
    id: get: ->byBinding("product.id")
    name: get: ->byBinding("product.name")
    description: get: ->byBinding("product.description")

    # action buttons
    actionButton: get: ->
      row.findElement protractor.By.xpath(".//button[contains(text(), 'Action')]")

    showButton: get: ->
      @actionButton.click()
      row.findElement protractor.By.xpath(".//a[contains(text(), 'Show')]")

    editButton: get: ->
      @actionButton.click()
      row.findElement protractor.By.xpath(".//a[contains(text(), 'Edit')]")

    deleteButton: get: ->
      @actionButton.click()
      row.findElement protractor.By.xpath(".//a[contains(text(), 'Delete')]")
