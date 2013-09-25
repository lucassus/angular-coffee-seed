scenario = require("./test/casperjs/helpers/scenario").create()

# Page objects
Base = require("./test/casperjs/helpers/page_objects/base").Base

scenario "Main page", ->
  page = new Base(this)

  @feature "Navigate to the products page", ->
    @clickLabel "Products", "a"
    @test.assertTitle "Angular seed"

  @feature "Display all products", ->
    @test.assertEquals page.pageTitleText(), "You now have products"

    @test.assertEvalEquals (->
      document.querySelectorAll("ul#products li").length
    ), 6, "Page displays 6 products"

    assertListHasText = (text, nth) =>
      @test.assertSelectorHasText "ul#products li:nth-child(#{nth})", text,
        "Phones list on #{nth} position contains '#{text}'"

    assertListHasText("HTC Wildfire", 1)
    assertListHasText("Nexus One", 2)
    assertListHasText("Nexus 7", 3)
    assertListHasText("iPhone", 4)
    assertListHasText("Samsung Galaxy Note", 5)
    assertListHasText("Samsung S4", 6)
