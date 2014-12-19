autoFocus = ->
  restrict: 'A'

  link: (scope, element, attrs) ->
    scope.$watch attrs.autoFocus, (shouldFocus) ->
      element[0].focus() if shouldFocus

angular.module('rightBooks').directive('autoFocus', autoFocus)
