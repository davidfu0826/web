class PostsController < ApplicationController
  before_action :load_tags,   only: [:new, :edit, :archive]
  before_action :load_images, only: [:new, :edit]
  before_action :load_events, only: :index
  load_and_authorize_resource

  def index
    @posts = @posts.includes(:image, :tags)
                   .order(created_at: :desc)
                   .filter(filtering_params)
    @images = Image.where(id: Settings.cover_image_ids)

    respond_to do |format|
      format.html { @posts = @posts.order(updated_at: :desc).limit(10) }
      format.rss  { render layout: false } # index.rss.builder
    end
  end

  def show
    @post = Post.includes(:tags).find(params[:id])
    if @post.image.present?
      img = @post.image.thumb_url
      prepare_meta_tags(image: img,
                        twitter: { image: img },
                        og: { image: img })
    end

    @archive = params[:archive].present? || false
    # Used to determine if we should redirect back to archive or index from post
  end

  def new; end

  def create
    # Tags cannot be added before the Post exists.
    @post = Post.new(post_params.except(:tag_ids))

    if @post.save && @post.update(tag_ids: post_params.fetch(:tag_ids, []))
      notice = "Post was created."
      notice = "Post was created, new image was uploaded" if upload_image(@post)
      redirect_to edit_post_path(@post), notice: notice
    else
      load_tags
      load_images
      render :new, status: 422
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      notice = upload_image(@post) ? t('.update_and_image') : t('.only_update')
      redirect_to edit_post_path(@post), notice: notice
    else
      load_tags
      load_images
      render :edit, status: 422
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path
  end

  def archive
    @archive = true # Used to determine where to redirect back from post
    @posts = @posts.includes(:image, :tags)
                   .order(created_at: :desc)
                   .filter(filtering_params)
                   .page(params[:page]).per(6)
  end

  private

  def post_params
    params.require(:post).permit(:title_sv, :content_sv,
                                 :title_en, :content_en,
                                 :image_id, :image_file,
                                 tag_ids: [])
  end

  def filtering_params
    params.slice(:tags)
  end

  def load_tags
    @tags = Tag.order(:title)
  end

  def load_events
    @events = Event.upcoming.limit(3)
  end

  def load_images
    @image = Image.new
    @images = Image.order(created_at: :desc)
  end

  def upload_image(post)
    return false if post.image_file.nil?

    img = Image.new(file: post.image_file)

    img.save && post.update(image: img)
  end
end
