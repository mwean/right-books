adminIndexCtrl = ($scope, gonData) ->
  $scope.showModal = false
  $scope.toggleModal = -> $scope.showModal = !$scope.showModal
  $scope.books = gonData.books

adminIndexCtrl.$inject = ['$scope', 'gonData']
angular.module('rightBooks').controller('adminIndexCtrl', adminIndexCtrl)
