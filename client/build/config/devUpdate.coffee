module.exports = (grunt) ->

  main:
    options:
      updateType: "report"
      reportUpdated: false
      semver: true
      packages:
        devDependencies: true
        dependencies: true
