class UsersController < ApplicationController
  before_filter :authenticate_user!

  before_filter :ensure_manage_users_access

  def user_params
    user_params = params["user"]

    if user_params[:password].blank?
      user_params.delete("password")
    end

    user_params
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
end
