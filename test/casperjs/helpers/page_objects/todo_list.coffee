Base = require("./test/casperjs/helpers/page_objects/base").Base
TodoForm = require("./test/casperjs/helpers/page_objects/todo_form").TodoForm

exports.TodoList = class extends Base
  constructor: (@casper) ->
    super(@casper)
    @form = new TodoForm(@casper)

  clickNthTodo: (nth) ->
    @casper.click("ul#todos li:nth-child(#{nth}) input")

  clickArchive: ->
    @casper.clickLabel "archive", "a"

  remainingText: ->
    @casper.fetchText("span#remaining")

  getTodosCount: ->
    @casper.evaluate ->
      document.querySelectorAll("ul#todos li").length
