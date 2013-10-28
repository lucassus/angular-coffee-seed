module.exports = (protractor) ->
  ptor = protractor.getInstance()

  byType = (type) ->
    ptor.findElement protractor.By.css("div.alert-#{type} span")

  Object.create Object::,

    success: get: -> byType("success")
    info: get: -> byType("info")
