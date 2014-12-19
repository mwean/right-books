commentItem = (gonData, $compile, $http, csrfToken, Comment) ->
  restrict: 'E'
  templateUrl: 'comment_item.html'
  replace: true
  scope:
    comment: '=rbComment'

  link: (scope, element) ->
    scope.replyExpanded = false
    scope.newComment = {}
    sublistStr = "<comment-list rb-comments='comment.children'></comment-list>"

    $compile(sublistStr) scope, (cloned, scope) ->
      element.append(cloned)

    scope.showReplyButton = ->
      !scope.replyExpanded && gonData.signedIn

    scope.toggleExpanded = ->
      scope.replyExpanded = !scope.replyExpanded

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
