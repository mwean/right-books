sortableGrid = ngInject (gonData, $http, csrfToken) ->
  restrict: 'E'
  templateUrl: 'sortable_grid.html'

  scope:
    books: '='

  link: (scope, element) ->
    scope.sortable = gonData.sortable
    scope.sortPath = gonData.sortPath
    scope.categoryId = gonData.categoryId

    scope.sortableOptions =
      disabled: !scope.sortable
      'ui-floating': true

      stop: ->
        $http.put scope.sortPath,
          category_id: scope.categoryId
          book_ids: _.pluck(scope.books, 'id')
          authenticity_token: csrfToken

angular.module('rightBooks').directive('sortableGrid', sortableGrid)
