class ContactForm < ApplicationRecord
  belongs_to :page, touch: true
  belongs_to :user
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions

  validates :questions, presence: true
end
