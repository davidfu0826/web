class Page < ActiveRecord::Base
  include AutoHtml

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validate :slug_not_reserved_name
  validates :content, presence: true

  translates :title, :content

  has_one :nav_item, dependent: :destroy
  belongs_to :user

  scope :orphans, -> { includes(:nav_item).where( :nav_items => { :page_id => nil } ) }

  def slug_not_reserved_name
    reserved_names = %(users events event_groups posts nav_items pages).split
    if reserved_names.include? slug
      errors.add(:slug, I18n.t('errors.slug_reserved'))
    end
  end

  def content_html
    auto_html self.content do
      redcarpet
      youtube(:width => '70%', :height => '400', :autoplay => false)
      simple_format
    end
  end

  def to_param
    slug
  end
end
