# Run shell commands

module.exports = (grunt) ->

  options:
    stdout: true

  startServer:
    command: "./script/start-server"

  testServer:
    command: "mocha --compilers coffee:coffee-script --watch --reporter spec server/test"
