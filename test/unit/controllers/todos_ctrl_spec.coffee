describe "Controller: TodosCtrl", ->

  beforeEach module("myApp")
  $scope = null

  beforeEach inject ($controller, $rootScope, alerts) ->
    $scope = $rootScope.$new()
    $controller "TodosCtrl", $scope: $scope

  it "assisgns todos", ->
    expect($scope.todos).toBeDefined()
    expect($scope.todos.length).toEqual 3
