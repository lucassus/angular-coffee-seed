describe "Controller `OtherCtrl`", ->

  beforeEach module "myApp", ($provide) ->
    # stub `alerts` service
    $provide.decorator "alerts", ($delegate) ->
      sinon.stub($delegate)
      $delegate

  ctrl = null

  # Initialize the controller
  beforeEach inject ($controller) ->
    ctrl = $controller "OtherCtrl"

  it "has a name", ->
    expect(ctrl.name).to.equal "This is the other controller"

  describe "#sayHello()", ->

    it "displays the flash message", inject (alerts) ->
      # When
      ctrl.sayHello()

      # Then
      expect(alerts.info).to.be.called
      expect(alerts.info).to.be.calledWith("Hello World!")
