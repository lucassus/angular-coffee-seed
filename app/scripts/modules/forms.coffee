forms = angular.module("myApp.forms", ["ngMessages"])

# TODO write specs for this module

forms.directive "mySubmit", [
  "$parse", "$log", ($parse, $log) ->

    require: "form"

    compile: (element, attrs) ->
      onSubmit = $parse(attrs.mySubmit)

      (scope, element, attrs, formCtrl) ->

        element.on "submit", (event) ->
          $log.debug "Submitting form '#{formCtrl.$name}'", formCtrl

          scope.$apply ->
            onSubmit(scope, $event: event) if formCtrl.$valid
            formCtrl.$submitted = true

]

forms.directive "myMessages", [
  ->

    scope: true
    replace: true
    transclude: true
    require: "^form"

    link: (scope, element, attrs, formCtrl) ->
      field = formCtrl[attrs.myMessages]

      scope.showMessages = -> formCtrl.$submitted or field.$dirty
      scope.messages     = -> field.$error

    template: """
      <div ng-show="showMessages()"
           ng-messages="messages()"
           ng-transclude></div>
    """
]

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
