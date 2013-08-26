# generate jasmine html runner
# run `grunt server` and open http://localhost:9000/jasmine.html
module.exports = (grunt) ->

  options:
    dest: "<%= appConfig.dev %>"
