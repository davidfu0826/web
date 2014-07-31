class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  scope :with_tag, -> (tag) { joins(:tags).where( 'tags.id' => tag.id ) }

  translates :title, :content
end
