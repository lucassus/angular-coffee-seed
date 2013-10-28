faker = require("Faker")

module.exports =

  products: ->
    products = [
      { name: "HTC Wildfire", description: "Old android phone", price: 499.99, discount: 10 }
      { name: "iPhone", price: 2500 }
      { name: "Nexus One", price: 1000, discount: 7 }
      { name: "Nexus 7", price: 1200, discount: 12 }
      { name: "Samsung Galaxy Note", price: 2699, discount: 0 }
      { name: "Samsung S4", price: 3000, discount: 2 }
    ]

    for product in products
      product.description ?= faker.Lorem.paragraphs(3)
      product.manufacturer ?= faker.Company.companyName()
      product.headline ?= faker.Company.catchPhrase()

    products
