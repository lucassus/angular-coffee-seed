Casper = require("casper").Casper

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
    this.then ->
      @echo "\n#{desc}", "GREEN_BAR"
      fn.call(this)

exports.create = (baseUrl) ->
  casper = new Scenario(baseUrl)
  casper.scenario
