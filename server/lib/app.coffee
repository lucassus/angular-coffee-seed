express = require("express")
fs = require("fs")
path = require("path")

app = express()

# configure logger
logFile = fs.createWriteStream("./tmp/express.log", flags: "a")
morgan  = require("morgan")
app.use morgan(stream: logFile)

bodyParser = require("body-parser")
app.use bodyParser()

app.use express.static(path.join(__dirname, "../../dist"))

utils = require("./utils")

ProductProvider = require("./product_provider")
productProvider = new ProductProvider()

# bootstrap with dummy data
fixtures = require("./fixtures")
productProvider.save fixtures.products()

api = express.Router()

api.get "/products.json", (req, res) ->
  options =
    currentPage: parseInt req.query.currentPage
    pageSize: parseInt req.query.pageSize

  productProvider.findAllPaged options, (error, products) ->
    res.send products

api.post "/products.json", (req, res) ->
  productProvider.save req.body, (error, products) ->
    res.send products[0]

api.post "/products/:id.json", (req, res) ->
  id = req.params.id
  params = req.body

  productProvider.update id, params, (error, product) ->
    res.send product

api.get "/products/:id.json", (req, res) ->
  id = req.params.id

  productProvider.findById id, (error, product) ->
    res.send if product? then product else 404

api.delete "/products/:id.json", (req, res) ->
  id = req.params.id

  productProvider.destroy id, (error, product) ->
    res.send product

api.post "/_loadFixtures.json", (req, res) ->
  productProvider.destroyAll ->
    productProvider.save fixtures.products(), ->
      res.send 200

app.use "/api", api

module.exports = app
