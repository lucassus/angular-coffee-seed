Base = require("./test/casperjs/helpers/page_objects/base").Base

exports.Other = class extends Base
  constructor: (@casper) ->
    super(@casper)


  sayHelloButtonText: ->
    @casper.fetchText ".btn.say-hello"

  clickSayHelloButton: ->
    @casper.click ".btn.say-hello"
