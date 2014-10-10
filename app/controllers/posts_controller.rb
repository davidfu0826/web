class PostsController < ApplicationController
  before_action :load_tags, only: [:new, :edit, :archive]
  before_action :load_events, only: :index
  before_action :load_images, only: [:new, :edit]
  load_and_authorize_resource

  def index
    @posts = @posts.order(created_at: :desc).includes(:image)
    @posts = filter_resource @posts

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
    if @post.save
      redirect_to root_path
    else
      load_tags
      load_images
      render 'new'
    end
  end

  def edit
    @exists = true
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      load_tags
      load_images
      @exists = true
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
    @posts = filter_resource @posts
    @posts = @posts.paginate(:page => params[:page], :per_page => 5)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :title_sv, :content_sv, :title_en, :content_en, :image_id, tag_ids: [])
  end

  def load_tags
    @tags = Tag.all
  end

  def load_events
    @events = Event.upcoming.take(3)
  end

  def load_images
    @images = Image.all
  end
end
