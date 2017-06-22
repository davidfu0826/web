class UploadsController < ApplicationController
  load_and_authorize_resource

  def index
    @uploads = @uploads.page(params[:page]).per(100)
                       .order(updated_at: :desc)
  end

  def show
    redirect_to(@upload.view)
  end

  def new; end

  def create
    uploads = Upload.create(files)
    notice = if uploads.all?(&:persisted?)
               t('.success')
             else
               "#{t('.some_failed')}: #{upload_errors(uploads)}"
             end

    redirect_to(uploads_path, notice: notice)
  end

  def destroy
    @upload.destroy!
    redirect_to uploads_path, notice: t('.success')
  end

  private

  def upload_params
    params.require(:upload).permit(:file)
  end

  def files
    files_params = params.require(:upload).fetch(:files, []).reject(&:blank?)
    fs = []
    files_params.each do |param|
      fs << { pdf: param }
    end
    fs
  end

  def upload_errors(uploads)
    uploads.map do |upload|
      upload.errors.full_messages unless upload.errors.full_messages.empty?
    end.compact.join('<br/>')
  end
end
