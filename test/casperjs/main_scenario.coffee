scenario = require("./test/casperjs/helpers/scenario").create()

scenario "Main page", ->

  @feature "Navigate to the main page", ->
    @clickLabel "Home", "a"
    @test.assertTitle "Angular seed"

  @feature "Display all phones", ->
    @test.assertSelectorHasText "h2", "You now have phones"

    @test.assertEvalEquals (->
      document.querySelectorAll("ul#products li").length
    ), 6, "Page displays 6 phones"

    assertListHasText = (text, nth) =>
      @test.assertSelectorHasText "ul#products li:nth-child(#{nth})", text,
        "Phones list on #{nth} position contains '#{text}'"

    assertListHasText("HTC Wildfire", 1)
    assertListHasText("iPhone", 2)
    assertListHasText("Nexus One", 3)
    assertListHasText("Nexus 7", 4)
    assertListHasText("Samsung Galaxy Note", 5)
    assertListHasText("Samsung S4", 6)
