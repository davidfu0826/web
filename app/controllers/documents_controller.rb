class DocumentsController < ApplicationController
  load_and_authorize_resource

  def index
    @presenter = DocumentPresenter.new(@documents.locale(I18n.locale))
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to(edit_document_path(@document), notice: 'Created')
    else
      render(:new, status: 422)
    end
  end

  def new; end

  def update
    if @document.update(document_params)
      redirect_to(edit_document_path(@document), notice: 'Updated')
    else
      render(:edit, status: 422)
    end
  end

  def edit
    @document = Document.includes(:meetings).find(params[:id])
  end

  def show
    @document.locale = I18n.locale
    if @document.view.present?
      redirect_to(@document.view)
    else
      redirect_to(documents_path, notice: 'No file')
    end
  end

  private

  def document_params
    params.require(:document).permit(:title_sv, :title_en,
                                     :description_sv, :description_en,
                                     :file_sv, :file_en, :category,
                                     :revision_date)
  end
end
