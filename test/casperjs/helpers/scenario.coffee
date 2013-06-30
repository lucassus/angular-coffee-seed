Casper = require("casper").Casper

FlashMessages = require("./test/casperjs/helpers/page_objects/flash_messages").FlashMessages
Other = require("./test/casperjs/helpers/page_objects/other").Other
TodoList = require("./test/casperjs/helpers/page_objects/todo_list").TodoList

class Scenario extends Casper
  constructor: (@baseUrl = "http://localhost:9001") ->
    super

  scenario: (desc, fn) =>
    desc = "Scenario: #{desc}"
    @echo "\n#{desc}", "RED_BAR"

    @start @baseUrl

    fn.call this

    @run -> @test.renderResults(true)

  feature: (desc, fn) =>
    @then ->
      @echo "\n#{desc}", "GREEN_BAR"
      fn.call(this)

  currentPage: ->
    currentUrl = @getCurrentUrl()
    return new Other(this) if currentUrl.match /other$/
    return new TodoList(this) if currentUrl.match /todos$/

  flashMessages: ->
    new FlashMessages(this)

exports.create = (baseUrl) ->
  casper = new Scenario(baseUrl)
  casper.scenario
