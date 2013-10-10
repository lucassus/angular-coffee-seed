PageObject = require("../../page_object")

class ProductsFormPage extends PageObject

  findInput: (model) ->
    @ptor.findElement(@getter("input", model))

  _setInputValue: (input, value) ->
    input.clear()
    input.sendKeys value

  setName: (name) ->
    input = @findInput("product.name")
    @_setInputValue(input, name)

  setPrice: (price) ->
    input = @findInput("product.price")
    @_setInputValue(input, price)

  setDiscount: (discount) ->
    input = @findInput("product.discount")
    @_setInputValue(input, discount)

  setDescription: (description) ->
    textarea = @ptor.findElement(@getter("textarea", "product.description"))
    @_setInputValue(textarea, description)

  getSubmitButton: ->
    @ptor.findElement(@getter("xpath", "//button[@type='submit']"))

  submit: ->
    @getSubmitButton().click()

module.exports = ProductsFormPage
