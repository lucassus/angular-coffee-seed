describe "Products list page", ->

  beforeEach ->
    browser().navigateTo("/#")

  it "navigates to the valid url", ->
    expect(browser().location().url()).toEqual "/"

  it "displays available products", ->
    expect(repeater("ul#products li").column("product.name"))
      .toEqual [
        "HTC Wildfire"
        "iPhone"
        "Nexus One"
        "Nexus 7"
        "Samsung Galaxy Note"
        "Samsung S4"
      ]
