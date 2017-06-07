class Post < ApplicationRecord
  include Filterable
  include LocaleContent

  attr_accessor :image_file
  validates :title_sv, :title_en, :content, presence: true

  belongs_to :image, optional: true
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  translates :title, :content

  scope :tags, (->(tag_id) { joins(:tags).where(tags: { id: tag_id }) })

  def first_paragraph
    match = content.match(/<p>([^<]+)<\/p>/)
    if match.present?
      match[1]
    else
      ActionController::Base.helpers.strip_tags(content).slice(0, 140)
    end
  end

  def to_param
    [id, '-', title_en.parameterize].join
  end

  def image_thumb
    image.thumb_url if image.present?
  end
end
