casper = require("casper").create()

casper.start "http://localhost:9001", ->
  @clickLabel "Home", "a"

casper.then ->
  @test.assertTitle "Angular seed"

casper.then ->
  @test.assertEvalEquals (->
    document.querySelectorAll("ul#products li").length
  ), 6, "Page displays 6 phones"

  @test.assertTextExist "HTC Wildfire"
  @test.assertTextExist "iPhone"
  @test.assertTextExist "Nexus One"
  @test.assertTextExist "Nexus 7"
  @test.assertTextExist "Samsung Galaxy Note"
  @test.assertTextExist "Samsung S4"

casper.run ->
  @test.renderResults(true)
