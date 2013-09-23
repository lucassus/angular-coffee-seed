describe "Application routes", ->
  beforeEach module "myApp"

  beforeEach inject ($location, $rootScope) ->
    @navigateTo = (path) ->
      $rootScope.$apply ->
        $location.path(path)

  # TODO mock `Products` service
  # TODO it "resolves products"
  it "recognizes '/'", inject ($route, Products) ->
    # Given
    stub = sinon.stub(Products, "query")
    stub.returns $promise: then: (callback) -> callback([{ id: 1, name: "foo" }, { id: 2, name: "bar" }])

    # When
    @navigateTo "/"

    # Then
    expect(stub).to.be.called

    expect($route.current.templateUrl).to.equal "templates/views/main.html"
    expect($route.current.controller).to.equal "MainCtrl as main"
    expect($route.current.resolve.products).to.not.be.undefined

    products = $route.current.locals.products
    expect(products).to.have.length 2

  it "recognizes '/other'", inject ($route) ->
    @navigateTo "/other"
    expect($route.current.templateUrl).to.equal "templates/views/other.html"
    expect($route.current.controller).to.equal "OtherCtrl as other"

  it "recognizes '/tasks'", inject ($route) ->
    @navigateTo "/tasks"
    expect($route.current.templateUrl).to.equal "templates/views/tasks.html"
    expect($route.current.controller).to.equal "TasksCtrl as tasks"
