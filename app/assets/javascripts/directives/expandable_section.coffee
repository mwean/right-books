expandableSection = ->
  restrict: 'E'
  templateUrl: 'expandable_section.html'
  transclude: true
  replace: true

  link: (scope, element) ->
    scope.expanded = false
    scope.toggle = -> scope.expanded = !scope.expanded

angular.module('rightBooks').directive('expandableSection', expandableSection)
