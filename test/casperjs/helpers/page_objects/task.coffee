Base = require("./test/casperjs/helpers/page_objects/base").Base

exports.Task = class extends Base
  constructor: (@casper, @selector) ->
    super(@casper)

  getName: ->
    @casper.fetchText "#{@selector} span"

  isCompleted: ->
    @casper.evaluate (selector) ->
      $("#{selector} input:checked").length > 0
    , @selector

  complete: ->
    @casper.evaluate (selector) ->
      $checkbox = $("#{selector} input[type=checkbox]")
      $checkbox.click() if $checkbox.not(":checked")
    , @selector

  incomplete: ->
    @casper.evaluate (selector) ->
      $checkbox = $("#{selector} input[type=checkbox]")
      $checkbox.click() if $checkbox.is(":checked")
    , @selector
