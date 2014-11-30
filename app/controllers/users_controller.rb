class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def email
    valid = User.find_by(email: params[:email]) ? true : 'is invalid'

    render json: { email: valid }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
