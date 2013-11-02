PageObject = require("./../page_object")

class FormView extends PageObject

  constructor: (@base) ->

  @has "nameField", -> @base.findElement @By.input("task.name")

  @has "doneCheckbox", -> @base.findElement @By.input("task.done")

  @has "submitButton", -> @base.findElement @byLabel "Add", "button"

  setName: (value) ->
    @nameField.clear()
    @nameField.sendKeys value

module.exports = FormView
