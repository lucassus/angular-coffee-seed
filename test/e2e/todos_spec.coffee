describe "Todos page", ->

  beforeEach ->
    browser().navigateTo("/#todos")

  it "navigates to the valid url", ->
    expect(browser().location().url()).toBe("/todos")
