class MeetingDocumentsController < ApplicationController
  load_and_authorize_resource :meeting, only: %i[update destroy]

  def update
    meeting_doc = @meeting.meeting_documents.find(params[:id])
    notice = if meeting_doc.update(meeting_document_params)
               t('.success', kind: view_context
                                   .meeting_document_kind(meeting_doc.kind))
             else
               t('.failed')
             end
    redirect_to(edit_meeting_path(@meeting, anchor: :document), notice: notice)
  end

  def destroy
    meeting_doc = @meeting.meeting_documents.find(params[:id])
    meeting_doc.destroy!

    redirect_to(edit_meeting_path(@meeting), notice: t('.success'))
  end

  def show
    meeting_document = MeetingDocument.find(params[:id])
    meeting_document.locale = I18n.locale
    if meeting_document.view.present?
      redirect_to(meeting_document.view)
    else
      redirect_to(meetings_path, notice: I18n.t('model.document.no_file'))
    end
  end

  private

  def meeting_document_params
    params.require(:meeting_document).permit(:kind)
  end
end
