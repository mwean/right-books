require 'rails_helper'

describe Admin::BooksController do
  let(:amazon_result) { AmazonResult.new.load(FakeRedisData.amazon_result) }

  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
    allow(AmazonResult).to receive(:load).and_return(amazon_result)
  end

  shared_examples_for 'only admins allowed' do |action|
    before(:each) { get action }

    context 'user is an admin' do
      let(:user) { create(:user, :admin) }

      it "renders the #{action} page" do
        expect(response).to render_template(action)
      end
    end

    context 'user is not an admin' do
      let(:user) { create(:user) }

      it 'redirects to the home page' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'user is not logged in' do
      let(:user) { nil }

      it 'redirects to the sign in page' do
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  it_behaves_like 'only admins allowed', :index
  it_behaves_like 'only admins allowed', :new

  describe 'search' do
    before(:each) { get :search }

    context 'user is not an admin' do
      let(:user) { create(:user) }

      it 'redirects to the home page' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'user is not logged in' do
      let(:user) { nil }

      it 'redirects to the sign in page' do
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
