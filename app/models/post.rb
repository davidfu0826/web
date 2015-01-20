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

  scope :tag, -> (tag_id) { joins(:tags).where( 'tags.id' => tag_id ) }
  scope :search, -> (search) {
    joins(:tags).where([
    "lower(title_sv)   LIKE :search_param OR
     lower(title_en)   LIKE :search_param OR
     lower(content_sv) LIKE :search_param OR
     lower(content_sv) LIKE :search_param OR
     tags.title LIKE :search_param
     ", search_param: search
    ])
  }

  def content_html
    process_into_html self.content
  end

  def first_paragraph
    content.match(/<p>([^<]+)<\/p>/)[1]
  end

  def to_param
    [id, '-' ,title_en.parameterize].join
  end
end
