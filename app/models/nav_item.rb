class NavItem < ActiveRecord::Base
  belongs_to :page
  belongs_to :parent, class_name: "NavItem"
  has_many :children, class_name: "NavItem", foreign_key: "parent_id"

  def title
    page.title || read_attribute(:title)
  end
end
