class PageObject

  constructor: (@protractor) ->
    @ptor = @protractor.getInstance()

  getter: (name, locator) ->
    @protractor.By[name](locator)

  findElement: (name, locator) ->
    @ptor.findElement(@getter(name, locator))

  alert: ->

    byType = (type) =>
      @findElement("css", "div.alert-#{type} span")

    success: -> byType("success")
    info: -> byType("info")

module.exports = PageObject
