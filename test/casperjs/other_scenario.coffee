CustomCasper = require("./test/casperjs/helpers/custom_casper").CustomCasper
casper = new CustomCasper()

casper.start "http://localhost:9001", ->
  @clickLabel "Other", "a"

casper.then ->
  @test.assertTitle "Angular seed"

casper.then ->
  @test.assertEquals @currentPage().pageTitleText(), "Other Controller"

casper.then ->
  @currentPage().clickSayHelloButton()
  @test.assertEquals 1, @flashMessages().count(), "Page displays 1 alert message"
  @test.assertEquals "Hello World!", @flashMessages().text()

casper.then ->
  @test.assertTextExist "This is the other controller"

casper.run ->
  @test.renderResults(true)
