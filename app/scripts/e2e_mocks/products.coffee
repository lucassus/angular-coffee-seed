mocks = angular.module "myApp.e2eMocks"

mocks.service "products", ->
  products = [
    {
      id: 1, name: "HTC Wildfire", description: "Old android phone",
      manufacturer: "HTC",
      price: 499.99, discount: 10
    }
    { id: 2, name: "iPhone", price: 2500 }
    { id: 3, name: "Nexus One", price: 1000, discount: 7 }
    { id: 4, name: "Nexus 7", price: 1200, discount: 12 }
    { id: 5, name: "Samsung Galaxy Note", price: 2699, discount: 0 }
    { id: 6, name: "Samsung S4", price: 3000, discount: 2 }
  ]

  all: -> products

  findWhere: (where = {}) ->
    _.findWhere(products, where)

  create: (params) ->
    params.id = _.last(products).id + 1
    products.push(params)
    params

  update: (id, params) ->
    product = @findWhere(id: id)
    product[field] = value for field, value of params
    product

  delete: (id) ->
    product = @findWhere(id: id)
    index = products.indexOf(product)
    products.splice(index, 1) if index isnt -1
    index
