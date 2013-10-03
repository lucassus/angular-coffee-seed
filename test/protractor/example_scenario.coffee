util = require("util")
expect = require("chai").expect
webdriver = require("selenium-webdriver")
protractor = require("protractor")

describe "angularjs.org homepage", ->
  @timeout 80000

  driver = null
  ptor = null

  before ->
    driver = new webdriver.Builder()
      .usingServer("http://localhost:4444/wd/hub")
      .withCapabilities(webdriver.Capabilities.firefox()).build()

    driver.manage().timeouts().setScriptTimeout 10000
    ptor = protractor.wrapDriver(driver)

  after (done) ->
    driver.quit().then ->
      done()

  it "should greet using binding", (done) ->
    ptor.get "http://www.angularjs.org"
    ptor.findElement(protractor.By.input("yourName")).sendKeys "Julie"
    ptor.findElement(protractor.By.binding("{{yourName}}")).getText().then (text) ->
      expect(text).to.eql "Hello Julie!"
      done()

  it "should list todos", (done) ->
    ptor.get "http://www.angularjs.org"
    todo = ptor.findElement(protractor.By.repeater("todo in todos").row(2))
    todo.getText().then (text) ->
      expect(text).to.eql "build an angular app"
      done()
