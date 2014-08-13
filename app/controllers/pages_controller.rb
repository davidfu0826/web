class PagesController < ApplicationController
  before_action :load_images_and_tags, only: [:new, :edit]
  load_resource find_by: :slug
  authorize_resource

  #TODO Authorize stuff
  def index
    @orphan_pages = Page.orphans
    @nav_items = NavItem.orphans.order("position ASC")
  end

  def show
    @contact_forms = @page.contact_forms
  end

  def new
    @create_nav = params[:create_nav] if params[:create_nav].present?
    @parent     = params[:parent]     if params[:parent].present?
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
          @create_nav = nav_params[:create_nav] if nav_params[:create_nav].present?
          @parent     = nav_params[:parent]     if nav_params[:parent].present?
          load_images_and_tags
          render 'new'
        end
      else
        redirect_to @page
      end
    else
      @create_nav = nav_params[:create_nav] if nav_params[:create_nav].present?
      @parent     = nav_params[:parent]     if nav_params[:parent].present?
      load_images_and_tags
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
      load_images
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
      render 'add_user'
    end
  end

  private

  def page_params
    params.require(:page).permit(:title_sv, :content_sv, :title_en, :content_en)
  end

  def nav_params
    params.require(:page).permit(:create_nav, :parent)
  end

  def load_images_and_tags
    @images = Image.all
    @tags = Tag.all
  end
end
