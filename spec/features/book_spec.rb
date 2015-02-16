require 'rails_helper'

feature 'book page' do
  given!(:book) { create(:book) }
  given(:book_page) { BookPage.new }
  given(:comments_section) { book_page.comments }

  context 'user is not logged in' do
    background do
      create(:comment, book: book)
      book_page.load(slug: book.slug)
    end

    scenario 'user does not see comment buttons or inputs', :js do
      expect(comments_section.comments.first).to have_no_reply_link
      expect(comments_section).to have_no_comment_field
      expect(comments_section).to have_sign_in_link
    end
  end

  context 'user is logged in' do
    given(:user) { create(:user) }
    given(:new_comment) { build_stubbed(:comment) }
    given(:reply_comment) { build_stubbed(:comment) }

    background do
      create(:comment, book: book)
      sign_in_user(user)
      book_page.load(slug: book.slug)
    end

    scenario 'user can add a comment and reply to an existing comment', :js do
      existing_comment = comments_section.comments.first

      expect(comments_section).to have_no_sign_in_link

      comments_section.comment_field.set(new_comment.body)
      comments_section.comment_submit_button.click

      comments_section.wait_for_comments(nil, count: 2)
      expect(comments_section.comment_field.text).to be_blank
      expect(comments_section).to have_content(new_comment.body)
      expect(comments_section).to have_content(user.full_name)
      expect(existing_comment).to have_no_delete_button

      existing_comment.reply_link.click
      existing_comment.reply_field.set(reply_comment.body)
      existing_comment.reply_submit_button.click

      existing_comment.wait_until_reply_field_invisible
      reply = existing_comment.replies.first

      expect(reply).to have_content(reply_comment.body)
      expect(reply).to have_content(user.full_name)

      book_page.load(slug: book.slug)

      expect(book_page).to have_content(new_comment.body)
      expect(book_page).to have_content(reply_comment.body)
    end
  end

  context 'book has a comment already' do
    given(:user) { create(:user) }
    given(:admin_user) { create(:user, :admin) }
    given!(:comment) { create(:comment, book: book) }

    background do
      sign_in_user(admin_user)
      book_page.load(slug: book.slug)
    end

    scenario 'admin deletes a comment', :js do
      bad_comment = comments_section.find_comment(comment)
      accept_confirm { bad_comment.delete_button.click }

      expect(comments_section).not_to have_content(comment.body)
    end
  end
end
