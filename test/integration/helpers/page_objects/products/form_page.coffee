module.exports = (protractor) ->
  ptor = protractor.getInstance()

  findInput = (model, type = "input") ->
    ptor.findElement protractor.By[type](model)

  setInputValue = (input, value) ->
    input.clear()
    input.sendKeys value

  Object.create Object::,

    setName: value: (name) ->
      input = findInput("product.name")
      setInputValue(input, name)

    setPrice: value: (price) ->
      input = findInput("product.price")
      setInputValue(input, price)

    setDiscount: value: (discount) ->
      input = findInput("product.discount")
      setInputValue(input, discount)

    setDescription: value: (description) ->
      textarea = findInput("product.description", "textarea")
      setInputValue(textarea, description)

    submitButton: get: ->
      ptor.findElement(protractor.By.xpath("//button[@type='submit']"))
