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

  private

  def page_params
    params.require(:page).permit(:title, :content, :slug)
  end
end
