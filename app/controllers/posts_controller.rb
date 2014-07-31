class PostsController < ApplicationController
  before_action :load_tags, only: [:new, :edit]
  before_action :load_events, only: :index
  before_action :load_tweets, only: :tweets
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

  def tweets
    render partial: 'tweet', collection: @tweets
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

  def load_tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
    @tweets = client.user_timeline[0..2]
  end
end
