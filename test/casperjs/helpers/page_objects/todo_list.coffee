Base = require("./test/casperjs/helpers/page_objects/base").Base
TodoForm = require("./test/casperjs/helpers/page_objects/todo_form").TodoForm

exports.TodoList = class extends Base
  constructor: (@casper) ->
    super(@casper)
    @form = new TodoForm(@casper, "form[name=new-todo]")

  getForm: -> @form

  remainingText: ->
    @casper.fetchText "span#remaining"

  clickArchiveButton: ->
    @casper.clickLabel "archive", "a"

  clickNthTodo: (nth) ->
    @casper.click "ul#todos li:nth-child(#{nth}) input"

  getTodosCount: ->
    @casper.evaluate ->
      document.querySelectorAll("ul#todos li").length
