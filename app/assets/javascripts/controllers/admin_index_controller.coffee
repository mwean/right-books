adminIndexCtrl = ($scope) ->
  $scope.showModal = false
  $scope.toggleModal = -> $scope.showModal = !$scope.showModal

adminIndexCtrl.$inject = ['$scope']
angular.module('rightBooks').controller('adminIndexCtrl', adminIndexCtrl)
