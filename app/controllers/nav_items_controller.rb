class NavItemsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    if @nav_item.save
      redirect_to pages_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @nav_item.update(nav_item_params)
      redirect_to pages_path
    else
      render 'edit'
    end
  end

  def update_order
    NavItem.update_order!(JSON.parse(params[:nav_item_data]))
    render js: 'location.reload();'
  end

  def destroy
    @nav_item.destroy
    redirect_to pages_path
  end

  def move_higher
    @nav_item.move_higher
    redirect_to pages_path
  end

  def move_lower
    @nav_item.move_lower
    redirect_to pages_path
  end

  private

  def nav_item_params
    params.require(:nav_item).permit(:title_sv, :title_en, :page_id, :link, :nav_item_type)
  end
end
