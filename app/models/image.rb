class Image < ApplicationRecord
  include Filterable
  include Tagable # includes relationsships and tags-scope

  mount_uploader(:file, ImageUploader)
  validates :file, presence: true

  has_many :posts
  has_many :pages

  def to_s
    title || file_name
  end

  def url
    file.large.url
  end

  def thumb_url
    file.thumb.url
  end

  def cover_image
    file.large.url
  end
end
