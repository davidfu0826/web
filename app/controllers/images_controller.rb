class ImagesController < ApplicationController
  before_action :load_tags, only: [:index, :new, :edit]
  load_and_authorize_resource

  def index
    @images = @images.filter(filtering_params)
                     .page(params[:page]).per(20)
  end

  def new; end

  def create
    @image = Image.new(image_params.except(:tag_ids))

    respond_to do |format|
      if @image.save && @image.update(tag_ids: image_params.fetch(:tag_ids, []))
        format.html { redirect_to images_path, notice: t('.success') }
        format.js { render action: 'upload_success' }
      else
        load_tags
        format.html { render :new }
        format.js { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    if @image.update(image_params)
      redirect_to images_path, notice: t('.success')
    else
      load_tags
      render 'edit'
    end
  end

  def destroy
    @image.destroy!

    redirect_to images_path
  end

  # Used by image modal
  def search
    @images = @images.filter(filtering_params)
  end

  private

  def image_params
    params.require(:image).permit(:image, :title)
  end

  def image_tag_params
    params.require(:image).permit(:tags)
  end

  def filtering_params
    params.slice(:search, :tag)
  end

  def load_tags
    @tags = Tag.all
  end
end
