mocks = angular.module "myApp.e2eMocks", ["ngMockE2E"]

mocks.run [
  "$httpBackend", "$log", "products",
  ($httpBackend, $log, products) ->
    PRODUCTS_URL = "/api/products.json"
    PRODUCT_URL  = /\/api\/products\/(\d+).json/

    # Extract product id from the product url
    getId = (url) -> parseInt url.match(PRODUCT_URL)[1]

    # Stub list
    $httpBackend.whenGET(PRODUCTS_URL).respond (method, url, data) ->
      $log.debug arguments

      [200, products.all()]

    # Stub get
    $httpBackend.whenGET(PRODUCT_URL).respond (method, url, data) ->
      $log.debug arguments

      product = products.findWhere(id: getId(url))

      if product?
        [200, angular.toJson(product)]
      else
        [404]

    # Stub create
    $httpBackend.whenPOST(PRODUCTS_URL).respond (method, url, data) ->
      $log.debug arguments

      params = angular.fromJson(data)
      products.create(params)

      [201]

    # Stub update
    $httpBackend.whenPOST(PRODUCT_URL).respond (method, url, data) ->
      $log.debug arguments

      params = angular.fromJson(data)
      product = products.update(getId(url), params)

      [201, angular.toJson(product)]

    # Stub delete
    $httpBackend.whenDELETE(PRODUCT_URL).respond (method, url, data) ->
      $log.debug arguments

      products.delete(getId(url))

      [200]

    $httpBackend.whenGET(/.*/).passThrough()
  ]

# dynamically load the module
app = angular.module "myApp"
app.requires.push("myApp.e2eMocks")

app.run ["$log", ($log) ->
  $log.debug "Loading e2e mocks.."
]
