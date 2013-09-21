describe "Other page", ->

  beforeEach ->
    browser().navigateTo("/#other")

  it "navigates to the valid url", ->
    expect(browser().location().url()).toEqual "/other"

  xit "displays the message", ->
    expect(binding("other.name")).toEqual "This is the other controller"

  it "displays the flash message", ->
    element("button.btn").click()

    expect(repeater("aside#alerts .alert").count()).toEqual 1
    expect(repeater("aside#alerts .alert").column("message.text"))
      .toMatch /Hello World!/
