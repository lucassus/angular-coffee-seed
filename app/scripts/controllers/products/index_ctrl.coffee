app = angular.module("myApp")

class IndexCtrl extends BaseCtrl

  @register app, "products.IndexCtrl"
  @inject "$scope", "alerts", "Products"

  initialize: ->
    @totalServerItems = 0

    fetchProducts = (pagingOptions = {}) ->
      options = _.pick(pagingOptions, "currentPage", "pageSize")
      promise = @Products.query(options).$promise

      promise.then (data) ->
        @products = data.rows
        @totalServerItems = data.total

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
      pagingOptions: @pagingOptions
      showFooter: true

    watchPaging = (pagingOptions, oldVal) ->
      return if pagingOptions is oldVal
      fetchProducts(pagingOptions)

    @$scope.$watch "pagingOptions", watchPaging, true

    fetchProducts(currentPage: 1, pageSize: 2)

  deleteProduct: (product) ->
    promise = product.$delete()
    promise.then =>
      index = @products.indexOf(product)
      @products.splice(index, 1) if index isnt -1

      @alerts.info "Product was deleted"
