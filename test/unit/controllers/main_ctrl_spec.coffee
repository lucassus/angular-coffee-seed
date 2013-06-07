describe "Controller: MainCtrl", ->

  beforeEach module("myApp")
  MainCtrl = null
  scope = null

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainCtrl = $controller "MainCtrl", $scope: scope

  it "should attach a list of products to the scope", ->
    expect(scope.products.length).toBe(6)
