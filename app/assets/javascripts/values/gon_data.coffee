gonData = ($window) -> $window.gon
gonData.$inject = ['$window']
angular.module('rightBooks').factory('gonData', gonData)
