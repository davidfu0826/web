class PostsController < ApplicationController
  before_action :load_tags, only: [:new, :edit]
  load_and_authorize_resource

  def index
    if params[:tag]
      @tag = Tag.find(params[:tag])
      @posts = @posts.with_tag(@tag)
    end
    respond_to do |format|
      format.html
      format.rss { render :layout => false } #index.rss.builder
    end
  end

  def new
  end

  def create
    if @post.save
      redirect_to root_path
    else
      load_tags
      render 'new'
    end
  end

  def edit
    @exists = true
  end

  def update
    if @post.update(post_params)
      redirect_to root_path
    else
      load_tags
      @exists = true
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :title_sv, :content_sv, :title_en, :content_en, tag_ids: [])
  end

  def load_tags
    @tags = Tag.all
  end
end
