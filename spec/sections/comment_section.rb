class CommentSection < SitePrism::Section
  sections :replies, CommentSection, 'li.comment'

  element :reply_link, 'a', text: 'Reply'
  element :reply_field, 'textarea'
  element :reply_submit_button, 'input[type="submit"]'
end
