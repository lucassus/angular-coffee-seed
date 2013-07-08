describe "myApp.alerts", ->
  beforeEach module("myApp.alerts")
  beforeEach module("mocks")

  describe "controller", ->
    $scope = null
    alerts = null

    beforeEach inject ($injector, $rootScope, $controller) ->
      $scope = $rootScope.$new()

      alerts = $injector.get("alerts")

      $controller "alerts",
        $scope: $scope,
        alerts: alerts

    Then "$scope.alertMessages should be defined", ->
      expect($scope.alertMessages).toBeDefined()
    And ->
      expect($scope.alertMessages).toEqual([])

    describe "#info", ->
      When -> alerts.info("Test message.")
      Then "it should contain the message", ->
        expect($scope.alertMessages).toContain(id: 1, type: "info", text: "Test message.")

    describe "#disposeAlert", ->
      Given ->
        alerts.info("Information..")
        alerts.error("Error..")
        spyOn(alerts, "dispose").andCallThrough()

      When -> $scope.disposeAlert(2)

      Then "the message should disappear", -> expect(alerts.dispose).toHaveBeenCalledWith(2)
      And -> expect($scope.alertMessages).toContain(id: 1, type: "info", text: "Information..")
      And -> expect($scope.alertMessages).not.toContain(id: 2, type: "error", text: "Error..")

  describe "directive", ->
    $scope = null
    element = null

    beforeEach module("myApp.templates")

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

  describe "service", ->
    alerts = null
    beforeEach inject ($injector) -> alerts = $injector.get("alerts")

    Then "then service should be defined", ->
      expect(alerts).toBeDefined()

    describe "#nextId", ->
      describe "first id", ->
        Then "it should return the first id", -> expect(alerts.nextId()).toEqual(1)

      describe "next id", ->
        Given -> alerts.nextId() for [1..4]
        Then "it should return the next id", -> expect(alerts.nextId()).toEqual(5)

    describe "#push", ->
      Given -> spyOn(alerts, "delayedDispose")

      describe "return id for the new flash, message", ->
        When -> alerts.push("info", "Test..")

        describe "first message", ->
          Then "it should return id for the first message", ->
            expect(alerts.delayedDispose).toHaveBeenCalledWith(1)
          And -> expect(alerts.lastId).toEqual(1)

        describe "second message", ->
          When -> alerts.push("error", "Test error..")
          Then "it should return id for the next message", ->
            expect(alerts.delayedDispose).toHaveBeenCalledWith(2)
          And -> expect(alerts.lastId).toEqual(2)

      describe "#info", ->
        describe "push the given message", ->
          Given -> @testMessage = "This is a test message!"
          Given -> @otherTestMessage = "This is a second test message!"

          When ->
            alerts.info(@testMessage)
            alerts.info(@otherTestMessage)

          Then "it should push the given messages", ->
            expect(alerts.messages).toContain(id: 1, type: "info", text: @testMessage)
          And ->
            expect(alerts.messages).toContain(id: 2, type: "info", text: @otherTestMessage)

      describe "#error", ->
        describe "push the given message", ->
          Given -> @testMessage = "This is a test message!"

          When -> alerts.error(@testMessage)

          Then "it should push the given messages", ->
            expect(alerts.delayedDispose).toHaveBeenCalledWith(1)
          And ->
            expect(alerts.messages).toContain(id: 1, type: "error", text: @testMessage)

    describe "#dispose", ->
      describe "remove a message with the given id", ->
        Given ->
          alerts.info("First message")
          alerts.info("Second message")
          alerts.info("Third message")
          alerts.error("Error message")

        When -> alerts.dispose(2)

        Then "it should remove a message with the given id", ->
          expect(alerts.messages).toContain(id: 1, type: "info", text: "First message")
          expect(alerts.messages).not.toContain(id: 2, type: "info", text: "Second message")
          expect(alerts.messages).toContain(id: 3, type: "info", text: "Third message")
          expect(alerts.messages).toContain(id: 4, type: "error", text: "Error message")

    describe "#delayedDispose", ->
      $timeout = null
      beforeEach inject ($injector) -> $timeout = $injector.get("$timeout")

      describe "remove a message after the given time", ->
        Given -> alerts.info("First message")

        When ->
          alerts.delayedDispose(1)
          expect(alerts.messages).toContain(id: 1, type: "info", text: "First message")

        When -> $timeout.flush()
        Then "it should remove all messages", ->
          expect(alerts.messages).toEqual([])
