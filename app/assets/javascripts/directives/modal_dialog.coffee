modalDialog = ->
  restrict: 'E'
  replace: true
  transclude: true
  templateUrl: 'modal_dialog.html'
  scope:
    showDialog: '='

  link: (scope) ->
    scope.hideModal = -> scope.showDialog = false

angular.module('rightBooks').directive('modalDialog', modalDialog)
