newBookCtrl = ($scope, gonData) ->
  $scope.data = { categories: gonData.categories }

  $scope.book =
    editorNotes: gonData.editorNotes
    description: gonData.description

newBookCtrl.$inject = ['$scope', 'gonData']
angular.module('rightBooks').controller('newBookCtrl', newBookCtrl)
