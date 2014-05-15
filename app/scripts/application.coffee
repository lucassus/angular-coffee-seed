# The entry point for the application

app = angular.module "myApp", [
  "ngAnimate"
  "ngMessages"
  "ui.router"
  "pasvaz.bindonce"

  "myApp.templates"
  "myApp.alerts"
  "myApp.resources"
]

app.directive "mySubmit", [
  "$parse", "$log", ($parse, $log) ->

    require: "form"

    compile: (element, attrs) ->
      onSubmit = $parse(attrs.mySubmit)

      (scope, element, attrs, formCtrl) ->

        element.on "submit", (event) ->
          $log.info "Submitting the form", formCtrl

          scope.$apply ->
            onSubmit(scope, $event: event) if formCtrl.$valid
            formCtrl.$submitted = true

]

app.directive "myMessages", [
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

app.directive "myErrorFor", [
  ->

    restrict: "A"
    scope: true
    replace: true
    transclude: true
    require: "^form"

    link: (scope, element, attrs, formCtrl) ->
      field = formCtrl[attrs.myErrorFor]

      scope.hasError = -> field.$invalid and (formCtrl.$submitted or field.$dirty)

    template: """
      <div ng-class="{'has-error': hasError()}"
           ng-transclude></div>
    """

]

app.config [

  "$provide", ($provide) ->
    $provide.value("alertTimeout", 3000)

    # workarounds e2e scenarios
    e2eScenarioRunner = window.location.port is "9001"
    if e2eScenarioRunner
      # disable timeouts, see https://github.com/angular/angular.js/issues/2402
      $provide.value("alertTimeout", null)

]
