# Run shell commands

module.exports = (grunt) ->

  options:
    stdout: true

  startServer:
    command: "./script/start-server.sh"

  testServer:
    command: "mocha --compilers coffee:coffee-script --watch --reporter spec server/test"

  testCi:
    command: "./script/test-ci.sh"
