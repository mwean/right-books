newBookSearch = ngInject ($http, $window) ->
  restrict: 'E'
  templateUrl: 'new_book_search.html'
  scope:
    searchUrl: '@'
    newBookUrl: '@'

  link: (scope) ->
    scope.query = ''
    scope.results = []

    runSearch = (val) ->
      scope.loading = true
      request = $http.get(scope.searchUrl, { params: { q: val } })
      request.success((data) -> scope.results = data)
      request.finally(-> scope.loading = false)

    search = _.debounce(runSearch, 300, { trailing: true })

    scope.$watch 'query', (newVal, oldVal) ->
      return unless newVal.length && newVal != oldVal
      search(newVal)

    scope.addBook = (book) ->
      $window.location = "#{scope.newBookUrl}?isbn=#{book.isbn}"

angular.module('rightBooks').directive('newBookSearch', newBookSearch)
