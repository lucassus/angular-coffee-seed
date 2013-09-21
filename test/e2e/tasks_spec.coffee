describe "Tasks page", ->

  beforeEach ->
    browser().navigateTo("/#tasks")

  taskList = null
  beforeEach -> taskList = repeater("ul#tasks li")

  it "navigates to the valid url", ->
    expect(browser().location().url()).to.equal "/tasks"

  it "displays number of remaining tasks", ->
    expect(element("span#remaining").text()).to.equal "2 of 3 remaining"

  describe "task list", ->
    it "displays all tasks", ->
      expect(taskList.count()).to.equal 3

      expect(taskList.column("task.name"))
        .to.equal [
          "First task"
          "Second task"
          "Completed task"
        ]

  it "adds a new task", ->
    # When
    input("task.name").enter("New task")
    element("form button[type=submit]").click()

    # Then
    expect(taskList.count()).to.equal 4
    expect(taskList.row(2)).to.equal ["New task"]

  it "archives completed tasks", ->
    # When
    element("a.archive").click()

    # Then
    expect(element("span#remaining").text()).to.equal "2 of 2 remaining"
    expect(taskList.count()).to.equal 2
