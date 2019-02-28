# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
angular.module('App').controller('GoodsCtrl', ['$scope', '$mdDialog', ($scope, $mdDialog)->
  $scope.new_sales_attributes = []
  $scope.confirm_dlg = false
  $scope.delete = (id)->
    $scope.new_sales_attributes.splice($scope.new_sales_attributes.indexOf(id), 1);
  
  $scope.add = ()->
    $scope.new_sales_attributes.push($scope.new_sales_attributes.length)
  
  $scope.destroy_good = (e)->
    if not $scope.confirm_dlg
      e.preventDefault()
      e.stopPropagation()
      confirm = $mdDialog.confirm()
        .title('Deletion')
        .textContent('Would you like to delete your good?')
        .targetEvent(e)
        .ok('Yes')
        .cancel('No');
      $mdDialog.show(confirm).then(()->
        $scope.confirm_dlg = true
        e.target.dispatchEvent(e)
        ()->
          $scope.confirm_dlg = false
      ).catch((err)->
      
      )
    
    
    
])
