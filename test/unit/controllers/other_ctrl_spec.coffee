describe "Controller: OtherCtrl", ->

  # stub `alerts` service
  beforeEach module "myApp", ($provide) ->
    alertsMock = info: angular.noop
    $provide.value "alerts", sinon.stub(alertsMock)
    return

  ctrl = null

  # Initialize the controller
  beforeEach inject ($controller) ->
    ctrl = $controller "OtherCtrl"

  it "has a name", ->
    expect(ctrl.name).toBe "This is the other controller"

  describe "#sayHello", ->

    it "displays the flash message", inject (alerts) ->
      # When
      ctrl.sayHello()

      # Then
      expect(alerts.info.called).toBeTruthy()
      expect(alerts.info.calledWith("Hello World!")).toBeTruthy()
