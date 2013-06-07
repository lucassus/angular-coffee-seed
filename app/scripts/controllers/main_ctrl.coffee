module.exports = class MainCtrl

  @$inject = ["$scope"]
  constructor: ($scope) ->
    $scope.products = [
      { name: "HTC Wildfire" }
      { name: "iPhone" }
      { name: "Nexus One" }
      { name: "Nexus 7" }
      { name: "Samsung Galaxy Note" }
      { name: "Samsung S4" }
    ]
