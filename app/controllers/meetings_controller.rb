# Handles creation of Meetings and connection to Documents
class MeetingsController < ApplicationController
  load_and_authorize_resource

  def new; end

  def edit
    @meeting = Meeting.with_documents
                      .by_order
                      .order_documents
                      .find(params[:id])
  end

  def index
    @meetings = @meetings.by_order.group_by(&:kind)
  end

  def create
    if @meeting.save
      redirect_to(edit_meeting_path(@meeting), notice: t('.success'))
    else
      render(:new, status: 422)
    end
  end

  def update
    if @meeting.update(meeting_params) &&
       MeetingDocumentService.upload_document(@meeting)
      redirect_to(edit_meeting_path(@meeting), notice: t('.success'))
    else
      render(:edit, status: 422)
    end
  end

  def destroy
    @meeting.destroy!
    redirect_to(meetings_path, notice: t('.success'))
  end

  private

  def meeting_params
    params.require(:meeting).permit(:kind, :title, :year,
                                    :document_kind,
                                    :file_sv, :file_en,
                                    :file_sv_url, :file_en_url,
                                    :ranking, :meeting_date)
  end
end
