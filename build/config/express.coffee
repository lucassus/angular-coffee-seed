module.exports = (grunt) ->

  # Override defaults here
  options:
    node_env: "development"
    port: 5000
    background: true
    opts: ["./node_modules/coffee-script/bin/coffee"]

  dev:
    options:
      script: "./server/index.coffee"
