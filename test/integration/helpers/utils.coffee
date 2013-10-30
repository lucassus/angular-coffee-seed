request = require("request")

module.exports =

  loadFixtures: (callback = ->) ->
    loaded = false

    runs ->
      baseUrl = protractor.getInstance().baseUrl
      request.post "#{baseUrl}/api/_loadFixtures.json", ->
        callback()
        loaded = true

    waitsFor -> loaded

  takeScreenshot: (name = "screenshot") ->
    protractor.getInstance().takeScreenshot().then (screenshot) ->
      fs = require("fs")
      fs.writeFileSync("#{name}.png", screenshot, "base64")
