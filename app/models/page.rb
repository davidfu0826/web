class Page < ActiveRecord::Base
  include HtmlHelper

  validates :title_sv, presence: true, character: true
  validates :title_en, presence: true, character: true
  validate :slug_not_reserved_name
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true
  validates_associated :nav_item

  translates :title
  translates :content

  has_one :nav_item, dependent: :destroy
  has_and_belongs_to_many :contacts, class_name: 'User'
  has_many :contact_forms

  belongs_to :image

  scope :orphans, -> { includes(:nav_item).where( :nav_items => { :page_id => nil } ) }

  before_validation do
    self.slug = self.title_en.parameterize
  end
  after_create do
    nav_item.save if nav_item
  end

  def add_nav_item(create:, parent:)
    if create
      if parent
        parent = NavItem.find(parent)
        nav_item = NavItem.new(page: self, parent: parent)
      else
        nav_item = NavItem.new(page: self)
      end
    end
  end

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
