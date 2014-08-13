class Image < ActiveRecord::Base
  before_validation(on: [:create, :update]) do
    taggings.each do |t|
      t.taggable = self
    end
  end
  validates :image, presence: true

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  scope :with_tag, -> (tag) { joins(:tags).where( 'tags.id' => tag.id ) }
  scope :search, -> (string) { where(["lower(image_name) LIKE ?", "%#{string}%"]) }

  dragonfly_accessor :image
end
