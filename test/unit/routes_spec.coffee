describe "Application routes", ->

  beforeEach module("myApp")

  beforeEach module("templates/views/main.html")
  beforeEach module("templates/views/other.html")
  beforeEach module("templates/views/tasks.html")

  beforeEach inject ($location, $rootScope) ->
    @navigateTo = (path) ->
      $location.path(path)
      $rootScope.$digest()

  it "recognizes '/'", inject ($route) ->
    @navigateTo "/"
    expect($route.current.templateUrl).toEqual "templates/views/main.html"
    expect($route.current.controller).toEqual "MainCtrl as main"

  it "recognizes '/other'", inject ($route) ->
    @navigateTo "/other"
    expect($route.current.templateUrl).toEqual "templates/views/other.html"
    expect($route.current.controller).toEqual "OtherCtrl as other"

  it "recognizes '/tasks'", inject ($route) ->
    @navigateTo "/tasks"
    expect($route.current.templateUrl).toEqual "templates/views/tasks.html"
    expect($route.current.controller).toEqual "TasksCtrl as tasks"
