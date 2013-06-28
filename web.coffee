gzippo = require "gzippo"
express = require "express"

app = express()
app.use express.logger "dev"
app.use gzippo.staticGzip "#{__dirname}/dist"
app.listen process.env.PORT || 5000
