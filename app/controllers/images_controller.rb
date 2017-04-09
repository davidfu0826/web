class ImagesController < ApplicationController
  before_action :load_tags, only: [:index, :new, :edit]
  load_and_authorize_resource

  def index
    @images = @images.filter(search_params)
                     .page(params[:page])
                     .per(20)
  end

  def new; end

  def create
    @image = Image.new(image_params.except(:tag_ids))

    respond_to do |format|
      if @image.save && @image.update(tag_ids: image_params.fetch(:tag_ids, []))
        format.html { redirect_to images_path, notice: t('.success') }
        format.js   { render action: 'upload_success' }
      else
        load_tags
        format.html { render :new, status: 422 }
        format.js do
          render json: @image.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def edit; end

  def update
    if @image.update(image_params)
      redirect_to edit_image_path(@image), notice: 'Image updated'
    else
      load_tags
      render :edit, status: 422
    end
  end

  def destroy
    @image.destroy!
    redirect_to images_path
  end

  # Used by image modal
  def search
    @images = @images.filter(search_params)
  end

  private

  def image_params
    params.require(:image).permit(:image, :title, tag_ids: [])
  end

  def search_params
    params.slice(:search, :tags)
  end

  def load_tags
    @tags = Tag.order(:title)
  end
end
