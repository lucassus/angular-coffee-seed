angular = require("./lib/angular")
require("./services")

controllers = angular.module("myApp.controllers", ["myApp.services"])
controllers.controller("MainCtrl", require("./controllers/main_ctrl"))
controllers.controller("OtherCtrl", require("./controllers/other_ctrl"))
