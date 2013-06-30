class PageObject
  constructor: (@casper) ->

exports.PageObject = PageObject

class TodoFormObject extends PageObject
  fillWith: (data) ->
    @casper.fill "form[name=new-todo]", data

  checkDone: ->
    @casper.click "input[name=done]"

  clickAddButton: ->
    @casper.clickLabel "Add", "button"

exports.TodoFormObject = TodoFormObject

class TodosPage extends PageObject
  constructor: (@casper) ->
    super(@casper)
    @form = new TodoFormObject(@casper)

  clickNthTodo: (nth) ->
    @casper.click("ul#todos li:nth-child(#{nth}) input")

  clickArchive: ->
    @casper.clickLabel "archive", "a"

  headerText: ->
    @casper.fetchText("h2")

  remainingText: ->
    @casper.fetchText("span#remaining")

  getTodosCount: ->
    @casper.evaluate ->
      document.querySelectorAll("ul#todos li").length

exports.TodosPage = TodosPage
