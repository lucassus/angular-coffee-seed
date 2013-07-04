BaseForm = require("./test/casperjs/helpers/page_objects/base_form").BaseForm

exports.TodoForm = class extends BaseForm
  constructor: (@casper, @selector) ->
    super(@casper, @selector)

  checkDone: ->
    @casper.evaluate (selector) ->
      $checkbox = $("#{selector} input[type=checkbox][name=done]")
      $checkbox.click() if $checkbox.not(":checked")
    , @selector

  clickAddButton: ->
    @casper.click "#{@selector} button[type=submit]"
