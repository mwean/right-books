csrfToken = $('meta[name="csrf-token"]').attr('content')
angular.module('rightBooks').value('csrfToken', csrfToken)
