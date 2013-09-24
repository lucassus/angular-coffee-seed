express = require("express")
path = require("path")

utils = require("./utils")
productProvider = require("./product_provider")

app = express()
app.use express.logger()
app.use express.static(path.join(__dirname, "dist"))

port = process.env.PORT or 5000
app.listen port, ->
  console.log "listening on port " + port

app.get "/api/products.json", (req, res) ->
  utils.randomSleep()

  productProvider.findAll (error, products) ->
    res.send products

app.get "/api/products/:id.json", (req, res) ->

  productProvider.findById req.params.id, (error, product) ->
    res.send if product? then product else 404
