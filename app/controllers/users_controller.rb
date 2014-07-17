class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    @roles = User.roles
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params[:user][:role] = params[:user][:role].to_i
    params.require(:user).permit(:name, :title, :role, :phonenumber)
  end
end
