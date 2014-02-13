express = require("express")
fs = require("fs")
path = require("path")

app = express()

# configure logger
logFile = fs.createWriteStream("./tmp/express.log", flags: "a")
app.use express.logger(stream: logFile)

app.use express.bodyParser()
app.use express.static(path.join(__dirname, "../../dist"))

utils = require("./utils")

ProductProvider = require("./product_provider")
productProvider = new ProductProvider()

# bootstrap with dummy data
fixtures = require("./fixtures")
productProvider.save fixtures.products()

app.get "/api/products.json", (req, res) ->
  options =
    currentPage: parseInt req.query.currentPage
    pageSize: parseInt req.query.pageSize

  productProvider.findAllPaged options, (error, products) ->
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

app.post "/api/_loadFixtures.json", (req, res) ->
  productProvider.destroyAll ->
    productProvider.save fixtures.products(), ->
      res.send 200

module.exports = app
