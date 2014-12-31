module Admin
  class AdminController < ApplicationController
    before_action :ensure_current_user
    before_action :ensure_admin

    private

    def ensure_current_user
      redirect_to sign_in_path unless current_user
    end

    def ensure_admin
      redirect_to root_path unless current_user.admin?
    end
  end
end
