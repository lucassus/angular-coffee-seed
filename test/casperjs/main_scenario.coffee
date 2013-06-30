casper = require("casper").create()

casper.start "http://localhost:9001", ->
  @clickLabel "Home", "a"

casper.then ->
  @test.assertTitle "Angular seed"

casper.then ->
  @test.assertSelectorHasText "h2", "You now have phones"

casper.then ->
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

casper.run ->
  @test.renderResults(true)
