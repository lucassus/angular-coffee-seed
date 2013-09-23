describe "Application routes", ->

  # stub `Products` service
  beforeEach module "myApp.resources", ($provide) ->
    Products = sinon.stub(query: angular.noop)

    products = [{ id: 1, name: "foo" }, { id: 2, name: "bar" }]
    Products.query.returns $promise: then: (callback) -> callback(products)

    $provide.value "Products", Products

    return

  beforeEach module "myApp"

  navigateTo = (path) ->
    # for some reason `$route` has to be injected here
    beforeEach inject ($location, $route, $rootScope) ->
      $rootScope.$apply -> $location.path(path)

  describe "route `/`", ->
    navigateTo "/"

    it "is recognized", inject ($route) ->
      expect($route.current.templateUrl).to.equal "templates/views/main.html"
      expect($route.current.controller).to.equal "MainCtrl as main"
      expect($route.current.resolve.products).to.not.be.undefined

    it "queries for products", inject (Products) ->
      expect(Products.query).to.be.called

    it "loads products", inject ($route) ->
      products = $route.current.locals.products
      expect(products).to.have.length 2
      expect(products).to.satisfy (collection) -> _.findWhere(collection, id: 1)
      expect(products).to.satisfy (collection) -> _.findWhere(collection, id: 2)

  describe "route `/other`", ->
    navigateTo "/other"

    it "is recognized", inject ($route) ->
      expect($route.current.templateUrl).to.equal "templates/views/other.html"
      expect($route.current.controller).to.equal "OtherCtrl as other"

  describe "route `/tasks`", ->
    navigateTo "/tasks"

    it "is recognized", inject ($route) ->
      expect($route.current.templateUrl).to.equal "templates/views/tasks.html"
      expect($route.current.controller).to.equal "TasksCtrl as tasks"
