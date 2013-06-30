Casper = require("casper").Casper
TodosPage = require("./test/casperjs/helpers/page_objects").TodosPage

class CustomCasper extends Casper

  constructor: (options = {}) ->
    super(options)
    @currentPage = new TodosPage(this)

exports.CustomCasper = CustomCasper
