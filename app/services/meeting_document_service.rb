class MeetingDocumentService
  def self.upload_document(meeting)
    # It is not faulty to not upload a document
    return true unless document?(meeting)
    m_doc = meeting.meeting_documents.build(kind: meeting.document_kind)
    doc = Document.new(category: :meeting,
                       title_sv: title(meeting, m_doc, locale: :sv),
                       title_en: title(meeting, m_doc, locale: :en))
    add_file(meeting, doc)
    m_doc.document = doc

    MeetingDocument.transaction do
      doc.save!
      m_doc.save!
    end

    true
  rescue ActiveRecord::RecordInvalid => invalid
    err_m = I18n.t('meetings.service.invalid') + '<br>'
    invalid.record.errors.full_messages.each do |e|
      err_m += e + '<br>'
    end

    meeting.errors.add(:document, err_m)
    return false
  end

  def self.document?(meeting)
    return false if meeting.nil?

    meeting.document_kind.present? &&
    (meeting.file_sv.present? || meeting.file_en.present? ||
     meeting.file_sv_url.present? || meeting.file_en_url.present?)
  end

  def self.add_file(meeting, doc)
    if meeting.file_sv.present?
      doc.file_sv = meeting.file_sv
    elsif meeting.file_sv_url.present?
      doc.remote_file_sv_url = meeting.file_sv_url
    end

    if meeting.file_en.present?
      doc.file_en = meeting.file_en
    elsif meeting.file_en_url.present?
      doc.remote_file_en_url = meeting.file_en_url
    end
  end

  def self.title(meeting, m_doc, locale: :sv)
    title = ""
    return title if meeting.nil? || m_doc.nil?

    title += meeting.year + " "
    title += meeting.title + " - "
    title += I18n.t("model.meeting_document.kinds.#{m_doc.kind}", locale: locale)
    title
   end
end
