class Post < ActiveRecord::Base
  include HtmlHelper

  validates :title, presence: true
  validates :content, presence: true

  before_validation(on: [:create, :update]) do
    taggings.each do |t|
      t.taggable = self
    end
  end
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  scope :with_tag, -> (tag) { joins(:tags).where( 'tags.id' => tag.id ) }
  scope :search, -> (search) {
    where([
    "title_sv LIKE ? OR
     title_en LIKE ? OR
     content_sv LIKE ? OR
     content_sv LIKE ?",
    "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"
    ])
  }

  translates :title, :content

  def content_html
    process_into_html self.content
  end
end
