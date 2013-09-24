describe "Module `myApp.navigation`", ->

  beforeEach module "myApp.navigation"
  beforeEach module "mocks"

  describe "Directive `navLinks`", ->
    $scope = null
    element = null
    changeLocation = null

    beforeEach inject ($rootScope, $compile, $location) ->
      $scope = $rootScope

      # compite the html snippet
      element = angular.element """
        <ul nav-links>
          <li><a href="#/">Home</a></li>
          <li><a href="#/foo">Foo</a></li>
          <li><a href="#/bar">Bar</a></li>
        </ul>
      """
      linkFn = $compile(element)
      linkFn($scope)

      changeLocation = (path) ->
        $scope.$apply -> $location.path(path)

    it "activates the 'Home' link by default", ->
      changeLocation("/")
      expect(element.find("li:nth-child(1)").hasClass("active")).to.be.true
      expect(element.find("li:nth-child(2)").hasClass("active")).to.be.false
      expect(element.find("li:nth-child(3)").hasClass("active")).to.be.false

    it "activates other links on location change", ->
      changeLocation("/foo")
      expect(element.find("li:nth-child(1)").hasClass("active")).to.be.false
      expect(element.find("li:nth-child(2)").hasClass("active")).to.be.true
      expect(element.find("li:nth-child(3)").hasClass("active")).to.be.false

      changeLocation("/bar")
      expect(element.find("li:nth-child(1)").hasClass("active")).to.be.false
      expect(element.find("li:nth-child(2)").hasClass("active")).to.be.false
      expect(element.find("li:nth-child(3)").hasClass("active")).to.be.true
