express = require("express")
path = require("path")

app = express()

app.use express.logger()
app.use express.static(path.join(__dirname, "dist"))

port = process.env.PORT or 5000
app.listen port, ->
  console.log "listening on port " + port

app.get "/api/products.json", (req, res) ->
  res.send [
    { name: "HTC Wildfire" }
    { name: "iPhone" }
    { name: "Nexus One" }
    { name: "Nexus 7" }
    { name: "Samsung Galaxy Note" }
    { name: "Samsung S4" }
  ]
