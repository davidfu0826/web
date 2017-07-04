class Upload < ApplicationRecord
  include Filterable
  mount_uploader(:pdf, DocumentUploader)
  validates(:pdf, presence: true)

  scope(:by_updated, -> { order(updated_at: :desc) })

  def file_type
    'PDF'
  end

  def name
    file_name || pdf_identifier
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def view
    pdf.try(:url)
  end
end
