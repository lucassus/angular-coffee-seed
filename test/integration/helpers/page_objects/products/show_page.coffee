module.exports = Object.create Object::,

  editButton: get: ->
    browser.findElement protractor.By.xpath("//a[contains(text(), 'Edit')]")

  deleteButton: get: ->
    browser.findElement protractor.By.xpath("//button[contains(text(), 'Delete')]")

  product: get: ->

    byField = (name) ->
      container = browser.findElement protractor.By.xpath("//dl")
      container.findElement protractor.By.binding("product.#{name}")

    Object.create Object::,
      name: get: -> byField("name")
      description: get: -> byField("description")
