class Page < ActiveRecord::Base
  validates :title, presence: true
  validates :slug, presence: true
  validates :content, presence: true

  has_one :nav_item


  def to_param
    slug
  end
end
