app = angular.module("myApp")

class IndexCtrl extends BaseCtrl

  @register app, "products.IndexCtrl"
  @inject "$scope", "alerts", "Products"

  initialize: ->
    @totalServerItems = 0

    fetchProducts = (pagingOptions = {}, sortInfo = {}) ->
      options = _.pick(pagingOptions, "currentPage", "pageSize")
      options.sortField = sortInfo.fields[0]
      options.sortDirection = sortInfo.directions[0]

      promise = Products.query(options).$promise
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

    gridColumnDefs = [
      { field: "id", displayName: "#", width: "auto" }
      { field: "name", displayName: "Name", resizable: true }
      { field: "price", displayName: "Price", width: "120px", resizable: false }
      { field: "description", displayName: "Description" }
      { field: "createdAt", displayName: "Created At" }
    ]

    @pagingOptions =
      pageSizes: [2, 3, 5]
      pageSize: 2
      currentPage: 1

    @gridOptions =
      data: "products"
      columnDefs: "gridColumnDefs"
      totalServerItems: "totalServerItems"
      enableColumnResize: true
      enablePaging: true
      pagingOptions: @$scope.pagingOptions
      sortInfo: @$scope.sortInfo
      useExternalSorting: true
      showFooter: true

    refresh = (newVal, oldVal) ->
      return if angular.equals(newVal, oldVal)
      fetchProducts(@$scope.pagingOptions, @$scope.sortInfo)

    @$scope.$watch "pagingOptions.currentPage", refresh, true
    @$scope.$watch "pagingOptions.pageSize", refresh, true
    @$scope.$watch "sortInfo.fields", refresh, true
    @$scope.$watch "sortInfo.directions", refresh, true

    fetchProducts(@$scope.pagingOptions, @$scope.sortInfo)

  deleteProduct: (product) ->
    promise = product.$delete()
    promise.then =>
      index = @products.indexOf(product)
      @products.splice(index, 1) if index isnt -1

      @alerts.info "Product was deleted"
