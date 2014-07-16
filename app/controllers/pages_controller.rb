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

  def update
    @page = Page.find_by_slug(params[:id])

    if @page.update(page_params)
      redirect_to root_path
    else
      render 'edit'
    end
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
