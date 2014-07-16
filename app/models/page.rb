class Page < ActiveRecord::Base
  include Markdown

  validates :title, presence: true
  validates :slug, presence: true
  validates :content, presence: true
  # slug får inte vara ett reserverat namn typ users osv

  translates :title, :content

  has_one :nav_item

  markdown :content
  belongs_to :user

  def to_param
    slug
  end
end
