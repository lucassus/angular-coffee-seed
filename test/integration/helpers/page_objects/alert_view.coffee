module.exports = (protractor) ->
  ptor = protractor.getInstance()

  byType = (type) ->
    ptor.findElement protractor.By.css("div.alert-#{type} span")

  success: -> byType("success")
  info: -> byType("info")
