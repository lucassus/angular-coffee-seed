findInput = (model, type = "input") ->
  browser.findElement protractor.By[type](model)

setInputValue = (input, value) ->
  input.clear()
  input.sendKeys value

module.exports = Object.create Object::,

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
    browser.findElement(protractor.By.xpath("//button[@type='submit']"))
