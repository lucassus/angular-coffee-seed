describe "Application routes", ->

  # stub `Products` service
  beforeEach module "myApp.resources", ($provide) ->
    products = [{ id: 123, name: "foo" }, { id: 234, name: "bar" }]

    class Products
      @query: sinon.stub().returns $promise: then: (callback) -> callback(products)
      @get: sinon.stub().returns $promise: then: (callback) -> callback(products[0])

    $provide.value "Products", Products

    return

  beforeEach module "myApp"

  navigateTo = (path) ->
    # for some reason `$route` has to be injected here
    beforeEach inject ($location, $route, $rootScope) ->
      $rootScope.$apply -> $location.path(path)

  describe "route `/products`", ->
    navigateTo "/products"

    it "is recognized", inject ($route) ->
      expect($route.current)
        .to.have.templateUrl("templates/views/products/index.html")
        .and.to.have.controller("products.IndexCtrl as index")
        .and.to.resolve("products")

    it "queries for the products", inject (Products) ->
      expect(Products.query).to.be.called

    it "loads the products", inject ($route) ->
      products = $route.current.locals.products
      expect(products).to.have.length 2
      expect(products).to.satisfy (collection) -> _.findWhere(collection, id: 123)
      expect(products).to.satisfy (collection) -> _.findWhere(collection, id: 234)

  describe "route `/products/create`", ->
    navigateTo "/products/create"

    it "is recognized", inject ($route) ->
      expect($route.current)
        .to.have.templateUrl("templates/views/products/form.html")
        .and.to.have.controller("products.FormCtrl as form")
        .and.to.resolve("product")

    it "resolves with a new product instance", inject ($route, Products) ->
      product = $route.current.locals.product
      expect(product).to.be.instanceOf(Products)
      expect(product.id).to.be.undefined

  describe "route `/products/:id`", ->
    navigateTo "/products/123"

    it "is recognized", inject ($route) ->
      expect($route.current)
        .to.have.templateUrl("templates/views/products/show.html")
        .and.to.have.controller("products.ShowCtrl as show")
        .and.to.resolve("product")

    it "queries for a product", inject ($route, Products) ->
      expect(Products.get).to.be.calledWith(id: "123")

    it "loads a product", inject ($route) ->
      product = $route.current.locals.product
      expect(product.id).to.equal 123
      expect(product.name).to.equal "foo"

  describe "route `/other`", ->
    navigateTo "/other"

    it "is recognized", inject ($route) ->
      expect($route.current)
        .to.have.templateUrl("templates/views/other.html")
        .and.to.have.controller("OtherCtrl as other")

  describe "route `/tasks`", ->
    navigateTo "/tasks"

    it "is recognized", inject ($route) ->
      expect($route.current)
        .to.have.templateUrl("templates/views/tasks.html")
        .and.to.have.controller("TasksCtrl as tasks")

  describe "other routes", ->
    navigateTo "/this/is/unknown/route"

    it "redirects to `/products`", inject ($route) ->
      expect($route.current.originalPath).to.equal "/products"
