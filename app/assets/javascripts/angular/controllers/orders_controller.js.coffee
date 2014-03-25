@OrdersCtrl = ($scope, $location, $http) ->
  $scope.title = "Orders"

  $scope.data = 
    orders: [{uid: 'Loading orders...', contents: ''}]

  loadOrders = ->
    $http.get('./api/orders').success( (data) ->
      $scope.orders = data
      console.log('Successfully loaded orders.')
    ).error( ->
      console.error('Failed to load orders.')
    )

  loadOrders()

  $scope.searchOrder = null
  $scope.change = (text) ->
    search_params = $scope.searchOrder
    $http.get('./api/orders?q=' + search_params).success( (data) ->
      $scope.orders = data
      console.log('Found matching order.')
      #console.log data
    ).error( ->
      console.error('No orders found.')
    )

@OrdersCtrl.$inject = ['$scope', '$location', '$http']