commentsSection = ($http, gonData, csrfToken, Comment) ->
  restrict: 'E'
  templateUrl: 'comments_section.html'

  link: (scope, element, attrs) ->
    scope.comments = _.map(gonData.comments, (data) -> new Comment(data))
    scope.newComment = {}
    scope.signedIn = gonData.signedIn

    scope.addComment = ->
      request = $http.post gonData.newCommentUrl,
        body: scope.newComment.body
        authenticity_token: csrfToken

      request.success (data) ->
        scope.comments.push(new Comment(data))
        scope.newComment = {}

angular.module('rightBooks').directive('commentsSection', commentsSection)
