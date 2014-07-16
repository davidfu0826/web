class PagesController < ApplicationController
  load_resource find_by: :slug
  authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def add_user
    @page = Page.find(params[:page_id])
    @users = User.all
  end

  def add_user_update
    @page = Page.find(params[:page_id])
    @user = User.find(params[:user_id])

    @page.user = @user

    if @page.save
      redirect_to @page
    else
      render 'add_user'
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :content, :slug)
  end
end
