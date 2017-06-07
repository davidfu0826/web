class Document < ApplicationRecord
  attr_writer(:locale)
  mount_uploader(:file_sv, DocumentUploader)
  mount_uploader(:file_en, DocumentUploader)

  has_many(:meeting_documents)
  has_many(:meetings, through: :meeting_documents)
  validates(:title_sv, :title_en,
            presence: true)
  translates(:title, :description, :file, fallback: :any)
  enum(category: { uncategorized: -1, vision: 0, bylaws: 1, regulation: 2,
                   policy: 3, guideline: 4, opinion: 5, budget: 6,
                   annual_report: 7, annual_plan: 8, directive: 9, meeting: 10})
  scope(:by_revision, -> { order(revision_date: :desc) })
  scope(:by_title, lambda do |locale|
    if locale == :sv
      order(:title_sv)
    else
      order(:title_en)
    end
  end)

  scope(:locale, lambda do |locale|
    if locale == :sv
      where.not(file_sv: ['', nil])
    else
      where.not(file_en: ['', nil])
    end
  end)

  def locale
    @locale ||= I18n.default_locale
  end

  def filename(locale: self.locale)
    if locale == :sv
      file_sv_identifier
    else
      file_en_identifier
    end
  end

  def view(locale: self.locale)
    f = file(locale: locale)
    return if f.nil?
    f.url
  end

  def file(locale: self.locale)
    if locale == :sv
      file_sv
    else
      file_en
    end
  end
end
