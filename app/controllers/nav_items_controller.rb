class NavItemsController < ApplicationController

  def index
    @nav_items = NavItem.orphans
    @orphan_pages = Page.orphans
  end

  def new
    @nav_item = NavItem.new
    @nav_items = NavItem.all
    @pages = Page.all
    @parent = NavItem.find(params[:parent]) if params[:parent]
  end

  def create
    @nav_item = NavItem.new(nav_item_params)
    if @nav_item.save
      redirect_to nav_items_path
    else
      @parent = NavItem.find(nav_item_params[:parent_id]) if nav_item_params[:parent_id]
      @pages = Page.all
      render 'new'
    end
  end

  def edit
  end

  def destroy
    nav_item = NavItem.find(params[:id])
    nav_item.destroy

    redirect_to nav_items_path
  end

  def move_higher
    @nav_item = NavItem.find(params[:nav_item_id])
    @nav_item.move_higher
    redirect_to pages_path
  end

  def move_lower
    @nav_item = NavItem.find(params[:nav_item_id])
    @nav_item.move_lower
    redirect_to pages_path
  end

  private

  def nav_item_params
    params.require(:nav_item).permit(:page_id, :title, :parent_id, :children)
  end
end
