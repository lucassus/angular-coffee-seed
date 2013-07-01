Base = require("./test/casperjs/helpers/page_objects/base").Base

exports.TodoForm = class extends Base
  constructor: (@casper) ->
    super(@casper)

    @defineElement "addButton", "form[name=new-todo] button[type=submit]"
    @defineElement "done", "form[name=new-todo] input[name=done]"

  fillWith: (data) ->
    @casper.fill "form[name=new-todo]", data
