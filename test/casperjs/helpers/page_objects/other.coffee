Base = require("./test/casperjs/helpers/page_objects/base").Base

exports.Other = class extends Base
  constructor: (@casper) ->
    super(@casper)

    @defineElement "sayHelloButton", ".btn.say-hello"
