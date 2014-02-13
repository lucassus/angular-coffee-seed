app = angular.module("myApp")

class IndexCtrl extends BaseCtrl

  @register app, "products.IndexCtrl"
  @inject "alerts", "products"

  initialize: ->

    gridColumnDefs = [
      { field: "id", displayName: "#", width: "auto" }
      { field: "name", displayName: "Name", resizable: true }
      { field: "price", displayName: "Price", width: "120px", resizable: false }
      { field: "description", displayName: "Description" }
      { field: "createdAt", displayName: "Created At" }
    ]

    @gridOptions =
      data: "products"
      columnDefs: "gridColumnDefs"
      enableColumnResize: true
