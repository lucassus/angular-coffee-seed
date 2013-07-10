describe "Controller: MainCtrl", ->

  beforeEach module("myApp")
  $scope = null

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    $scope = $rootScope.$new()
    $controller "MainCtrl", $scope: $scope

  it "should attach a list of products to the scope", ->
    expect($scope.products.length).toBe 6
