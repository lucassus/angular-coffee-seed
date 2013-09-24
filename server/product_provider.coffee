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

module.exports = ProductProvider
