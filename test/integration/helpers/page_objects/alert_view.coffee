byType = (type) ->
  browser.findElement protractor.By.css("div.alert-#{type} span")

module.exports = Object.create Object::,

  success: get: -> byType("success")
  info: get: -> byType("info")
