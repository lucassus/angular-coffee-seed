class ShowActionsCtrl

  @$inject = ["$scope", "$state", "$window", "alerts"]
  constructor: (@$scope, @$state, @$window, @alerts) ->

  deleteProduct: ->
    return unless @$window.confirm("Are you sure?")

    promise = @$scope.product.$delete()
    promise.then =>
      @alerts.info "Product was deleted"
      @$state.go "products.list"

angular.module("myApp")
  .controller("products.ShowActionsCtrl", ShowActionsCtrl)
