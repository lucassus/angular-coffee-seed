PageObject = require("./page_object")

class AlertView extends PageObject

  @has "success", -> @byType("success")
  @has "info",    -> @byType("info")

  byType: (type) ->
    browser.findElement protractor.By.css("div.alert-#{type} span")

module.exports = AlertView
