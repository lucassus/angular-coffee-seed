class MainCtrl

  constructor: ->
    @products = [
      { name: "HTC Wildfire" }
      { name: "iPhone" }
      { name: "Nexus One" }
      { name: "Nexus 7" }
      { name: "Samsung Galaxy Note" }
      { name: "Samsung S4" }
    ]

angular.module("myApp")
  .controller("MainCtrl", MainCtrl)
