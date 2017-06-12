class Image < ApplicationRecord
  include Filterable
  include Tagable # includes relationsships and tags-scope

  mount_uploader(:file, ImageUploader)
  validates :file, presence: true

  has_many :posts
  has_many :pages
  dragonfly_accessor :image

  def title
    if self[:title].present?
      self[:title]
    elsif file_name.present?
      file_name
    end
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
