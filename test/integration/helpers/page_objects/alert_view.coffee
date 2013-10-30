PageObject = require("./page_object")

class AlertView extends PageObject

  @has "success", -> @findAlert "success"
  @has "info",    -> @findAlert "info"

  findAlert: (type) ->
    browser.findElement protractor.By.css("div.alert-#{type} span")

module.exports = AlertView
