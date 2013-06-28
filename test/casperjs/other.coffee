casper = require("casper").create()

casper.start "http://localhost:9001", ->
  @clickLabel "Other", "a"

casper.then ->
  @test.assertTitle "Angular seed"

casper.then ->
  @clickLabel "Say hello!", "button"

  @test.assertEvalEquals (->
    document.querySelectorAll("div.alert").length
  ), 1, "Page displays 1 alert message"

  @test.assertTextExist "Hello World!"

casper.then ->
  @test.assertTextExist "This is the other controller"

casper.run ->
  @test.renderResults(true)
