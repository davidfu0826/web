class Image < ActiveRecord::Base
  include Filterable
  include Tagable # includes relationsships and tags-scope

  mount_uploader(:file, ImageUploader)
  validates :file, presence: true

  has_many :posts
  has_many :pages

  scope :search, (lambda do |search|
    unless search.empty?
      image_ids = find_by_fuzzy_image_name(search).map(&:id)
      image_ids << find_by_fuzzy_title(search).map(&:id)
      where(id: image_ids.flatten)
    end
  end)

  fuzzily_searchable :image_name, :title
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
