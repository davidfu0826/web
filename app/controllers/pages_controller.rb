class PagesController < ApplicationController
  load_resource find_by: :slug
  authorize_resource

  #TODO Authorize stuff
  def index
    @orphan_pages = Page.orphans
    @nav_items = NavItem.orphans.order("position ASC")
  end

  def show
  end

  def new
    @create_nav = params[:create_nav] if params[:create_nav].present?
    @parent     = params[:parent]     if params[:parent].present?
  end

  #TODO Authorize NavItem
  def create
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
    @exists = true
  end

  def update
    if @page.update(page_params)
      redirect_to @page
    else
      @exists = true
      render 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path
  end

  #TODO Authorize User
  def add_user
    @users = User.all
  end

  #TODO Authorize User
  def add_user_update
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
    params.require(:page).permit(:title, :content, :title_sv, :content_sv, :title_en, :content_en, :slug)
  end
end
