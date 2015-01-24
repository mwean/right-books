userNav = ->
  restrict: 'E'
  templateUrl: 'user_nav.html'
  replace: true

  scope:
    userName: '@userName'
    signOutPath: '@signOutPath'

  link: (scope, element) ->
    scope.expanded = false
    scope.toggle = -> scope.expanded = !scope.expanded

angular.module('rightBooks').directive('userNav', userNav)
