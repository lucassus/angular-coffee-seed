request = require("request")
fs = require("fs")

module.exports =

  loadFixtures: (callback = ->) ->
    loaded = false

    runs ->
      baseUrl = browser.baseUrl
      request.post "#{baseUrl}/api/_loadFixtures.json", ->
        callback()
        loaded = true

    waitsFor -> loaded

  takeScreenshot: (fileName = "screenshot-#{new Date()}") ->
    browser.takeScreenshot().then (screenshot) ->
      fs.writeFileSync("#{fileName}.png", screenshot, "base64")
