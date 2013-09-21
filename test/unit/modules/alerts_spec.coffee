describe "myApp.alerts", ->
  beforeEach module("myApp.alerts")
  beforeEach module("mocks")

  describe "controller: alerts", ->
    $scope = null
    alerts = null

    beforeEach inject ($injector, $rootScope, $controller) ->
      $scope = $rootScope.$new()

      alerts = $injector.get("alerts")

      $controller "alerts",
        $scope: $scope,
        alerts: alerts

    it "assings flash messages", ->
      expect($scope.alertMessages).toBeDefined()
      expect($scope.alertMessages).toEqual([])

      alerts.info("Test message.")
      expect($scope.alertMessages).toContain(id: 1, type: "info", text: "Test message.")

    describe "#disposeAlert", ->
      it "disposes an alert at the given index", ->
        # Given
        alerts.info("Information..")
        alerts.error("Error..")
        spy = sinon.spy(alerts, "dispose")

        # When
        $scope.disposeAlert(2)

        # Then
        expect(spy).toHaveBeenCalled()
        expect(spy).toHaveBeenCalledWith(2)

        expect($scope.alertMessages).toContain(id: 1, type: "info", text: "Information..")
        expect($scope.alertMessages).not.toContain(id: 2, type: "error", text: "Error..")

  describe "directive: alerts", ->
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
      expect(element.find(".alert-info").length).toEqual(1)

  describe "service: alerts", ->
    it "is defined", inject (alerts) ->
      expect(alerts).toBeDefined()

    describe "#nextId", ->
      it "return the next id for the new flash message", inject (alerts) ->
        expect(alerts.nextId()).toEqual(1)
        alerts.nextId() for [1..4]
        expect(alerts.nextId()).toEqual(6)

    describe "#push", ->
      spy = null

      beforeEach inject (alerts) ->
        spy = sinon.spy(alerts, "delayedDispose")

      it "returns an id for the new flash message", inject (alerts) ->
        expect(alerts.push("info", "Test..")).toEqual(1)
        expect(spy).toHaveBeenCalledWith(1)

        expect(alerts.push("error", "Test error..")).toEqual(2)
        expect(spy).toHaveBeenCalledWith(2)

      describe "#info", ->
        it "pushesh the given message", inject (alerts) ->
          # Given
          testMessage = "This is a test message!"
          otherTestMessage = "This is a second test message!"

          # When
          alerts.info(testMessage)
          expect(spy).toHaveBeenCalledWith(1)

          alerts.info(otherTestMessage)
          expect(spy).toHaveBeenCalledWith(2)

          # Then
          expect(alerts.messages).toContain(id: 1, type: "info", text: testMessage)
          expect(alerts.messages).toContain(id: 2, type: "info", text: otherTestMessage)

      describe "#error", ->
        it "pushesh the given message", inject (alerts) ->
          # Given
          testMessage = "This is a test message!"

          # When
          alerts.error(testMessage)
          expect(spy).toHaveBeenCalledWith(1)

          # Then
          expect(alerts.messages).toContain(id: 1, type: "error", text: testMessage)

    describe "#dispose", ->
      it "removes a message with the given id", inject (alerts) ->
        # Given
        alerts.info("First message")
        alerts.info("Second message")
        alerts.info("Third message")
        alerts.error("Error message")

        # When
        alerts.dispose(2)

        # Then
        expect(alerts.messages).toContain(id: 1, type: "info", text: "First message")
        expect(alerts.messages).not.toContain(id: 2, type: "info", text: "Second message")
        expect(alerts.messages).toContain(id: 3, type: "info", text: "Third message")
        expect(alerts.messages).toContain(id: 4, type: "error", text: "Error message")

    describe "#delayedDispose", ->
      it "removes a message after the given time", inject (alerts, $timeout) ->
        # Given
        alerts.info("First message")

        # When
        alerts.delayedDispose(1)
        expect(alerts.messages).toContain(id: 1, type: "info", text: "First message")

        $timeout.flush()

        # Then
        expect(alerts.messages).toEqual([])
