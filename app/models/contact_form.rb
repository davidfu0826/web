class ContactForm < ActiveRecord::Base
  belongs_to :page
  belongs_to :user
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions

  validates :questions, presence: true
end
