_ = require("lodash")

# Responsible for returning and updating the data for products
class ProductProvider

  constructor: (products = []) ->
    @products = []
    @save(products)

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

  update: (id, params, callback = ->) ->
    @findById id, (error, product) ->
      _.extend(product, _.omit(params, "id"))
      callback(null, product)

  destroy: (id, callback = ->) ->
    @findById id, (error, product) =>
      @products = _.reject @products, (row) -> row.id is product.id
      callback(null, product)

  # @private
  _nextId: ->
    @_currentId or= 0
    ++@_currentId

module.exports = ProductProvider
