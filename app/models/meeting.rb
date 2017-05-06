# A meeting by the board our council, connects a meeting with documents
class Meeting < ActiveRecord::Base
  enum(kind: { board: 0, council: 1, other: 2 })
  validates(:title, :year, :kind, presence: true)
  validates(:ranking, uniqueness: { scope: [:year, :kind] })

  has_many(:documents, through: :meeting_documents)
  has_many(:meeting_documents, dependent: :destroy)

  scope(:by_order, -> { order(:kind, year: :desc, ranking: :desc) })
  attr_accessor(:document_kind,
                :file_sv, :file_en,
                :file_sv_url, :file_en_url)

  def to_s
    "#{year} #{title}"
  end
end
