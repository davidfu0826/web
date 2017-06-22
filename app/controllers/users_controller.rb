class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.order(role: :asc, email: :desc)
  end

  def new
    @roles = User.roles
  end

  def create
    if @user.save
      @user.send_password_selection_email
      redirect_to(users_path, notice: t('.success'))
    else
      @roles = User.roles
      render(:new, status: 422)
    end
  end

  def edit
    @roles = User.roles
  end

  def update
    if @user.update(user_params)
      redirect_to(edit_user_path(@user), notice: t('.success'))
    else
      @roles = User.roles
      render(:edit, status: 422)
    end
  end

  def destroy
    @user.destroy!

    redirect_to(users_path, notice: t('.success'))
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :title,
                                 :role, :phonenumber,
                                 :password, :password_confirmation,
                                 :avatar, :remove_avatar)
  end
end
