class MeetingDocumentsController < ApplicationController
  load_and_authorize_resource :meeting

  def update
    meeting_doc = @meeting.meeting_documents.find(params[:id])
    notice = if meeting_doc.update(meeting_document_params)
               "Document was updated"
             else
               "Document couldn't be updated"
             end
    redirect_to(edit_meeting_path(@meeting), notice: notice)
  end

  def destroy
    meeting_doc = @meeting.meeting_documents.find(params[:id])
    meeting_doc.destroy!

    redirect_to(edit_meeting_path(@meeting), notice: "Document was destroyed")
  end

  private

  def meeting_document_params
    params.require(:meeting_document).permit(:kind)
  end
end
