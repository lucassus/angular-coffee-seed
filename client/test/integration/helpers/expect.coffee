# Use the external Chai As Promised to deal with resolving promises in expectations
chai = require("chai")
chaiAsPromised = require("chai-as-promised")
chai.use(chaiAsPromised)

module.exports = chai.expect
