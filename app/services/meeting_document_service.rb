class MeetingDocumentService
  def self.upload_document(meeting)
    # It is not faulty to not upload a document
    return true unless document?(meeting)
    m_doc = meeting.meeting_documents.build(kind: meeting.document_kind)
    add_file(meeting, m_doc)

    m_doc.save!
  rescue ActiveRecord::RecordInvalid => invalid
    err_m = I18n.t('meetings.service.invalid') + '<br>'
    invalid.record.errors.full_messages.each do |e|
      err_m += e + '<br>'
    end

    meeting.errors.add(:document, err_m)
    false
  end

  def self.document?(meeting)
    return false if meeting.nil?

    meeting.document_kind.present? &&
      (meeting.file_sv.present? || meeting.file_en.present? ||
      meeting.file_sv_url.present? || meeting.file_en_url.present?)
  end

  def self.add_file(meeting, m_doc)
    if meeting.file_sv.present?
      m_doc.file_sv = meeting.file_sv
    elsif meeting.file_sv_url.present?
      m_doc.remote_file_sv_url = meeting.file_sv_url
    end

    if meeting.file_en.present?
      m_doc.file_en = meeting.file_en
    elsif meeting.file_en_url.present?
      m_doc.remote_file_en_url = meeting.file_en_url
    end
  end
end
