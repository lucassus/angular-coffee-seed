Base = require("./test/casperjs/helpers/page_objects/base").Base
TodoForm = require("./test/casperjs/helpers/page_objects/todo_form").TodoForm
Todo = require("./test/casperjs/helpers/page_objects/todo").Todo

exports.TodoList = class extends Base
  constructor: (@casper) ->
    super(@casper)
    @form = new TodoForm(@casper, "form[name=new-todo]")

  getForm: -> @form

  remainingText: ->
    @casper.fetchText "span#remaining"

  clickArchiveButton: ->
    @casper.clickLabel "archive", "a"

  findTodoByText: (name) ->
    index = @casper.evaluate (name) ->
      foundIndex = null
      $("ul#todos li").each (index, li) ->
        if $(li).find("span:contains('#{name}')").length > 0
          foundIndex = index
      foundIndex
    , name

    new Todo(@casper, "ul#todos li:nth-child(#{index + 1})")

  getTodosCount: ->
    @casper.evaluate ->
      document.querySelectorAll("ul#todos li").length
