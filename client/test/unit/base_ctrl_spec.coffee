describe "BaseCtrl", ->

  app = null
  beforeEach ->
    app = angular.module("testApp", [])
    app.value "foo", "this is foo"
    app.value "my.foo", "this is other foo"

  describe "basic usage", ->

    beforeEach ->
      class MyCtrl extends BaseCtrl

        @register app
        @inject "$scope", "foo"

        initialize: ->
          @$scope.foo = @foo
          @$scope.bar = "bar"

      module "testApp"

    it "registers the controller with all dependencies", inject ($rootScope, $controller) ->
      $scope = $rootScope.$new()
      $controller "MyCtrl", $scope: $scope

      expect($scope.foo).to.eq "this is foo"
      expect($scope.bar).to.eq "bar"

  describe "when the controller name is specified", ->

    beforeEach ->
      class MyCtrl extends BaseCtrl

        @register app, "my.controller"
        @inject "$scope"

        initialize: ->
          @$scope.foo = "foo"

      module "testApp"

    it "register controller at the different name", inject ($rootScope, $controller) ->
      $scope = $rootScope.$new()
      $controller "my.controller", $scope: $scope

      expect($scope.foo).to.eq "foo"

  describe "when different name for a dependency is specified", ->

    beforeEach ->
      class OtherCtrl extends BaseCtrl

        @register app
        @inject "$scope", "my.foo as foobar"

        initialize: ->
          @$scope.foo = @foobar

      module "testApp"

    it "registers the dependency under different name", inject ($rootScope, $controller) ->
      $scope = $rootScope.$new()
      $controller "OtherCtrl", $scope: $scope

      expect($scope.foo).to.eq "this is other foo"

  describe "when the module name is given", ->

    beforeEach ->
      class OtherCtrl extends BaseCtrl

        @register "testApp"
        @inject "$scope", "my.foo as foobar"

        initialize: ->
          @$scope.foo = @foobar

      module "testApp"

    it "registers under the given module", inject ($rootScope, $controller) ->
      $scope = $rootScope.$new()
      $controller "OtherCtrl", $scope: $scope

      expect($scope.foo).to.eq "this is other foo"
