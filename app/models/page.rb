class Page < ActiveRecord::Base
  validates :title, presence: true
  validates :slug, presence: true
  validates :content, presence: true

  translates :title, :content

  has_one :nav_item
  belongs_to :user

  def to_param
    slug
  end
end
