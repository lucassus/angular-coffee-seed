class TodosCtrl

  @$inject = ["$scope"]
  constructor: ($scope) ->
    $scope.todos = [
      { name: "First task", done: false }
      { name: "Completed task", done: true }
      { name: "Second task", done: false }
    ]

    incompeleteTodos = ->
      todo for todo in $scope.todos when not todo.done

    $scope.remaining = ->
      incompeleteTodos().length

    $scope.archive = ->
      $scope.todos = incompeleteTodos()

    $scope.newTodo = {}

    $scope.addTodo = ->
      todo = $scope.newTodo
      $scope.todos.push(name: todo.name, done: !!todo.done)
      $scope.newTodo = {}

angular.module("myApp")
  .controller("TodosCtrl", TodosCtrl)
