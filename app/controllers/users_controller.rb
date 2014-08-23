class UsersController < ApplicationController
  before_filter :load_roles, only: [:new, :edit]
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @user.save
      redirect_to users_path
    else
      load_roles
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      load_roles
      render 'edit'
    end
  end

  def destroy
    @user.destroy

    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :title, :role, :phonenumber, :password, :password_confirmation, :profile_image)
  end

  def load_roles
    @roles = User.roles
  end
end
