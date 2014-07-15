class NavItemsController < ApplicationController

  def new
    @nav_item = NavItem.new
    @nav_items = NavItem.all
    @pages = Page.all
  end

  def create
    @nav_item = NavItem.new(nav_item_params)

    if @nav_item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  private

  def nav_item_params
    params.require(:nav_item).permit(:page_id, :title, :parent_id, :children)
  end
end
