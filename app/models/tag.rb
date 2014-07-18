class Tag < ActiveRecord::Base
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  has_many :taggings, :dependent => :destroy
  has_many :posts, through: :taggings, source: :taggable, source_type: 'Post'
  has_many :images, through: :taggings, source: :taggable, source_type: 'Image'

  scope :has_posts,  -> { where( "posts_count > 0" )  }
  scope :has_images, -> { where( "images_count > 0" ) }
end
