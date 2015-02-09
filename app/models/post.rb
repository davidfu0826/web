class Post < ActiveRecord::Base
  include Filterable
  include Tagable
  include FuzzySearchTitles

  validates :title_sv, presence: true
  validates :title_en, presence: true
  validates :content, presence: true

  before_validation(on: [:create, :update]) do
    taggings.each do |t|
      t.taggable = self
    end
  end

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  belongs_to :image

  translates :title, :content
  fuzzily_searchable :title_en, :title_sv

  scope :tag, -> (tag_id) { joins(:tags).where( 'tags.id' => tag_id ) }

  def first_paragraph
    match = content.match(/<p>([^<]+)<\/p>/)
    match.present? ? match[1] : ''
  end

  def to_param
    [id, '-' ,title_en.parameterize].join
  end
end
