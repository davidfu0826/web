# Connects a Document to a Meeting
class MeetingDocument < ApplicationRecord
  belongs_to :document, optional: true, dependent: :destroy
  belongs_to :meeting
  attr_writer(:locale)
  mount_uploader(:file_sv, DocumentUploader)
  mount_uploader(:file_en, DocumentUploader)
  validates :kind, presence: true
  enum kind: { convocation: 10, agenda: 12, meeting_document: 14,
               late_meeting_documents: 16, minute: 18, summary: 20, other: 22 }

  scope(:locale, lambda do |locale|
    field = locale == :sv ? :file_sv : :file_en
    where.not(field => ['', nil])
  end)

  def locale
    @locale ||= I18n.default_locale
  end

  def filename(locale: self.locale)
    locale == :sv ? file_sv_identifier : file_en_identifier
  end

  def view(locale: self.locale)
    file(locale: locale).try(:url)
  end

  def file(locale: self.locale)
    locale == :sv ? file_sv : file_en
  end
end
