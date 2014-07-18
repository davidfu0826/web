class Image < ActiveRecord::Base
  dragonfly_accessor :image

  validates :image, presence: true

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  scope :with_tag, -> (tag) { joins(:tags).where( 'tags.id' => tag.id ) }
end
