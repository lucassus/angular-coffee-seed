class PageObject

  constructor: (@protractor) ->
    @ptor = @protractor.getInstance()
    @By = @protractor.By

  alert: ->

    byType = (type) =>
      @ptor.findElement @By.css("div.alert-#{type} span")

    success: -> byType("success")
    info: -> byType("info")

module.exports = PageObject
