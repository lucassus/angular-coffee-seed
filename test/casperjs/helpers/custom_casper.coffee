Casper = require("casper").Casper
FlashMessages = require("./test/casperjs/helpers/page_objects/flash_messages").FlashMessages
Other = require("./test/casperjs/helpers/page_objects/other").Other
TodoList = require("./test/casperjs/helpers/page_objects/todo_list").TodoList

exports.CustomCasper = class extends Casper

  currentPage: ->
    currentUrl = @getCurrentUrl()
    return new Other(this) if currentUrl.match /other$/
    return new TodoList(this) if currentUrl.match /todos$/

  flashMessages: ->
    new FlashMessages(this)
