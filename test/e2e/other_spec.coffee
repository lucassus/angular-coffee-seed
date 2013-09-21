describe "Other page", ->

  beforeEach ->
    browser().navigateTo("/#other")

  it "navigates to the valid url", ->
    expect(browser().location().url()).to.equal "/other"

  xit "displays the message", ->
    expect(binding("other.name")).to.equal "This is the other controller"

  it "displays the flash message", ->
    element("button.btn").click()

    expect(repeater("aside#alerts .alert").count()).to.equal 1
    expect(repeater("aside#alerts .alert").column("message.text"))
      .to.match /Hello World!/
