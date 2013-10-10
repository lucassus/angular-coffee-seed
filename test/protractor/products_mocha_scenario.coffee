webdriver = require("selenium-webdriver")
protractor = require("protractor")
expect = require("chai").expect

describe "Products page", ->
  @timeout 80000

  driver = null
  ptor = null

  before ->
    driver = new webdriver.Builder().
      usingServer("http://localhost:4444/wd/hub").
      withCapabilities(webdriver.Capabilities.firefox()).build()

    driver.manage().timeouts().setScriptTimeout(10000)
    ptor = protractor.wrapDriver(driver)

    ptor.get "http://localhost:9001/"

  after (done) ->
    console.log "quitting..."
    driver.quit().then -> done()

  it "displays a valid page title", (done) ->
    ptor.getTitle().then (title) ->
      expect(title).to.equal "Angular Seed"
      done()

  it "displays the list of products", (done) ->
    ptor.findElement(protractor.By.binding("You have {{index.products.length}} products"))
      .getText().then (text) ->
        expect(text).to.equal "You have 6 products"
