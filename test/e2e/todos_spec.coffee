describe "Todos page", ->

  beforeEach ->
    browser().navigateTo("/#todos")

  todoList = null
  beforeEach -> todoList = repeater("ul#todos li")

  it "navigates to the valid url", ->
    expect(browser().location().url()).toBe "/todos"

  it "displays number of remaining tasks", ->
    expect(element("span#remaining").text()).toEqual "2 of 3 remaining"

  describe "todo list", ->
    it "displays all todos", ->
      expect(todoList.count()).toEqual 3

      expect(todoList.column("todo.name"))
        .toEqual [
          "First task"
          "Second task"
          "Completed task"
        ]

  it "adds a new task", ->
    # When
    input("newTodo.name").enter("New task")
    element("form button[type=submit]").click()

    # Then
    expect(todoList.count()).toEqual 4
    expect(todoList.row(2)).toEqual ["New task"]

  it "archives completed tasks", ->
    # When
    element("a.archive").click()

    # Then
    expect(element("span#remaining").text()).toEqual "2 of 2 remaining"
    expect(todoList.count()).toEqual 2
