class TagsController < ApplicationController
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html
      format.json { render json: @tags.to_json(only: [:id, :title]) }
    end
  end

  def new
  end

  def create
    if @tag.save
      redirect_to tags_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render 'edit'
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:title, :color)
  end
end
