class TodosCtrl

  @$inject = ["$scope"]
  constructor: (@$scope) ->
    @tasks = [
      { name: "First task", done: false }
      { name: "Completed task", done: true }
      { name: "Second task", done: false }
    ]

    @master = { name: "", done: false }
    @reset()

  incompeleteTasks: ->
    task for task in @tasks when not task.done

  tasksCount: ->
    @tasks.length

  remainingTasksCount: ->
    @incompeleteTasks().length

  archive: ->
    @tasks = @incompeleteTasks()

  reset: ->
    @$scope.task = angular.copy(@master)
    @$scope.taskForm?.$setPristine()
    @$scope.taskForm?.$submitted = false

  addTask: (task) ->
    @$scope.taskForm?.$submitted = true
    return unless @$scope.taskForm?.$valid

    @tasks.push angular.copy(task)
    @reset()

angular.module("myApp")
  .controller("TodosCtrl", TodosCtrl)
