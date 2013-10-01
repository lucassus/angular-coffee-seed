app = require("./lib/app")

port = process.env.PORT or 5000
app.listen port, ->
  console.log "listening on port " + port
