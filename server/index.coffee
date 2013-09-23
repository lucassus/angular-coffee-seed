express = require("express")
path = require("path")

utils = require("./utils")

app = express()
app.use express.logger()
app.use express.static(path.join(__dirname, "dist"))

port = process.env.PORT or 5000
app.listen port, ->
  console.log "listening on port " + port

app.get "/api/products.json", (req, res) ->
  utils.randomSleep()

  res.send [
    { id: 1, name: "HTC Wildfire", price: 499, discount: 10 }
    { id: 2, name: "iPhone", price: 2500 }
    { id: 3, name: "Nexus One", price: 1000, discount: 7 }
    { id: 4, name: "Nexus 7", price: 1200, discount: 12 }
    { id: 5, name: "Samsung Galaxy Note", price: 2699, discount: 0 }
    { id: 6, name: "Samsung S4", price: 3000, discount: 2 }
  ]
