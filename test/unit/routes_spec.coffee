describe "Application routes", ->
  beforeEach module("myApp")

  beforeEach inject ($location, $rootScope) ->
    @navigateTo = (path) ->
      $location.path(path)
      $rootScope.$digest()

  it "recognizes '/'", inject ($route, $httpBackend) ->
    $httpBackend.expectGET("/api/products.json").respond([])
    @navigateTo "/"
    $httpBackend.flush()

    expect($route.current.templateUrl).to.equal "templates/views/main.html"
    expect($route.current.controller).to.equal "MainCtrl as main"

  it "recognizes '/other'", inject ($route) ->
    @navigateTo "/other"
    expect($route.current.templateUrl).to.equal "templates/views/other.html"
    expect($route.current.controller).to.equal "OtherCtrl as other"

  it "recognizes '/tasks'", inject ($route) ->
    @navigateTo "/tasks"
    expect($route.current.templateUrl).to.equal "templates/views/tasks.html"
    expect($route.current.controller).to.equal "TasksCtrl as tasks"
