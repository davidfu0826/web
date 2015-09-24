class Tag < ActiveRecord::Base
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  has_many :taggings, dependent: :destroy
  has_many :posts,  through: :taggings, source: :taggable, source_type: 'Post'
  has_many :images, through: :taggings, source: :taggable, source_type: 'Image'
  has_many :events, through: :taggings, source: :taggable, source_type: 'Event'

  def to_s
    title
  end
end
