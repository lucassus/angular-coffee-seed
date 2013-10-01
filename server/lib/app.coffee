express = require("express")
path = require("path")

app = express()
app.use express.logger()
app.use express.bodyParser()
app.use express.static(path.join(__dirname, "../../dist"))

utils = require("./utils")

ProductProvider = new require("./product_provider")
productProvider = new ProductProvider()

# bootstrap with dummy data
fixtures = require("./fixtures")
productProvider.save fixtures.products()

app.get "/api/products.json", (req, res) ->
  productProvider.findAll (error, products) ->
    res.send products

app.post "/api/products.json", (req, res) ->
  productProvider.save req.body, (error, products) ->
    res.send products[0]

app.post "/api/products/:id.json", (req, res) ->
  id = req.params.id
  params = req.body

  productProvider.update id, params, (error, product) ->
    res.send product

app.get "/api/products/:id.json", (req, res) ->
  id = req.params.id

  productProvider.findById id, (error, product) ->
    res.send if product? then product else 404

app.delete "/api/products/:id.json", (req, res) ->
  id = req.params.id

  productProvider.destroy id, (error, product) ->
    res.send product

module.exports = app
