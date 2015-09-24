class UploadsController < ApplicationController
  load_and_authorize_resource

  def index
    @uploads = @uploads.filter(params.slice(:search))
      .page(params[:page]).per(100) # if @uploads.present?
  end

  def show
    redirect_to @upload.file.url
  end

  def new
  end

  def create
    if @upload.save
      redirect_to uploads_path
    else
      render 'new'
    end
  end

  def destroy
    @upload.destroy
    redirect_to uploads_path
  end

  private

  def upload_params
    params.require(:upload).permit(:file)
  end
end
