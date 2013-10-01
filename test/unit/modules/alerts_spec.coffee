describe "Module `myApp.alerts`", ->

  beforeEach module "myApp.alerts"
  beforeEach module "mocks"

  describe "Controller `alerts`", ->
    $scope = null
    alerts = null

    beforeEach inject ($injector, $rootScope, $controller) ->
      $scope = $rootScope.$new()

      alerts = $injector.get("alerts")

      $controller "alerts",
        $scope: $scope,
        alerts: alerts

    it "assings flash messages", ->
      expect($scope.alertMessages).to.not.be.undefined
      expect($scope.alertMessages).to.be.empty

      # When
      alerts.info("Test message.")

      # Then
      lastMessage = $scope.alertMessages[0]
      expect(lastMessage.id).to.equal 1
      expect(lastMessage.type).to.equal "info"
      expect(lastMessage.text).to.equal "Test message."

    describe "#disposeAlert()", ->
      it "disposes an alert at the given index", ->
        # Given
        alerts.info("Information..")
        alerts.error("Error..")
        spy = sinon.spy(alerts, "dispose")

        # When
        $scope.disposeAlert(2)

        # Then
        expect(spy).to.be.called
        expect(spy).to.be.calledWith 2

        firstMessage = _.findWhere($scope.alertMessages, id: 1)
        expect(firstMessage).to.not.be.undefined
        expect(firstMessage.type).to.equal "info"
        expect(firstMessage.text).to.equal "Information.."

        secondMessage = _.findWhere($scope.alertMessages, id: 2)
        expect(secondMessage).to.be.undefined

  describe "Directive `alerts`", ->
    $scope = null
    element = null

    beforeEach inject ($rootScope, $compile) ->
      $scope = $rootScope

      # compite the html snippet
      element = angular.element "<alerts></alerts>"
      linkFn = $compile(element)
      linkFn($scope)

      $scope.$digest()

    it "renders alerts", ->
      $scope.$apply -> $scope.alertMessages = [
        type: "info", text: "Test message"
      ]
      expect(element.find(".alert-info").length).to.equal(1)

  describe "Service `alerts`", ->
    it "is defined", inject (alerts) ->
      expect(alerts).to.not.be.undefined

    describe "#nextId()", ->
      it "return the next id for the new flash message", inject (alerts) ->
        expect(alerts.nextId()).to.equal(1)
        alerts.nextId() for [1..4]
        expect(alerts.nextId()).to.equal(6)

    describe "#push()", ->
      spy = null

      beforeEach inject (alerts) ->
        spy = sinon.spy(alerts, "delayedDispose")

      it "returns an id for the new flash message", inject (alerts) ->
        expect(alerts.push("info", "Test..")).to.equal 1
        expect(spy).to.be.calledWith 1

        expect(alerts.push("error", "Test error..")).to.equal 2
        expect(spy).to.be.calledWith 2

      describe "#info()", ->
        it "pushesh the given message", inject (alerts) ->
          # Given
          testMessage = "This is a test message!"
          otherTestMessage = "This is a second test message!"

          # When
          alerts.info(testMessage)
          expect(spy).to.be.calledWith 1

          alerts.error(otherTestMessage)
          expect(spy).to.be.calledWith 2

          # Then
          firstMessage = _.findWhere(alerts.messages, id: 1)
          expect(firstMessage).to.not.be.undefined
          expect(firstMessage.type).to.equal "info"
          expect(firstMessage.text).to.equal testMessage

          secondMessage = _.findWhere(alerts.messages, id: 2)
          expect(secondMessage).to.not.be.undefined
          expect(secondMessage.type).to.equal "error"
          expect(secondMessage.text).to.equal otherTestMessage

      describe "#error()", ->
        it "pushesh the given message", inject (alerts) ->
          # Given
          testMessage = "This is a test message!"

          # When
          alerts.error(testMessage)
          expect(spy).to.be.calledWith 1

          # Then
          lastMessage = _.findWhere(alerts.messages, id: 1)
          expect(lastMessage).to.not.be.undefined
          expect(lastMessage.type).to.equal "error"

      describe "#success()", ->

        it "pushesh the given message", inject (alerts) ->
          # Given
          testMessage = "This is a test message!"

          # When
          alerts.success(testMessage)
          expect(spy).to.be.calledWith 1

          # Then
          lastMessage = _.findWhere(alerts.messages, id: 1)
          expect(lastMessage).to.not.be.undefined
          expect(lastMessage.type).to.equal "success"

      describe "#warning()", ->

        it "pushesh the given message", inject (alerts) ->
          # Given
          testMessage = "This is a test message!"

          # When
          alerts.warning(testMessage)
          expect(spy).to.be.calledWith 1

          # Then
          lastMessage = _.findWhere(alerts.messages, id: 1)
          expect(lastMessage).to.not.be.undefined
          expect(lastMessage.type).to.equal "warning"

    describe "#dispose()", ->
      it "removes a message with the given id", inject (alerts) ->
        # Given
        alerts.info("First message")
        alerts.info("Second message")
        alerts.info("Third message")
        alerts.error("Error message")

        # When
        alerts.dispose(2)

        # Then
        firstMessage = _.findWhere(alerts.messages, text: "First message")
        expect(firstMessage).to.not.be.undefined

        secondMessage = _.findWhere(alerts.messages, text: "Second message")
        expect(secondMessage).to.be.undefined

        thirdMessage = _.findWhere(alerts.messages, text: "Third message")
        expect(thirdMessage).to.not.be.undefined

        forthMessage = _.findWhere(alerts.messages, type: "error", text: "Error message")
        expect(forthMessage).to.not.be.undefined

    describe "#delayedDispose()", ->

      it "removes a message after the given time", inject (alerts, $timeout) ->
        # Given
        alerts.info("First message")

        # When
        alerts.delayedDispose(1)

        # Then
        lastMessage = _.findWhere(alerts.message, id: 1)
        expect(lastMessage).to.be.defined

        # When
        $timeout.flush()

        # Then
        expect(alerts.messages).to.be.empty
        disposedMessage = _.findWhere(alerts.message, id: 1)
        expect(disposedMessage).to.not.be.defined
