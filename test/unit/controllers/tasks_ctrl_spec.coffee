describe "Controller: TasksCtrl", ->

  beforeEach module("myApp")
  ctrl = null
  $scope = null

  # Initialize the controller and a mock scope
  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()
    ctrl = $controller "TasksCtrl", $scope: $scope

  it "assisgns tasks", ->
    expect(ctrl.tasks).toBeDefined()
    expect(ctrl.tasks.length).toEqual 3

  describe "#archive", ->
    beforeEach ->
      ctrl.tasks = [
        { done: false }, { done: true }, { done: true }
      ]

    it "removes completed task from the list", ->
      expect(ctrl.tasks.length).toEqual 3

      ctrl.archive()
      expect(ctrl.tasks.length).toEqual 1

  describe "#tasksCount", ->

    it "returs the number of all tasks", ->
      ctrl.tasks = [{}, {}, {}]
      expect(ctrl.tasksCount()).toEqual 3

  describe "#remainingTasksCount", ->

    describe "when task list is empty" ,->
      beforeEach -> ctrl.tasks = []

      it "returns 0", ->
        expect(ctrl.remainingTasksCount()).toEqual 0

    describe "when task list contains some uncompleted tasks", ->
      beforeEach ->
        ctrl.tasks = [
          { done: false }, { done: false }, { done: true }
        ]

      it "returns > 0", ->
        expect(ctrl.remainingTasksCount()).toEqual 2

    describe "when all tasks are completed", ->
      beforeEach ->
        ctrl.tasks = [
          { done: true }, { done: true }, { done: true }
        ]

      it "returns 0", ->
        expect(ctrl.remainingTasksCount()).toEqual 0

  describe "#addTask", ->

    describe "when the form is valid", ->
      stub = null

      beforeEach ->
        $scope.taskForm = $valid: true
        stub = sinon.stub(ctrl, "reset")

      it "adds a new task", ->
        # Given
        newTask = name: "New task", done: false

        # When
        ctrl.addTask(newTask)

        # Then
        expect(ctrl.tasks.length).toEqual 4
        expect(ctrl.tasks[3]).toEqual
          name: newTask.name, done: newTask.done

      it "resets the form", ->
        # When
        ctrl.addTask({})

        # Then
        expect(stub).toHaveBeenCalled()

    describe "when the form is not valid", ->
      beforeEach -> $scope.taskForm = $valid: false

      it "does nothing", ->
        # When
        ctrl.addTask({})

        # Then
        expect(ctrl.tasks.length).toEqual 3

      it "does not reset the form", ->
        # Given
        mock = sinon.mock(ctrl).expects("reset").never()

        # When
        ctrl.addTask({})

        # Then
        expect(mock).not.toHaveBeenCalled()
        mock.verify()
