angular = require("./lib/angular")

controllers = angular.module("myApp.controllers", [])

require("./controllers/main_ctrl")(controllers)
require("./controllers/other_ctrl")(controllers)
