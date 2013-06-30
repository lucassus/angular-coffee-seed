describe "Application routes", ->

  beforeEach module("myApp")

  beforeEach inject ($httpBackend) ->
    for partial in ["views/main.html", "views/other.html"]
      $httpBackend.whenGET(partial).respond({})

  beforeEach inject ($location, $rootScope) ->
    @navigateTo = (path) ->
      $location.path(path)
      $rootScope.$digest()

  it "recognizes '/'", inject ($route) ->
    @navigateTo "/"
    expect($route.current.templateUrl).toEqual("views/main.html")
    expect($route.current.controller).toEqual("MainCtrl")

  it "recognizes '/other'", inject ($route) ->
    @navigateTo "/other"
    expect($route.current.templateUrl).toEqual("views/other.html")
    expect($route.current.controller).toEqual("OtherCtrl")
