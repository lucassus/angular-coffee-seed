scenario = require("./test/casperjs/helpers/scenario").create()

# Page objects
Base = require("./test/casperjs/helpers/page_objects/base").Base

scenario "Main page", ->
  page = new Base(this)

  @feature "Navigate to the products page", ->
    @clickLabel "Products", "a"
    @test.assertTitle "Angular Seed"

  @feature "Display all products", ->
    @test.assertEquals page.pageTitleText(), "Products list"

    @test.assertEvalEquals (->
      document.querySelectorAll("table.products tbody tr").length
    ), 6, "Page displays 6 products"

    assertHasProduct = (text, nth) =>
      @test.assertSelectorHasText "table.products tbody tr:nth-child(#{nth}) td:nth-child(3)", text,
        "Phones list on #{nth} position contains '#{text}'"

    assertHasProduct("HTC Wildfire", 1)
    assertHasProduct("Nexus One", 2)
    assertHasProduct("Nexus 7", 3)
    assertHasProduct("iPhone", 4)
    assertHasProduct("Samsung Galaxy Note", 5)
    assertHasProduct("Samsung S4", 6)
