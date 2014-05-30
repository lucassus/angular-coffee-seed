# Custom chai matchers for SinonJS

Assertion = chai.Assertion

# Pass if the spy was called at least once
Assertion.addProperty "called", ->
  subject = @_obj

  @assert subject.called,
    "expected #{angular.mock.dump(subject)} to have been called",
    "expected #{angular.mock.dump(subject)} to not have been called"

# Pass if the spy was called at least once with the provided arguments
Assertion.addMethod "calledWith", (args...) ->
  subject = @_obj

  new Assertion(subject).to.be.called

  @assert subject.calledWith.apply(subject, args),
    "expected #{angular.mock.dump(subject)} to have been called with #\{exp} but it was called with #\{act}",
    "expected #{angular.mock.dump(subject)} to not have been called with #\{exp}",
    args,
    subject.lastCall.args
