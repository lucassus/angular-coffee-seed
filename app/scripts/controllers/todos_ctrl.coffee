class TodosCtrl

  constructor: ->
    @tasks = [
      { name: "First task", done: false }
      { name: "Completed task", done: true }
      { name: "Second task", done: false }
    ]

    @newTask = {}

  incompeleteTasks: ->
    task for task in @tasks when not task.done

  count: ->
    @tasks.length

  remaining: ->
    @incompeleteTasks().length

  archive: ->
    @tasks = @incompeleteTasks()

  createTask: ->
    @tasks.push(name: @newTask.name, done: !!@newTask.done)
    @newTask = {}

angular.module("myApp")
  .controller("TodosCtrl", TodosCtrl)
