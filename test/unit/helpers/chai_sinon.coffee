# Custom chai matchers for SinonJS

# Pass if the spy was called at least once
chai.Assertion.addProperty "haveBeenCalled", ->
  subject = @_obj

  @assert subject.called,
    "expected #{angular.mock.dump(subject)} to have been called",
    "expected #{angular.mock.dump(subject)} to not have been called"

# Pass if the spy was called at least once with the provided arguments
chai.Assertion.addMethod "haveBeenCalledWith", (args...) ->
  subject = @_obj

  new chai.Assertion(subject).to.haveBeenCalled

  @assert subject.calledWith.apply(subject, args),
    "expected #{angular.mock.dump(subject)} to have been called with #\{exp} but it was called with #\{act}",
    "expected #{angular.mock.dump(subject)} to not have been called with #\{exp}",
    args,
    subject.lastCall.args
