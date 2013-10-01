exports.Base = class
  constructor: (@casper) ->

  pageTitleText: ->
    @casper.fetchText ".page-header h1"
