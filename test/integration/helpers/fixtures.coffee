request = require("request")

module.exports =

  load: (callback = ->) ->
    loaded = false

    runs ->
      baseUrl = protractor.getInstance().baseUrl
      request.post "#{baseUrl}/api/_loadFixtures.json", ->
        callback()
        loaded = true

    waitsFor -> loaded
