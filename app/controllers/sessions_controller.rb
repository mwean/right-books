class SessionsController < ApplicationController
  def new
    session[:return_to_url] = request.referrer
  end

  def create
    if login(params[:email], params[:password], params[:remember_me])
      redirect_back_or_to root_path
    else
      handle_failed_login
    end
  end

  def destroy
    logout

    redirect_to root_path
  end

  private

  def handle_failed_login
    if user_locked?
      flash[:alert] = 'Too many failed sign in attempts. Try again in 5 minutes.'

      redirect_to root_path
    else
      @email = params[:email]
      @remember_me = params[:remember_me]
      gon.push(email: @email)

      render 'new'
    end
  end

  def user_locked?
    user = User.sorcery_adapter.find_by_credentials([params[:email]])
    user && user.locked?
  end
end
