Base = require("./test/casperjs/helpers/page_objects/base").Base

exports.FlashMessages = class extends Base
  count: ->
    @casper.evaluate ->
      document.querySelectorAll("#alerts div.alert").length

  text: -> @nthText(1)

  nthText: (nth) ->
    @casper.fetchText "#alerts div:nth-child(#{nth}) span"
