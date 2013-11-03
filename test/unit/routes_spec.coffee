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

  navigateTo = (to, params = {}) ->
    # for some reason `$route` has to be injected here
    beforeEach inject ($rootScope, $state) ->
      $rootScope.$apply -> $state.go(to, params)

  describe "route `/products`", ->
    navigateTo "products.list"

    it "is recognized", inject ($state) ->
      expect($state.current)
        .to.have.templateUrl("templates/products/list.html")
        .and.to.have.controller("products.IndexCtrl as index")
        .and.to.resolve("products")

    it "queries for the products", inject (Products) ->
      expect(Products.query).to.be.called

    it "loads the products", inject ($state) ->
      products = $state.$current.locals.resolve.$$values.products

      expect(products).to.have.length 2
      expect(products).to.satisfy (collection) -> _.findWhere(collection, id: 123)
      expect(products).to.satisfy (collection) -> _.findWhere(collection, id: 234)

  describe "route `/products/create`", ->
    navigateTo "products.create"

    it "is recognized", inject ($state) ->
      expect($state.current)
        .to.have.templateUrl("templates/products/form.html")
        .and.to.have.controller("products.FormCtrl as form")
        .and.to.resolve("product")

    it "resolves with a new product instance", inject ($state, Products) ->
      product = $state.$current.locals.resolve.$$values.product
      expect(product).to.be.instanceOf(Products)
      expect(product.id).to.be.undefined

  describe "route `/products/:id`", ->
    itIsRecognized = ->
      it "is recognized", inject ($state) ->
        expect($state.$current.parent)
          .to.have.templateUrl("templates/products/show.html")
          .and.to.have.controller("products.ShowCtrl as show")
          .and.to.resolve("product")

    itQueriesForAProduct = ->
      it "queries for a product", inject ($state, Products) ->
        expect(Products.get).to.be.calledWith(id: "123")

    itLoadsAProduct = ->
      it "loads a product", inject ($state) ->
        product = $state.$current.locals.resolve.$$values.product
        expect(product.id).to.equal 123
        expect(product.name).to.equal "foo"

    describe "`info` tab", ->
      navigateTo "products.show.info", id: 123

      itIsRecognized()
      itQueriesForAProduct()
      itLoadsAProduct()

      it "activates `info` tab", inject ($state) ->
        expect($state.current.data).to.have.property "activeTab", "info"

    describe "`details` tab", ->
      navigateTo "products.show.details", id: 123

      itIsRecognized()
      itQueriesForAProduct()
      itLoadsAProduct()

      it "activates `details` tab", inject ($state) ->
        expect($state.current.data).to.have.property "activeTab", "details"

  describe "route `/other`", ->
    navigateTo "other"

    it "is recognized", inject ($state) ->
      expect($state.current)
        .to.have.templateUrl("templates/other.html")
        .and.to.have.controller("OtherCtrl as other")

  describe "route `/tasks`", ->
    navigateTo "tasks"

    it "is recognized", inject ($state) ->
      expect($state.current)
        .to.have.templateUrl("templates/tasks.html")
        .and.to.have.controller("TasksCtrl as tasks")
