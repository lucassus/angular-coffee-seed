Base = require("./test/casperjs/helpers/page_objects/base").Base

exports.TodoForm = class extends Base
  constructor: (@casper) ->
    super(@casper)

    @defineElement "addButton", "form[name=new-todo] button[type=submit]"

  fillWith: (data) ->
    @casper.fill "form[name=new-todo]", data

  checkDone: ->
    @casper.click "input[name=done]"
