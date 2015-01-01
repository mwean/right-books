expandableSection = ->
  restrict: 'E'
  templateUrl: 'expandable_section.html'
  transclude: true
  replace: true

  link: (scope, element) ->
    originalHeight = element.height()
    expandedHeight = element[0].scrollHeight
    scope.expanded = false

    scope.toggle = ->
      newHeight = if scope.expanded then '' else expandedHeight
      element.css({ maxHeight: newHeight })
      scope.expanded = !scope.expanded

angular.module('rightBooks').directive('expandableSection', expandableSection)
