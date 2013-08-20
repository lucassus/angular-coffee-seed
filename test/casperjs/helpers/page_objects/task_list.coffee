Base = require("./test/casperjs/helpers/page_objects/base").Base
TaskForm = require("./test/casperjs/helpers/page_objects/task_form").TaskForm
Task = require("./test/casperjs/helpers/page_objects/task").Task

exports.TaskList = class extends Base
  constructor: (@casper) ->
    super(@casper)
    @form = new TaskForm(@casper, "form[name=taskForm]")

  getForm: -> @form

  remainingText: ->
    @casper.fetchText "span#remaining"

  clickArchiveButton: ->
    @casper.clickLabel "archive", "a"

  findTaskByName: (name) ->
    index = @casper.evaluate (name) ->
      foundIndex = null
      $("ul#tasks li").each (index, li) ->
        if $(li).find("span:contains('#{name}')").length > 0
          foundIndex = index
      foundIndex
    , name

    new Task(@casper, "ul#tasks li:nth-child(#{index + 1})")

  getTodosCount: ->
    @casper.evaluate ->
      document.querySelectorAll("ul#tasks li").length
