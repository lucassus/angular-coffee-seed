describe "Controller: TodosCtrl", ->

  beforeEach module("myApp")
  ctrl = null

  # Initialize the controller and a mock scope
  beforeEach inject ($controller) ->
    ctrl = $controller "TodosCtrl"

  it "assisgns tasks", ->
    expect(ctrl.tasks).toBeDefined()
    expect(ctrl.tasks.length).toEqual 3

  describe "#archive", ->
    beforeEach ->
      ctrl.tasks = [
        { done: false }, { done: true }, { done: true }
      ]

    it "removes completed todos from the list", ->
      expect(ctrl.tasks.length).toEqual 3

      ctrl.archive()
      expect(ctrl.tasks.length).toEqual 1

  describe "#remaining", ->
    describe "when todo list is empty" ,->
      beforeEach -> ctrl.tasks = []

      it "returns 0", ->
        expect(ctrl.remaining()).toEqual 0

    describe "when todo list contains uncompleted tasks", ->
      beforeEach ->
        ctrl.tasks = [
          { done: false }, { done: false }, { done: true }
        ]

      it "returns > 0", ->
        expect(ctrl.remaining()).toEqual 2

    describe "when all tasks are completed", ->
      beforeEach ->
        ctrl.tasks = [
          { done: true }, { done: true }, { done: true }
        ]

      it "returns", ->
        expect(ctrl.remaining()).toEqual 0

  describe "#createTask", ->
    it "adds a new task", ->
      # Given

      ctrl.newTask = name: "New task"
      # When
      ctrl.createTask()

      # Then
      expect(ctrl.tasks.length).toEqual 4
      expect(ctrl.tasks[3]).toEqual
        name: "New task", done: false
