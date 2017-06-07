# A meeting by the board our council, connects a meeting with documents
class Meeting < ApplicationRecord
  enum(kind: { board: 0, council: 1, other: 2 })
  validates(:title, :year, :kind, presence: true)
  validates(:ranking, uniqueness: { scope: [:year, :kind] })

  has_many(:documents, through: :meeting_documents)
  has_many(:meeting_documents, dependent: :destroy)

  scope(:with_documents, -> { includes(meeting_documents: :document) })
  scope(:by_order, -> { order(:kind, year: :desc, ranking: :desc) })
  scope(:order_documents, -> { order('meeting_documents.kind') })
  scope(:document_locale, lambda do |locale|
    if locale == :sv
      where.not(documents: { file_sv: ['', nil] })
    else
      where.not(documents: { file_en: ['', nil] })
    end
  end)

  attr_accessor(:document_kind,
                :file_sv, :file_en,
                :file_sv_url, :file_en_url)

  def to_s
    "#{year} #{title}"
  end
end
