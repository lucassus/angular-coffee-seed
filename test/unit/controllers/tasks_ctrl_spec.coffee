describe "Controller `TasksCtrl`", ->

  beforeEach module "myApp"

  ctrl = null
  $scope = null

  # Initialize the controller and a mock scope
  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()
    ctrl = $controller "TasksCtrl", $scope: $scope

  it "assigns tasks", ->
    expect(ctrl.tasks).to.not.be.undefined
    expect(ctrl.tasks.length).to.equal 3

  describe "#archive()", ->
    beforeEach ->
      ctrl.tasks = [
        { done: false }, { done: true }, { done: true }
      ]

    it "removes completed task from the list", ->
      expect(ctrl.tasks.length).to.equal 3

      ctrl.archive()
      expect(ctrl.tasks.length).to.equal 1

  describe "#tasksCount()", ->

    it "returns the number of all tasks", ->
      ctrl.tasks = [{}, {}, {}]
      expect(ctrl.tasksCount()).to.equal 3

  describe "#remainingTasksCount()", ->

    describe "when task list is empty" ,->
      beforeEach -> ctrl.tasks = []

      it "returns 0", ->
        expect(ctrl.remainingTasksCount()).to.equal 0

    describe "when task list contains some uncompleted tasks", ->
      beforeEach ->
        ctrl.tasks = [
          { done: false }, { done: false }, { done: true }
        ]

      it "returns > 0", ->
        expect(ctrl.remainingTasksCount()).to.equal 2

    describe "when all tasks are completed", ->
      beforeEach ->
        ctrl.tasks = [
          { done: true }, { done: true }, { done: true }
        ]

      it "returns 0", ->
        expect(ctrl.remainingTasksCount()).to.equal 0

  describe "#addTask()", ->

    describe "when the form is valid", ->

      beforeEach ->
        $scope.taskForm = $valid: true
        sinon.stub(ctrl, "reset")

      it "adds a new task", ->
        # Given
        newTask = name: "New task", done: false

        # When
        ctrl.addTask(newTask)

        # Then
        expect(ctrl.tasks.length).to.equal 4

        lastTask = ctrl.tasks[3]
        expect(lastTask).to.not.be.undefined
        expect(lastTask.name).to.equal newTask.name
        expect(lastTask.done).to.equal newTask.done

      it "resets the form", ->
        # When
        ctrl.addTask({})

        # Then
        expect(ctrl.reset).to.be.called

    describe "when the form is not valid", ->
      beforeEach -> $scope.taskForm = $valid: false

      it "does nothing", ->
        # When
        ctrl.addTask({})

        # Then
        expect(ctrl.tasks.length).to.equal 3

      it "does not reset the form", ->
        # Given
        mock = sinon.mock(ctrl).expects("reset").never()

        # When
        ctrl.addTask({})

        # Then
        expect(mock).to.not.be.called
        mock.verify()
