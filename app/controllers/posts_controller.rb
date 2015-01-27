class PostsController < ApplicationController
  before_action :load_tags,   only: [:new, :edit, :archive]
  before_action :load_images, only: [:new, :edit]
  before_action :load_events, only: :index
  load_and_authorize_resource

  def index
    @posts = @posts.order(created_at: :desc).includes(:image)
    @posts = @posts.filter(filtering_params)

    respond_to do |format|
      format.html { @posts = @posts.take(3) }
      format.rss  { render :layout => false } #index.rss.builder
    end
  end

  def show
    @archive = params[:archive].present? || false #Used to determine if we should redirect back to archive or index from post
  end

  def new
  end

  def create
    @post = Post.create_with_tags(post_params, params[:post][:tags])
    unless @post.new_record?
      redirect_to root_path
    else
      load_tags
      load_images
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_with_tags(post_params, params[:post][:tags])
      redirect_to @post
    else
      load_tags
      load_images
      render 'edit'
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_path
  end

  def archive
    @archive = true #Used to determine where to redirect back from post
    @posts = @posts.order(created_at: :desc).includes(:image)
    @posts = @posts.filter(filtering_params)
    @posts = @posts.page(params[:page]).per(6)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :title_sv, :content_sv, :title_en, :content_en, :image_id, tag_ids: [])
  end

  def filtering_params
    params.slice(:search, :tag)
  end

  def load_tags
    @tags = Tag.all
  end

  def load_events
    @events = Event.upcoming.take(3)
  end

  def load_images
    @image = Image.new
    @images = Image.all
  end
end
