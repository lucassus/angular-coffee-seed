describe "Application routes", ->

  beforeEach module("myApp")

  beforeEach inject ($location, $rootScope) ->
    @navigateTo = (path) ->
      $location.path(path)
      $rootScope.$digest()

  it "recognizes '/'", inject ($route) ->
    @navigateTo "/"
    expect($route.current.templateUrl).toEqual("templates/views/main.html")
    expect($route.current.controller).toEqual("MainCtrl")

  it "recognizes '/other'", inject ($route) ->
    @navigateTo "/other"
    expect($route.current.templateUrl).toEqual("templates/views/other.html")
    expect($route.current.controller).toEqual("OtherCtrl")

  it "recognizes '/todos'", inject ($route) ->
    @navigateTo "/todos"
    expect($route.current.templateUrl).toEqual("templates/views/todos.html")
    expect($route.current.controller).toEqual("TodosCtrl")
