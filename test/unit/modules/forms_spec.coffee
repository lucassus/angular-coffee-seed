describe "Module `forms`", ->

  beforeEach module "myApp.forms"

  describe "Directive `mySubmit`", ->

    $scope = null
    element = null

    beforeEach inject ($rootScope, $compile) ->
      $scope = $rootScope.$new()
      $scope.item = name: ""
      $scope.save = sinon.spy()

      element = angular.element """
        <form name="testForm" my-submit="save(item, testForm)">
          <input type="text" ng-model="item.name" ng-required="true" />
          <button type="submit">Save</button>
        </form>
      """
      element = $compile(element)($scope)

    describe "when the form is valid", ->
      beforeEach ->
        $scope.$apply -> $scope.item.name = "foo"

      it "calls `save` method", ->
        element.find("button[type=submit]").click()
        expect($scope.save.called).to.be.true
        expect($scope.save.calledWith($scope.item, $scope.testForm)).to.be.true

      it "marks the form as submitted", ->
        expect($scope.testForm.$submitted).to.be.undefined
        element.find("button[type=submit]").click()
        expect($scope.testForm.$submitted).to.be.true

    describe "when the form is invalid", ->
      beforeEach ->
        $scope.$apply -> $scope.item.name = ""

      it "does not call `save` method", ->
        element.find("button[type=submit]").click()
        expect($scope.save.called).to.be.false

  describe "Directive `myMessages`", ->

    $scope = null
    element = null

    beforeEach inject ($rootScope, $compile) ->
      $scope = $rootScope.$new()
      $scope.user = login: ""

      element = angular.element """
        <form name="testForm">
          <input type="text" name="login" ng-model="user.login"
                 ng-required="true" ng-minlength="6" />
          <div my-messages="login">
            <span ng-message="minlength">login is too short</span>
            <span ng-message="required">login is required</span>
          </div>

          <button type="submit">Save</button>
        </form>
      """
      element = $compile(element)($scope)

    it "hides errors by default", ->
      expect(element.find("div[my-messages]").text()).to.not.include("login is required")
      expect(element.find("div[my-messages]").text()).to.not.include("login is too short")

    describe "on change", ->

      describe "when the input is valid", ->
        beforeEach ->
          $scope.$apply -> $scope.user.login = "foobar"

        it "hides the errors", ->
          expect(element.find("div[my-messages]").text()).to.not.include("login is required")
          expect(element.find("div[my-messages]").text()).to.not.include("login is too short")

      describe "when the input is invalid", ->
        beforeEach ->
          inputEl = element.find("input[name=login]")
          inputEl.val("foo").trigger("input")

        it "shows the errors", ->
          expect(element.find("div[my-messages]").text()).to.include("login is too short")

    describe "on submit", ->

      describe "when the form is valid", ->
        beforeEach ->
          $scope.$apply -> $scope.user.login = "foobar"
          element.find("button[type=submit]").click()

        it "hides the errors", ->
          expect(element.find("div[my-messages]").text()).to.not.include("login is required")
          expect(element.find("div[my-messages]").text()).to.not.include("login is too short")

      describe "when the form is invalid", ->
        beforeEach ->
          element.find("button[type=submit]").click()

        it "shows the errors", ->
          expect(element.find("div[my-messages]").text()).to.include("login is required")
