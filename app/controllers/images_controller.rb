class ImagesController < ApplicationController
  before_action :load_tags, only: [:index, :new, :edit]
  load_and_authorize_resource

  def index
    @images = @images.filter(filtering_params)
    @images = @images.page(params[:page]).per(20)
  end

  def new
  end

  def create
    @image = Image.create_with_tags(image_params, params[:image][:tags])
    respond_to do |format|
      unless @image.new_record?
        format.html { redirect_to images_path, notice: t('.success') }
        format.js   { render action: 'upload_success' }
      else
        load_tags
        format.html { render action: 'new' }
        format.js   { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @image.update_with_tags(image_params, params[:image][:tags])
      redirect_to images_path
    else
      load_tags
      render 'edit'
    end
  end

  def destroy
    @image.destroy
    redirect_to images_path
  end

  def search
    @images = @images.filter(filtering_params)
  end

  private

  def image_params
    params.require(:image).permit(:image, :title)
  end

  def filtering_params
    params.slice(:search, :tag)
  end

  def load_tags
    @tags = Tag.all
  end
end
