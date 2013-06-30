Casper = require("casper").Casper
TodoList = require("./test/casperjs/helpers/page_objects/todo_list").TodoList

class CustomCasper extends Casper

  constructor: (options = {}) ->
    super(options)
    @currentPage = new TodoList(this)

exports.CustomCasper = CustomCasper
