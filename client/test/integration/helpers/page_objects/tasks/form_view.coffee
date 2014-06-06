PageObject = require("./../page_object")

class FormView extends PageObject

  constructor: (@base) ->

  @has "nameField", -> @base.element @By.input("task.name")

  @has "doneCheckbox", -> @base.element @By.input("task.done")

  @has "submitButton", -> @base.element @byLabel("Add", "button")

  setName: (value) ->
    @nameField.clear()
    @nameField.sendKeys value

module.exports = FormView
