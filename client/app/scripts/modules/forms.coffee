forms = angular.module("myApp.forms", ["ngMessages"])

# Custom submit directive
# * calls the given expression only when the form is valid
# * marks the current form as submitted
forms.directive "mySubmit", [
  "$parse", "$log", ($parse, $log) ->

    require: "form"

    compile: (element, attrs) ->
      onSubmit = $parse(attrs.mySubmit)

      (scope, element, attrs, formCtrl) ->

        element.on "submit", (event) ->
          $log.debug "Submitting the form '#{formCtrl.$name}'", formCtrl

          scope.$apply ->
            onSubmit(scope, $event: event) if formCtrl.$valid
            formCtrl.$submitted = true

]

# Wrapper for `ngMessages` directive
forms.directive "myMessages", [
  ->

    scope: true
    replace: true
    transclude: true
    require: "^form"

    link: (scope, element, attrs, formCtrl) ->
      field = formCtrl[attrs.myMessages]

      scope.touched  = -> formCtrl.$submitted or field.$dirty
      scope.messages = -> field.$error

    template: """
      <div ng-show="touched()"
           ng-messages="messages()"
           ng-transclude></div>
    """
]

# Toggles bootstrap classes (has-error, has-success)
# TODO write specs for this directive
forms.directive "myErrorFor", [
  ->

    restrict: "A"
    scope: true
    replace: true
    transclude: true
    require: "^form"

    link: (scope, element, attrs, formCtrl) ->
      field = formCtrl[attrs.myErrorFor]

      touched = -> formCtrl.$submitted or field.$dirty

      scope.hasError   = -> touched() and field.$invalid
      scope.hasSuccess = -> touched() and field.$valid

    template: """
      <div ng-class="{'has-error': hasError(), 'has-success': hasSuccess()}"
           ng-transclude></div>
    """

]
