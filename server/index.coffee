express = require("express")
path = require("path")

utils = require("./utils")

ProductProvider = new require("./product_provider")
productProvider = new ProductProvider()

# bootstrap with dummy data
fixtures = require("./fixtures")
productProvider.save fixtures.products
console.log "bootsrap with", productProvider

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
