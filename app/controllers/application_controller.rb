class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_config

  private

  def set_config
    gon.push(signed_in: current_user.present?)
  end
end
