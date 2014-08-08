class Page < ActiveRecord::Base
  #include ApplicationHelper
  include HtmlHelper


  before_validation do
    self.slug = self.title_en.parameterize
  end
  validates :title_sv, presence: true
  validates :title_en, presence: true
  validate :slug_not_reserved_name
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true

  translates :title, :content

  has_one :nav_item, dependent: :destroy
  has_and_belongs_to_many :contacts, class_name: 'User'
  has_many :contact_forms

  scope :orphans, -> { includes(:nav_item).where( :nav_items => { :page_id => nil } ) }

  def slug_not_reserved_name
    reserved_names = %w(users events event_groups posts nav_items pages)
    if reserved_names.include? slug
      errors.add(:slug, I18n.t('errors.slug_reserved'))
    end
  end

  def to_param
    slug
  end
end
