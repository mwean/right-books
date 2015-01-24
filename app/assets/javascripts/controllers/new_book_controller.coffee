newBookCtrl = ($scope, $element, gonData) ->
  $scope.data = { categories: gonData.categories }

  $scope.book =
    editorNotes: gonData.editorNotes
    description: gonData.description

  $scope.updateCategoryIds = (event) ->
    ids = _.pluck($scope.book.categories, 'id')
    $element.find('#book_category_ids').val(ids.join(','))

newBookCtrl.$inject = ['$scope', '$element', 'gonData']
angular.module('rightBooks').controller('newBookCtrl', newBookCtrl)
