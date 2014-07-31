class ImagesController < ApplicationController
  before_action :load_tags, only: [:index, :new, :edit]
  load_and_authorize_resource

  def index
    if params[:search]
      @images = @images.search(params[:search])
      @search = params[:search]
    end
    if params[:tag] && !params[:tag].blank?
      @tag = Tag.find(params[:tag])
      @images = @images.with_tag(@tag)
    end
  end

  def new
  end

  def create
    if @image.save
      redirect_to images_path
    else
      load_tags
      render 'new'
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

  private

  def image_params
    params.require(:image).permit(:image, :description, tag_ids: [])
  end

  def load_tags
    @tags = Tag.all
  end

end
