commentList = ($http, gonData, csrfToken, Comment) ->
  restrict: 'E'
  templateUrl: 'comment_list.html'
  replace: true
  scope:
    commentData: '=rbComments'

  link: (scope, element, attrs) ->
    scope.newComment = {}
    scope.comments = scope.commentData

    scope.addComment = ->
      request = $http.post gonData.newCommentUrl,
        body: scope.newComment.body
        authenticity_token: csrfToken

      request.success (data) ->
        scope.comments.push(new Comment(data))
        scope.newComment = {}

commentList.$inject = ['$http', 'gonData', 'csrfToken', 'Comment']
angular.module('rightBooks').directive('commentList', commentList)
