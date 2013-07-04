express = require("express")
path = require("path")

app = express()

app.use express.logger()
app.use express.static(path.join(__dirname, "dist"))

port = process.env.PORT or 5000
app.listen port, ->
    console.log "listening on port " + port
