module.exports = (protractor) ->
  ptor = protractor.getInstance()

  findInput = (model, type = "input") ->
    ptor.findElement protractor.By[type](model)

  setInputValue = (input, value) ->
    input.clear()
    input.sendKeys value

  setName: (name) ->
    input = findInput("product.name")
    setInputValue(input, name)

  setPrice: (price) ->
    input = findInput("product.price")
    setInputValue(input, price)

  setDiscount: (discount) ->
    input = findInput("product.discount")
    setInputValue(input, discount)

  setDescription: (description) ->
    textarea = findInput("product.description", "textarea")
    setInputValue(textarea, description)

  submitButton:
    ptor.findElement(protractor.By.xpath("//button[@type='submit']"))

  submit: ->
    @submitButton.click()
