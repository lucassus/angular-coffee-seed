resources = angular.module("myApp.resources", ["ngResource"])

resources.factory "Products", [
  "$resource", ($resource) ->
    Products = $resource "/api/products.json", {},
      query: { method: "GET", isArray: true }

    angular.extend Products.prototype,
      # TODO test it
      priceWithDiscount: ->
        return @price unless @hasDiscount()
        return @price * (1 - @discount / 100.0)

      # TODO test it, cases: discount can be 0, null, undefined, false, below 0, etc.
      hasDiscount: -> @discount? and @discount > 0

    Products
]
