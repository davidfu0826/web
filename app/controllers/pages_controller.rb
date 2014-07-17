class PagesController < ApplicationController
  load_resource find_by: :slug
  authorize_resource

  def index
    @orphan_pages = Page.orphans
    @nav_items = NavItem.orphans.order("position ASC")
  end

  def show
  end

  def new
    @create_nav = params[:create_nav] if params[:create_nav].present?
    @parent = params[:parent] if params[:parent].present?
  end

  def create
    @page = Page.new(page_params)

    if params[:page][:create_nav]
      if params[:page][:parent]
        @parent = NavItem.find(params[:page][:parent])
        @nav_item = NavItem.new(page: @page, parent: @parent)
      else
        @nav_item = NavItem.new(page: @page)
      end
      unless @nav_item.save
        render 'new'
      end
    end

    if @page.save
      redirect_to @page
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @page = Page.find_by_slug(params[:id])

    if @page.update(page_params)
      redirect_to @page
    else
      render 'edit'
    end
  end

  def destroy
    page = Page.find_by_slug(params[:id])
    page.destroy

    redirect_to pages_path
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
