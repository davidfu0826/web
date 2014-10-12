class Post < ActiveRecord::Base
  include HtmlHelper
  include Filterable

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

  scope :with_tag, -> (tag_id) { joins(:tags).where( 'tags.id' => tag_id ) }
  scope :search, -> (search) {
    where([
    "lower(title_sv) LIKE ? OR
     lower(title_en) LIKE ? OR
     lower(content_sv) LIKE ? OR
     lower(content_sv) LIKE ?",
    "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"
    ])
  }

  def content_html
    process_into_html self.content
  end

  def to_param
    [id, '-' ,title_en.parameterize].join
  end
end
