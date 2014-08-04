class PostsController < ApplicationController
  before_action :load_tags, only: [:new, :edit]
  before_action :load_events, only: :index
  load_and_authorize_resource

  def index
    @posts = @posts.order(:created_at).take(3)
    if params[:tag]
      @tag = Tag.find(params[:tag])
      @posts = @posts.with_tag(@tag)
    end
    respond_to do |format|
      format.html
      format.rss { render :layout => false } #index.rss.builder
    end
  end

  def show
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

  def archive
    @posts = @posts.paginate(:page => params[:page], :per_page => 5)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :title_sv, :content_sv, :title_en, :content_en, tag_ids: [])
  end

  def load_tags
    @tags = Tag.all
  end

  def load_events
    @events = Event.order(:start_time).take(3)
  end
end
