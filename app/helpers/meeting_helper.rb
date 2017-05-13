module MeetingHelper
  def meeting_kinds
    Meeting.kinds.keys.map { |c| [meeting_kind(c), c] }
  end

  def meeting_kind(k)
    t("model.meeting.kinds.#{k}")
  end

  def meeting_document_kinds
    MeetingDocument.kinds.keys.sort.map { |c| [meeting_document_kind(c), c] }
  end

  def meeting_document_kind(k)
    t("model.meeting_document.kinds.#{k}")
  end
end
