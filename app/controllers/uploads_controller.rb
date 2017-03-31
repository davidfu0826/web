class UploadsController < ApplicationController
  load_and_authorize_resource

  def index
    @uploads = @uploads.filter(params.slice(:search))
                       .page(params[:page]).per(100)
                       .order(updated_at: :desc)
  end

  def show
    redirect_to(@upload.view)
  end

  def new; end

  def create
    @uploads = Upload.create(files)
    if @uploads.all?(&:persisted?)
      notice = I18n.t('model.upload.success_uploading')
    else
      errors = @uploads.map do |upload|
        upload.errors.full_messages unless upload.errors.full_messages.empty?
      end.compact.join('<br/>')

      notice = "#{I18n.t('model.upload.failed_to_save_some')}: #{errors}"
    end

    redirect_to(uploads_path, notice: notice)
  end

  def destroy
    @upload.destroy!
    redirect_to uploads_path
  end

  private

  def upload_params
    params.require(:upload).permit(:file)
  end

  def files
    files_params = params.require(:upload).fetch(:files, [])
    files = []
    files_params.each do |param|
      files << { file: param }
    end
    files
  end
end
