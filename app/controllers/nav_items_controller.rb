class NavItemsController < ApplicationController
  load_and_authorize_resource

  def move_higher
    @nav_item.move_higher
    redirect_to pages_path
  end

  def move_lower
    @nav_item.move_lower
    redirect_to pages_path
  end
end
