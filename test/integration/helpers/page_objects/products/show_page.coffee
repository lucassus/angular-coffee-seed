module.exports = (protractor) ->
  ptor = protractor.getInstance()

  byField = (name) ->
    container = ptor.findElement protractor.By.xpath("//dl")
    container.findElement protractor.By.binding("product.#{name}")

  product: Object.create Object::,

    name: get: -> byField("name")
    description: get: -> byField("description")
