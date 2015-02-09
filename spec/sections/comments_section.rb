class CommentsSection < SitePrism::Section
  sections :comments, CommentSection, 'li.comment'

  element :comment_field, 'form[name="new-comment-form"] textarea'
  element :comment_submit_button, 'form[name="new-comment-form"] input[type="submit"]'
  element :sign_in_link, 'a[href*="sign_in"]'

  def find_comment(comment)
    comments.find { |comment_section| comment_section.matches_body?(comment.body) }
  end
end
