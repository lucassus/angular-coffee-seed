angular = require("./lib/angular")

alerts = angular.module("myApp.alerts", [])
require("./modules/alerts")(alerts)
