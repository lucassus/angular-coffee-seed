Casper = require("casper").Casper

class Scenario extends Casper
  constructor: (@baseUrl = "http://localhost:9001", options = {}) ->
    options.viewportSize = width: 1024, height: 768
    super(options)

    # catches remote `console.log` calls
    @on "remote.message", (message) ->
      console.log "remote", message

  scenario: (desc, fn) =>
    desc = "Scenario: #{desc}"
    @echo "\n#{desc}", "INFO_BAR"

    @start @baseUrl

    fn.call this

    @run -> @test.renderResults(true)

  feature: (desc, fn) =>
    this.then ->
      @echo "\n#{desc}", "GREEN_BAR"

      if fn?
        fn.call this
      else
        @echo "pending", "RED_BAR"

exports.create = (baseUrl) ->
  casper = new Scenario(baseUrl)
  casper.scenario
