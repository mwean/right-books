expandableSectionBody = ->
  restrict: 'E'
  templateUrl: 'expandable_section_body.html'
  transclude: true
  replace: true
  scope:
    expanded: '='

  link: (scope, element, attrs, ctrl) ->
    expandedHeight = element[0].scrollHeight
    scope.sectionStyle = ''

    scope.$watch 'expanded', (nowExpanded) ->
      newHeight = if nowExpanded then expandedHeight else ''
      scope.sectionStyle =  { maxHeight: newHeight }

angular.module('rightBooks').directive('expandableSectionBody', expandableSectionBody)
