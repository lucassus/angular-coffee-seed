define -> class

  @$inject = ["$scope"]
  constructor: ($scope) ->
    $scope.products = [
      { name: "HTC Wildfire" }
      { name: "iPone" }
      { name: "Nexus 7" }
      { name: "Samsung Galaxy Note" }
      { name: "Samsung S4" }
    ]
