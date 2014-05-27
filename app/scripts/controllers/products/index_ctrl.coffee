app = angular.module("myApp")

class IndexCtrl extends BaseCtrl

  @register app, "products.IndexCtrl"
  @inject "$location", "alerts", "ngTableParams", "Products"

  initialize: ->
    defaultSorting = { price: "asc" }

    parameters = angular.extend({
      page: 1     # show the first page
      count: 10   # 10 rows per page

      # initialize sorting
      sorting: defaultSorting
    }, @$location.search())

    settings = {
      total: 0
      getData: ($defer, params) =>
        # put params in the url
        @$location.search(params.url())

        rawParams = params.url()
        sorting = _.chain(rawParams)
          .pick((value, key) -> key.match /^sorting/)
          .map((value, key) -> obj = {}; key = key.match(/^sorting\[(.+)\]/)[1]; obj[key] = value; obj)
          .value()[0] || defaultSorting

        field = _.keys(sorting)[0]
        direction = sorting[field]

        queryParams =
          currentPage:   rawParams.page
          pageSize:      rawParams.count
          sortField:     field
          sortDirection: direction

        promise = @Products.query(queryParams).$promise

        promise.then (data) ->
          # update table params
          params.total(data.total)

          # set new data
          $defer.resolve(data.rows)
    }

    @tableParams = new @ngTableParams(parameters, settings)
