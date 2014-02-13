app = angular.module("myApp")

class IndexCtrl extends BaseCtrl

  @register app, "products.IndexCtrl"
  @inject "$scope", "alerts", "Products"

  initialize: ->
    @totalServerItems = 0

    fetchProducts = ->
      params = _.pick($scope.pagingOptions, "currentPage", "pageSize")
      params.sortField = $scope.sortInfo.fields[0]
      params.sortDirection = $scope.sortInfo.directions[0]

      promise = Products.query(params).$promise
      promise.then (data) ->
        $scope.products = data.rows
        $scope.totalServerItems = data.total

    @$scope.pagingOptions =
      pageSizes: [2, 3, 5]
      currentPage: 1
      pageSize: 2

    @$scope.sortInfo =
      fields: ["id"]
      directions: ["asc"]

    $scope.gridColumnDefs = [
      { field: "id",          displayName: "#", width: "auto" }
      { field: "name",        displayName: "Name", resizable: true }
      { field: "price",       displayName: "Price", width: "120px", resizable: false }
      { field: "description", displayName: "Description" }
      { field: "createdAt",   displayName: "Created At" }
    ]

    @pagingOptions =
      pageSizes: [2, 3, 5]
      pageSize: 2
      currentPage: 1

    @gridOptions =
      data: "products"
      columnDefs: $scope.gridColumnDefs
      totalServerItems: "totalServerItems"
      enableColumnResize: true
      enablePaging: true
      pagingOptions: @$scope.pagingOptions
      sortInfo: @$scope.sortInfo
      useExternalSorting: true
      showFooter: true
      primaryKey: "id"
      multiSelect: true
      selectedItems: $scope.selectedProducts

    loadGrid = (newVal, oldVal) ->
      fetchProducts() unless angular.equals(newVal, oldVal)

    $scope.$watch "pagingOptions.currentPage", loadGrid, true
    $scope.$watch "pagingOptions.pageSize", loadGrid, true
    $scope.$watch "sortInfo.fields", loadGrid, true
    $scope.$watch "sortInfo.directions", loadGrid, true

    fetchProducts()

  clearSelection: ->
    @$scope.selectedProducts.splice(0, @$scope.selectedProducts.length)

  deleteProduct: (product) ->
    promise = product.$delete()
    promise.then =>
      index = @products.indexOf(product)
      @products.splice(index, 1) if index isnt -1

      @alerts.info "Product was deleted"
