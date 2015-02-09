require 'rails_helper'

describe CommentsController do
  describe '#destroy' do
    let(:user) { create(:user, :admin) }
    let(:comment) { create(:comment) }
    let(:request) { delete :destroy, id: comment.id }

    before(:each) { allow(controller).to receive(:current_user).and_return(user) }

    it 'destroys the given comment' do
      request

      expect(Comment.exists?(comment.id)).to eq(false)
    end

    context 'the given comment has replies' do
      let!(:reply) do
        create(:comment, user: comment.user, book: comment.book, parent_id: comment.id)
      end

      it 'destroys all replies' do
        request

        expect(Comment.exists?(reply.id)).to eq(false)
      end
    end
  end
end
