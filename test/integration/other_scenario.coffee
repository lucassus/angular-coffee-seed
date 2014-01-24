expect = require("./helpers/expect")
utils = require("./helpers/utils")

AlertView = require("./helpers/page_objects/alert_view")
OtherPage = require("./helpers/page_objects/other_page")

describe "Other page", ->
  alertView = null
  otherPage = null

  beforeEach ->
    browser.get "/#/other"

    alertView = new AlertView()
    otherPage = new OtherPage()

  it "displays a valid page title", ->
    expect(browser.getCurrentUrl()).to.eventually.match /#\/other$/
    expect(browser.getTitle()).to.eventually.eq "Angular Seed"

  describe "click on `Say hello!` button", ->
    beforeEach -> otherPage.sayHelloButton.click()

    it "displays an alert message", ->
      expect(alertView.info.isDisplayed()).to.eventually.be.true
      expect(alertView.info.getText()).to.eventually.eq "Hello World!"
