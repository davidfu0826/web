class UsersController < ApplicationController
  before_filter :load_resources, only: [:new, :edit]
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @user.save
      redirect_to users_path
    else
      load_resources
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      load_resources
      render 'edit'
    end
  end

  def new_password_email
    @user.send_reset_password_instructions
    redirect_to users_path, notice: t('.reset_sent', user: @user.name)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :title, :role, :locale, :phonenumber, :password, :password_confirmation, :profile_image)
  end

  def load_resources
    @roles = User.roles
    @locales = User.locales
  end
end
