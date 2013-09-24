resources = angular.module("myApp.resources", ["ngResource"])

resources.factory "Products", [
  "$resource", ($resource) ->
    Products = $resource "/api/products.json", {},
      query: { method: "GET", isArray: true }

    angular.extend Products.prototype,
      priceWithDiscount: ->
        return @price unless @hasDiscount()
        return @price * (1 - @discount / 100.0)

      # Returs true when the product has a discount
      hasDiscount: -> @discount? and @discount > 0

    Products
]
