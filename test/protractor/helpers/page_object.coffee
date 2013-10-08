class PageObject

  constructor: (@protractor) ->
    @ptor = @protractor.getInstance()

  getter: (name, locator) ->
    @protractor.By[name](locator)

  findElement: (name, locator) ->
    @ptor.findElement(@getter(name, locator))

module.exports = PageObject
