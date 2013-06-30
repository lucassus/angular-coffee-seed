describe "Controller: TodosCtrl", ->

  beforeEach module("myApp")
  $scope = null

  beforeEach inject ($controller, $rootScope, alerts) ->
    $scope = $rootScope.$new()
    $controller "TodosCtrl", $scope: $scope
