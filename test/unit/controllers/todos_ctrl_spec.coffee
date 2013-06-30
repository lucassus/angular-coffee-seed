describe "Controller: TodosCtrl", ->

  beforeEach module("myApp")
  $scope = null

  beforeEach inject ($controller, $rootScope, alerts) ->
    $scope = $rootScope.$new()
    $controller "TodosCtrl", $scope: $scope

  it "assisgns todos", ->
    expect($scope.todos).toBeDefined()
    expect($scope.todos.length).toEqual 3

  describe "#archive", ->
    beforeEach ->
      $scope.todos = [
        { done: false }, { done: true }, { done: true }
      ]

    it "removes completed todos from the list", ->
      expect($scope.todos.length).toEqual 3

      $scope.archive()
      expect($scope.todos.length).toEqual 1

  describe "#remaining", ->
    describe "when todo list is empty" ,->
      beforeEach -> $scope.todos = []

      it "returns 0", ->
        expect($scope.remaining()).toEqual 0

    describe "when todo list contains uncompleted tasks", ->
      beforeEach ->
        $scope.todos = [
          { done: false }, { done: false }, { done: true }
        ]

      it "returns > 0", ->
        expect($scope.remaining()).toEqual 2

    describe "when all tasks are completed", ->
      beforeEach ->
        $scope.todos = [
          { done: true }, { done: true }, { done: true }
        ]

      it "returns", ->
        expect($scope.remaining()).toEqual 0

  describe "#addTodo", ->
    it "adds a new task", ->
      # Given

      $scope.newTodo = name: "New task"
      # When
      $scope.addTodo()

      # Then
      expect($scope.todos.length).toEqual 4
      expect($scope.todos[3]).toEqual
        name: "New task", done: false

