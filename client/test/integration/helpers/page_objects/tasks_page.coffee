PageObject = require("./page_object")
TaskView = require("./tasks/task_view")
FormView = require("./tasks/form_view")

class TasksPage extends PageObject

  @has "remaining", ->
    browser.element @By.css("span#remaining")

  @has "archiveButton", ->
    browser.element @byLabel("archive")

  @has "tasks", ->
    browser.findElements @By.css("ul#tasks li")

  @has "form", ->
    form = browser.element @By.css("form[name=taskForm]")
    new FormView(form)

  taskAt: (index) ->
    taskElement = browser.element @By.repeater("task in tasks.tasks").row(index)
    new TaskView(taskElement)

  tasksCount: ->
    @waitForAnimations()

    d = protractor.promise.defer()
    @tasks.then (tasks) -> d.fulfill tasks.length
    d.promise

module.exports = TasksPage
