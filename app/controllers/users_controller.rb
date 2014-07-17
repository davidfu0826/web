class UsersController < ApplicationController
  before_filter :load_roles, only: :edit
  load_and_authorize_resource

  def index
  end

  def edit
  end

  def update
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

  def load_roles
    @roles = User.roles
  end
end
