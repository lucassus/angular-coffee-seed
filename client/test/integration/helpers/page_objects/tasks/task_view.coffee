PageObject = require("./../page_object")

class TaskView extends PageObject

  constructor: (@element) ->

  @has "checkbox", ->
    @element.findElement @By.css("input[type=checkbox]")

  @has "label", ->
    @element.findElement @By.css("label span")

  isCompleted: ->
    d = protractor.promise.defer()

    @label.getAttribute("class").then (cls) ->
      d.fulfill cls.indexOf("done") isnt -1

    d.promise

module.exports = TaskView
