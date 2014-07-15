class PagesController < ApplicationController

  def index
    @posts = Post.all
    @pages = Page.all
  end

  def show
    @page = Page.find_by_slug!(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :content, :slug)
  end
end
