exports.Base = class
  constructor: (@casper) ->

  pageTitleText: ->
    @casper.fetchText "h2.page-title"
