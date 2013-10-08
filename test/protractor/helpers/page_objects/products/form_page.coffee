PageObject = require("../../page_object")

class ProductsFormPage extends PageObject

  findInput: (model) ->
    @ptor.findElement(@getter("input", model))

  setName: (name) ->
    @findInput("product.name").sendKeys name

  setPrice: (price) ->
    @findInput("product.price").sendKeys price

  setDiscount: (discount) ->
    @findInput("product.discount").sendKeys discount

  setDescription: (description) ->
    textarea = @ptor.findElement(@getter("textarea", "product.description"))
    textarea.sendKeys description

  getSubmitButton: ->
    @ptor.findElement(@getter("xpath", "//button[@type='submit']"))

  submit: ->
    @getSubmitButton().click()

module.exports = ProductsFormPage
