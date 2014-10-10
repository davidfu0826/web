class ImagesController < ApplicationController
  before_action :load_tags, only: [:index, :new, :edit]
  load_and_authorize_resource

  def index
    @images = filter_resource @images
    @images = @images.page(params[:page]).per(20)
  end

  def new
  end

  def create
    respond_to do |format|
      if @image.save
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
    if @image.update(image_params)
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
    @images = filter_resource @images
  end

  private

  def image_params
    params.require(:image).permit(:image, :title, :description, tag_ids: [])
  end

  def load_tags
    @tags = Tag.all
  end

end
