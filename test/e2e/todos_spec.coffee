describe "Todos page", ->

  beforeEach ->
    browser().navigateTo("/#todos")

  it "navigates to the valid url", ->
    expect(browser().location().url()).toBe("/todos")

  it "displays incompleted todos", ->
    expect(repeater("ul#todos li").column("todo.name"))
      .toEqual [
        "First task"
        "Second task"
      ]
