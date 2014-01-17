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
    expect(browser.getCurrentUrl()).toEqual "http://localhost:9001/#/other"
    expect(browser.getTitle()).toEqual "Angular Seed"

  describe "click on `Say hello!` button", ->
    beforeEach -> otherPage.sayHelloButton.click()

    it "displays an alert message", ->
      expect(alertView.info.isDisplayed()).toBeTruthy()
      expect(alertView.info.getText()).toEqual "Hello World!"
