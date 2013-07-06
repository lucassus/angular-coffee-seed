grunt = require("grunt")
path = require("path")

loadKarmaFiles = ->
  files = []
  config = set: (config) -> files = config.files
  require("./test/karma.conf.coffee")(config)
  files

files = loadKarmaFiles()
for file in files
  console.log grunt.file.expand(path.join("dev", file))
