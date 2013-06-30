Base = require("./test/casperjs/helpers/page_objects/base").Base

exports.TodoForm = class extends Base
  fillWith: (data) ->
    @casper.fill "form[name=new-todo]", data

  checkDone: ->
    @casper.click "input[name=done]"

  clickAddButton: ->
    @casper.clickLabel "Add", "button"
