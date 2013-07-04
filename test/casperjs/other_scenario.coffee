scenario = require("./test/casperjs/helpers/scenario").create()

# Page objects
Other = require("./test/casperjs/helpers/page_objects/other").Other
FlashMessages = require("./test/casperjs/helpers/page_objects/flash_messages").FlashMessages

scenario "Other page", ->
  page = new Other(this)
  flashMessages = new FlashMessages(this)

  @feature "Navigate to the other page", ->
    @clickLabel "Other", "a"
    @test.assertTitle "Angular seed"

  @feature "Show the valid page title", ->
    @test.assertEquals page.pageTitleText(), "Other Controller"
    @test.assertTextExist "This is the other controller"

  @feature "Has 'Say hello!' button", ->
    @test.assertEquals "Say hello!", page.sayHelloButtonText()

  @feature "Click 'Say Hello' button", ->
    page.clickSayHelloButton()
    @test.assertEquals 1, flashMessages.count(), "Page displays 1 alert message"
    @test.assertEquals "Hello World!", flashMessages.text()
