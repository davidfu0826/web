class Document < ActiveRecord::Base
  mount_uploader(:file_sv, DocumentUploader)
  mount_uploader(:file_en, DocumentUploader)
  validates(:title_sv, :title_en,
            :description_sv, :description_en,
            presence: true)
  translates(:title, :description, :file, fallback: :any)
  enum(category: { uncategorized: -1, vision: 0, bylaws: 1, regulation: 2,
                   policy: 3, guideline: 4, opinion: 5, budget: 6,
                   annual_report: 7, annual_plan: 8, directive: 9 })
  scope(:by_revision, -> { order(revision_date: :desc)})
  scope(:by_title, ->(locale) do
    locale = locale.to_s
    if locale == 'en'
      order(:title_en)
    else
      order(:title_sv)
    end
  end)

  scope(:locale, ->(locale) do
    locale = locale.to_s
    if locale == 'sv'
      where.not(file_sv: ['', nil])
    else
      where.not(file_en: ['', nil])
    end
  end)

  def filename(locale: 'sv')
    locale = locale.to_s
    if locale == 'sv'
      file_sv_identifier
    else
      file_en_identifier
    end
  end

  def view
    if file.present?
      if ENV['AWS']
        file.url
      else
        file.path
      end
    end
  end
end
