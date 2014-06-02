PageObject = require("./page_object")

class OtherPage extends PageObject

  @has "sayHelloButton", ->
    browser.findElement @byLabel "Say hello!", "button"

module.exports = OtherPage
