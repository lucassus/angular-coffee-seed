describe "Controller: OtherCtrl", ->

  beforeEach module("myApp")
  $scope = null

  beforeEach inject ($controller, $rootScope, alerts) ->
    # initialize the controller
    $scope = $rootScope.$new()
    $controller "OtherCtrl", $scope: $scope

    spyOn(alerts, "info")

  it "should attach a name", ->
    expect($scope.name).toBe "This is the other controller"

  it "should display the flash message", inject (alerts) ->
    $scope.sayHello()
    expect(alerts.info).toHaveBeenCalledWith("Hello World!")
