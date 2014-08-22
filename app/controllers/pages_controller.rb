class PagesController < ApplicationController
  before_action :load_resources, only: [:new, :edit, :change_cover]
  load_resource find_by: :slug
  authorize_resource

  #TODO Authorize stuff
  def index
    @orphan_pages = Page.orphans
    @nav_items = NavItem.orphans.order("position ASC").includes(:page, children: [:page])
  end

  def show
    @contact_forms = @page.contact_forms.includes(:pages, :users)
    if @page.try(:nav_item).try(:parent)
      @sidebar_nav_items = @page.nav_item.parent.children.includes(:page)
    end
  end

  def new
  end

  def create
    if @page.save
      if nav_params[:create_nav]
        if nav_params[:parent]
          @parent = NavItem.find(nav_params[:parent])
          @nav_item = NavItem.new(page: @page, parent: @parent)
        else
          @nav_item = NavItem.new(page: @page)
        end

        if @nav_item.save
          redirect_to @page
        else
          load_resources
          render 'new'
        end
      else
        redirect_to @page
      end
    else
      load_resources
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
      load_resources
      @exists = true
      render 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path
  end

  def add_user
    @users = User.all
  end

  def add_user_update
    @user = User.find(params[:user_id])
    @page.contacts << @user

    if @page.save
      redirect_to @page
    else
      @users = User.all
      render 'add_user'
    end
  end

  def change_cover
    @page = @pages.find_by(slug: params[:page_id])
    authorize! :edit, @page
    @image = @page.image
  end

  def delete_cover
    @page = @pages.find_by(slug: params[:page_id])
    authorize! :edit, @page
    @page.image = nil
    @page.save
    redirect_to @page
  end


  private

  def page_params
    params.require(:page).permit(:title_sv, :content_sv, :title_en, :content_en, :image_id)
  end

  def nav_params
    params.require(:page).permit(:create_nav, :parent)
  end

  def load_resources
    @create_nav = params[:create_nav] if params[:create_nav].present?
    @parent     = params[:parent]     if params[:parent].present?
    @images = Image.all
    @tags = Tag.all
  end
end
