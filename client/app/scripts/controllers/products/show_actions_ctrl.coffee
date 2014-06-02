app = angular.module("myApp")

class ShowActionsCtrl extends BaseCtrl

  @register app, "products.ShowActionsCtrl"
  @inject "$scope", "$state", "$window", "alerts"

  deleteProduct: ->
    return unless @$window.confirm("Are you sure?")

    promise = @$scope.product.$delete()
    promise.then =>
      @alerts.info "Product was deleted"
      @$state.go "products.list"
