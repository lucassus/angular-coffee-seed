navigation = angular.module("myApp.navigation", [])

navigation.directive "navLinks", ->
  restrict: "A"

  link: ($scope, element) ->
    $scope.$on "pathChanged", (event, path) ->
      $items = element.find("li")
      $items.removeClass("active")

      $items.each (index, link) ->
        $item = $(link)
        $item.addClass("active") if $item.find("a").attr("href").match "#{path}$"

  controller: ($scope, $location) ->
    $scope.$on "$locationChangeSuccess", ->
      $scope.$emit "pathChanged", $location.path()
