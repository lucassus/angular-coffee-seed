PageObject = require("./../page_object")

class FormPage extends PageObject

  @has "nameField",        -> @findField "product.name"
  @has "priceField",       -> @findField "product.price"
  @has "discountField",    -> @findField "product.discount"
  @has "descriptionField", -> @findField "product.description", protractor.By.textarea

  setName: (name)               -> @setFieldValue @nameField, name
  setPrice: (price)             -> @setFieldValue @priceField, price
  setDiscount: (discount)       -> @setFieldValue @discountField, discount
  setDescription: (description) -> @setFieldValue @descriptionField, description

  @has "submitButton", ->
    browser.findElement protractor.By.xpath("//button[@type='submit']")

  findField: (model, findBy = protractor.By.input) ->
    browser.findElement findBy(model)

  setFieldValue: (field, value) ->
    field.clear()
    field.sendKeys value

module.exports = FormPage
