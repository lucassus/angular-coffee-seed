app = angular.module("myApp")

class MainCtrl extends BaseCtrl

  @register app, "MainCtrl"
  @inject "$scope", "$state", "$stateParams"

  initialize: ->
    @$scope.$state = @$state
    @$scope.$stateParams = @$stateParams
