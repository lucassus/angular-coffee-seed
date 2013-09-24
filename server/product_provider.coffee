_ = require("underscore")

# Responsible for returning and updating the data for products
class ProductProvider

  constructor: ->
    @products = []

  findAll: (callback = ->) ->
    callback(null, @products)

  findById: (id, callback = ->) ->
    product = _.findWhere(@products, id: parseInt(id))
    callback(null, product)

  save: (products, callback = ->) ->
    if typeof(products.length) is "undefined"
      products = [products]

    for product in products
      product.id = @_nextId()
      product.createdAt = new Date()

      @products.push(product)

    callback(null, products)

  # @private
  _nextId: ->
    @_currentId or= 0
    ++@_currentId

# bootstrap with dummy data
productProvider = new ProductProvider()
productProvider.save [
  { name: "HTC Wildfire", price: 499.99, discount: 10 }
  { name: "iPhone", price: 2500 }
  { name: "Nexus One", price: 1000, discount: 7 }
  { name: "Nexus 7", price: 1200, discount: 12 }
  { name: "Samsung Galaxy Note", price: 2699, discount: 0 }
  { name: "Samsung S4", price: 3000, discount: 2 }
]

console.log "bootsrap with", productProvider
module.exports = productProvider
