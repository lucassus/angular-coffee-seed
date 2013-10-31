PageObject = require("./page_object")
TaskView = require("./tasks/task_view")

class TasksPage extends PageObject

  @has "remaining", ->
    browser.findElement @by.css("span#remaining")

  @has "archiveButton", ->
    browser.findElement @byLabel "archive"

  @has "tasks", ->
    browser.findElements @by.css("ul#tasks li")

  taskAt: (index) ->
    taskElement = browser.findElement @by.repeater("task in tasks.tasks").row(index)
    new TaskView(taskElement)

  tasksCount: ->
    @waitForAnimations()

    d = protractor.promise.defer()
    @tasks.then (tasks) -> d.fulfill tasks.length
    d.promise

module.exports = TasksPage
