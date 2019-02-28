# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
angular.module('App').controller('RevenueCtrl', ['$scope', '$http', '$mdDialog',($scope, $http, $mdDialog)->
  $scope.req_data = {
    params: {
      from: '2017-03-01',
      to: '2017-03-01'
    }
  }
  $scope.refresh = ()->
    $http.get('/sales', $scope.req_data).then(
      (response)->
        $scope.table_data = response.data
        
    ,
      (response)->
        $mdDialog.show($mdDialog.alert().clickOutsideToClose(true).title('Error')
          .textContent(response.data.error)
          .ok('ОК')
        )
        
    );
  $scope.refresh()
])