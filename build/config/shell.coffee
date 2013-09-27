# Run shell commands

module.exports = (grunt) ->

  options:
    stdout: true

  startServer:
    command: "./script/start-server.sh"

  testCi:
    command: "./script/test-ci.sh"
