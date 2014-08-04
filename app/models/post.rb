class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

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
end
