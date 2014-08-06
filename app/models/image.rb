class Image < ActiveRecord::Base
  dragonfly_accessor :image

  validates :image, presence: true

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  before_validation(on: [:create, :update]) do
    taggings.each do |t|
      t.taggable = self
    end
  end

  scope :with_tag, -> (tag) { joins(:tags).where( 'tags.id' => tag.id ) }
  scope :search, -> (string) { where(["image_name LIKE ?", "%#{string}%"]) }
end
