describe "Controller `MainCtrl`", ->

  beforeEach module "myApp"

  ctrl = null
  $scope = null

  # Initialize the controller
  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()

    ctrl = $controller "MainCtrl",
      $scope: $scope

  describe "$scope", ->

    it "has `$state`", ->
      expect($scope.$state).to.not.be.undefined

    it "has `$stateParams`", ->
      expect($scope.$stateParams).to.not.be.undefined
