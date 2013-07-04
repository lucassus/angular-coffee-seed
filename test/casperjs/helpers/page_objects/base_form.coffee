Base = require("./test/casperjs/helpers/page_objects/base").Base

exports.BaseForm = class extends Base
  constructor: (@casper, @selector) ->
    super(@casper)

  fillWith: (data) ->
    @casper.fill @selector, data

  getValues: ->
    @casper.getFormValues @selector
