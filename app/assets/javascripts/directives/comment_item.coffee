commentItem = ngInject (gonData, $compile, $http, csrfToken, Comment, $window) ->
  restrict: 'E'
  templateUrl: 'comment_item.html'
  replace: true
  require: '^commentList'
  scope:
    comment: '=rbComment'

  link: (scope, element, attrs, listCtrl) ->
    scope.isAdmin = gonData.isAdmin
    scope.replyExpanded = false
    scope.newComment = {}
    sublistStr = "<comment-list rb-comments='comment.children'></comment-list>"
    destroyUrl = "#{gonData.commentsUrl}/#{scope.comment.id}"

    $compile(sublistStr) scope, (cloned, scope) ->
      element.append(cloned)

    scope.showReplyButton = ->
      !scope.comment.reply && !scope.replyExpanded && gonData.signedIn

    scope.toggleExpanded = ->
      scope.replyExpanded = !scope.replyExpanded

    scope.delete = ->
      if $window.confirm('Are you sure you want to delete this comment?')
        request = $http
          method: 'DELETE'
          url: destroyUrl
          data: { authenticity_token: csrfToken }
          headers: { 'Content-Type': 'application/json;charset=utf-8' }

        request.success(-> listCtrl.removeComment(scope.comment))

    scope.addComment = ->
      request = $http.post gonData.newCommentUrl,
        body: scope.newComment.body
        parent_id: scope.comment.id
        authenticity_token: csrfToken

      request.success (data) ->
        scope.comment.children.push(new Comment(data))
        scope.newComment = {}
        scope.replyExpanded = false

angular.module('rightBooks').directive('commentItem', commentItem)
