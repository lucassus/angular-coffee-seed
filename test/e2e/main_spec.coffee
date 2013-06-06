describe "Products list page", ->

  beforeEach ->
    browser().navigateTo("/#")
    sleep(0.5) # TODO get rid of this sleep

  it "navigates to the valid url", ->
    expect(browser().location().url()).toBe("/")

  it "displays available products", ->
    expect(repeater("ul#products li").column("product.name"))
      .toEqual([
        "HTC Wildfire"
        "iPhone"
        "Nexus One"
        "Nexus 7"
        "Samsung Galaxy Note"
        "Samsung S4"
      ])
