class Image < ActiveRecord::Base
  include Filterable
  include Tagable # includes relationsships and tags-scope

  mount_uploader(:file, ImageUploader)
  validates :image, presence: true
  validates_property(:format, of: :image,
                              in: [:jpeg, :jpg, :png, :bmp, :gif],
                              case_sensitive: false,
                              message: I18n.t('errors.messages.image_format'),
                              if: :image_changed?)

  has_many :posts
  has_many :pages

  scope :tag, ->(tag_id) { joins(:tags).where(tags: { id: tag_id }) }
  scope :search, (lambda do |search|
    unless search.empty?
      image_ids = find_by_fuzzy_image_name(search).map(&:id)
      image_ids << find_by_fuzzy_title(search).map(&:id)
      where(id: image_ids.flatten)
    end
  end)

  fuzzily_searchable :image_name, :title
  dragonfly_accessor :image
  delegate :url, to: :image

  def title
    if self[:title].present?
      self[:title]
    elsif image_uid.present?
      image_uid.split('/').last
    end
  end

  def url
    image.try(:remote_url)
  end

  def thumb_url
    image.thumb('160x160#').url
  end

  def cover_image
    image.thumb('1200x315#').url
  end
end
