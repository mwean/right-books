commentListCtrl = ngInject ($scope) ->
  @removeComment = (comment) -> _.pull($scope.comments, comment)

commentList = ngInject ($http, gonData, csrfToken, Comment) ->
  restrict: 'E'
  templateUrl: 'comment_list.html'
  replace: true
  scope:
    commentData: '=rbComments'

  controller: commentListCtrl

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

angular.module('rightBooks').directive('commentList', commentList)
