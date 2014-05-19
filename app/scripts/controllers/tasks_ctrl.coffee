app = angular.module("myApp")

class TasksCtrl extends BaseCtrl

  @register app
  @inject "$scope"

  initialize: ->
    @tasks = [
      { name: "First task", done: false }
      { name: "Completed task", done: true }
      { name: "Second task", done: false }
    ]

    @master = { name: "", done: false }
    @reset()

  incompleteTasks: ->
    task for task in @tasks when not task.done

  tasksCount: ->
    @tasks.length

  remainingTasksCount: ->
    @incompleteTasks().length

  archive: ->
    @tasks = @incompleteTasks()

  reset: ->
    @$scope.task = angular.copy(@master)
    @$scope.taskForm?.$setPristine()
    @$scope.taskForm?.$submitted = false

  addTask: (task) ->
    @$scope.taskForm?.$submitted = true
    return unless @$scope.taskForm?.$valid

    @tasks.push angular.copy(task)
    @reset()
