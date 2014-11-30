angular.module('rightBooks').controller 'signInCtrl', ($scope, $http, csrfToken, gonData) ->
  $scope.invalidEmail = false
  $scope.email = gonData.email
  $scope.invalidPassword = gonData.email?

  $scope.checkEmail = ->
    request = $http.get('/users/email', { params: { email: $scope.email } })

    request.success (data) ->
      if data.email == true
        $scope.invalidEmail = false
      else
        $scope.invalidEmail = true
