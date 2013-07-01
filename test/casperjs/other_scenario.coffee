scenario = require("./test/casperjs/helpers/scenario").create()

scenario "Other page", ->

  @feature "Navigate to the other page", ->
    @clickLabel "Other", "a"
    @test.assertTitle "Angular seed"

  @feature "Show the valid page title", ->
    @test.assertEquals @currentPage().pageTitleText(), "Other Controller"
    @test.assertTextExist "This is the other controller"

  @feature "Has 'Say hello!' button", ->
    @test.assertEquals "Say hello!", @currentPage().sayHelloButtonText()
    @test.assertEquals "sayHello()", @currentPage().sayHelloButtonAttribute("ng-click")

  @feature "Click 'Say Hello' button", ->
    @currentPage().clickSayHelloButton()
    @test.assertEquals 1, @flashMessages().count(), "Page displays 1 alert message"
    @test.assertEquals "Hello World!", @flashMessages().text()
