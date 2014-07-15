class NavItem < ActiveRecord::Base
  belongs_to :page
  belongs_to :parent, class_name: "NavItem"
  has_many :children, class_name: "NavItem", foreign_key: "parent_id", dependent: :destroy

  scope :orphans, -> { where(parent: nil) }

  validate :has_title_or_page

  def title
    if page
      page.title
    else
      read_attribute(:title)
    end
  end

  def has_page?
    page ? true : false
  end

  def has_title_or_page
    if parent.present? ^ title.present? #XOR
      errors.add(:title, "Måste tilldelas en sida eller en titel")
    end
  end
end
