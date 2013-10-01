describe "Products list page", ->

  beforeEach ->
    browser().navigateTo("/#")

  it "navigates to the valid url", ->
    expect(browser().location().url()).toEqual "/products"

  it "displays available products", ->
    expect(repeater("table.products tbody tr").column("product.name"))
      .toEqual [
        "HTC Wildfire"
        "Nexus One"
        "Nexus 7"
        "iPhone"
        "Samsung Galaxy Note"
        "Samsung S4"
      ]
