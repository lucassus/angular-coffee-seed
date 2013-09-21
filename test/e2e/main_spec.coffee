describe "Products list page", ->

  beforeEach ->
    browser().navigateTo("/#")

  it "navigates to the valid url", ->
    expect(browser().location().url()).to.equal "/"

  it "displays available products", ->
    expect(repeater("ul#products li").column("product.name"))
      .to.equal [
        "HTC Wildfire"
        "iPhone"
        "Nexus One"
        "Nexus 7"
        "Samsung Galaxy Note"
        "Samsung S4"
      ]
