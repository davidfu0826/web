class NavItem < ActiveRecord::Base
  belongs_to :page
  belongs_to :parent, class_name: "NavItem"
  has_many :children, -> { order("position ASC") }, class_name: "NavItem", foreign_key: "parent_id", dependent: :destroy

  scope :orphans, -> { where(parent: nil) }
  scope :no_page, -> { where(page: nil) }

  validate :has_title_or_page

  translates :title
  acts_as_list scope: :parent, class_name: "NavItem"

  def item_title
    if page
      page.title
    else
      title
    end
  end

  def has_page?
    !!page
  end

  def has_title_or_page
    unless page.present? ^ title.present? #XOR
      errors.add(:title, I18n.t('.should_have_page_or_title'))
    end
  end
end
