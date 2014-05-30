path = require("path")

module.exports = (grunt) ->

  options:
    port: 5000
    server: path.resolve(__dirname, "../../server/lib/app")

  # Override defaults here
  default_option: {}
