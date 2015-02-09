class CommentSection < SitePrism::Section
  sections :replies, CommentSection, 'li.comment'

  element :reply_link, 'a', text: 'Reply'
  element :reply_field, 'textarea'
  element :reply_submit_button, 'input[type="submit"]'
  element :body, '.comment__body'
  element :delete_button, '.comment__delete-btn'

  def matches_body?(match_text)
    body.text == match_text
  end
end
