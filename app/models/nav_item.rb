class NavItem < ActiveRecord::Base
  belongs_to :page
  belongs_to :parent, class_name: 'NavItem', touch: true
  has_many :children, -> { order('position ASC') }, class_name: 'NavItem', foreign_key: 'parent_id'

  scope :orphans, -> { where(parent: nil) }

  validate :title_or_page?
  validate :prefix_if_link?
  before_destroy :set_parent_of_children

  translates :title
  acts_as_list scope: :parent, class_name: 'NavItem'

  enum nav_item_type: [:menu, :page, :link]

  def self.update_order!(nav_items)
    update_order(nav_items)
  end

  def item_title
    nav_item_type == 'page' ? page.title : title
  end

  def link
    case nav_item_type
    when 'page'
      "/#{page.slug}"
    when 'menu'
      '#'
    else
      self[:link]
    end
  end

  def children?
    children.any?
  end

  private

  def self.update_order(nav_items, parent_id = nil)
    nav_items.each_with_index do |child_element, index|
      NavItem.update(child_element['id'], parent_id: parent_id, position: index + 1)
      if child_element['children']
        update_order(child_element['children'], child_element['id'])
      end
    end
  end

  def set_parent_of_children
    children.update_all(parent_id: nil)
  end

  def title_or_page?
    return unless nav_item_type != 'page' && (title_sv.blank? || title_sv.blank?)
    errors.add(:base, I18n.t('errors.messages.should_have_page_or_title'))
  end

  def prefix_if_link?
    return unless nav_item_type == 'link' && !link.include?('http')
    errors.add(:link, I18n.t('errors.messages.should_have_prefix'))
  end
end
