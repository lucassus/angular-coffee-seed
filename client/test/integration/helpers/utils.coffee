request = require("request")
fs = require("fs")

module.exports =

  # Load fixtures and wait until the request is completed
  loadFixtures: ->
    baseUrl = browser.baseUrl

    fixturesLoaded = false
    request.post "#{baseUrl}/api/_loadFixtures.json", -> fixturesLoaded = true
    browser.wait -> fixturesLoaded

  takeScreenshot: (fileName = "screenshot-#{new Date()}") ->
    browser.takeScreenshot().then (screenshot) ->
      fs.writeFileSync("#{fileName}.png", screenshot, "base64")
