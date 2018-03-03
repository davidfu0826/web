class Document < ApplicationRecord
  attr_writer(:locale)
  # It stores sv and en file in same folder, going to update.
  mount_uploader(:file_sv, FaultyDocumentUploader)
  mount_uploader(:file_en, FaultyDocumentUploader)

  belongs_to(:meeting, optional: true) # Revisioned at meeting
  has_many(:meeting_documents)
  has_many(:meetings, through: :meeting_documents)
  validates(:title_sv, :title_en, presence: true)
  translates(:title, :description, :file, fallback: :any)
  enum(category: { uncategorized: -1, vision: 0, bylaws: 1, regulation: 2,
                   policy: 3, guideline: 4, opinion: 5, budget: 6,
                   annual_report: 7, annual_plan: 8, directive: 9,
                   meeting: 10 })
  scope(:by_revision, lambda do
    includes(:meeting).order('meetings.meeting_date desc')
  end)

  scope(:by_title, lambda do |locale|
    order(locale == :sv ? :title_sv : :title_en)
  end)

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
