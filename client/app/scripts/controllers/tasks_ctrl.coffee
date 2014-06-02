app = angular.module("myApp")

class TasksCtrl extends BaseCtrl

  @register app, "TasksCtrl"
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

    form = @$scope.taskForm
    if form
      form.$setPristine()
      form.$submitted = false

  addTask: (task) ->
    # TODO pass form here
    form = @$scope.taskForm

    # TODO use custom submit method
    form.$submitted = true
    return unless form.$valid

    @tasks.push angular.copy(task)
    @reset()
