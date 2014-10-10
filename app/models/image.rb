class Image < ActiveRecord::Base
  before_validation(on: [:create, :update]) do
    taggings.each do |t|
      t.taggable = self
    end
  end
  validates :image, presence: true
  validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :bmp], case_sensitive: false,
                   message: I18n.t('errors.messages.image_format'), if: :image_changed?
  delegate :url, to: :image

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  has_many :posts
  has_many :pages

  scope :with_tag, -> (tag) { joins(:tags).where( 'tags.id' => tag.id ) }
  scope :search, -> (string) { where(["lower(image_name) LIKE ?", "%#{string}%"]) }

  dragonfly_accessor :image

  def title
    if self[:title].present?
      self[:title]
    else
      image_uid.split('/').last
    end
  end
end
