class ImagesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @image.save
      redirect_to images_path
    else
      render 'new'
    end
  end

  def destroy
    @image.destroy
    redirect_to images_path
  end

  private

  def image_params
    params.require(:image).permit(:image)
  end

end
