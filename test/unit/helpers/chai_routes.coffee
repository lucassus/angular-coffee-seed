# Custom chai matchers for ngRoute

Assertion = chai.Assertion

Assertion.addMethod "templateUrl", (url) ->
  subject = @_obj

  actualTemplateUrl = subject.templateUrl
  @assert actualTemplateUrl is url,
    "expected #\{this} to have templateUrl #\{exp} but it was #\{act}",
    "expected #\{this} to have templateUrl #\{exp}",
    url,
    actualTemplateUrl

Assertion.addMethod "controller", (ctrl) ->
  subject = @_obj

  actualController = subject.controller
  @assert actualController is ctrl,
    "expected #\{this} to have controller #\{exp} but it was #\{act}",
    "expected #\{this} to have controller #\{exp}",
    ctrl,
    actualController

Assertion.addMethod "resolve", (name) ->
  subject = @_obj
  new Assertion(subject.resolve[name]).to.not.be.undefined
