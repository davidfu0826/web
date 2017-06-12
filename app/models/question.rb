class Question < ApplicationRecord
  belongs_to :contact_form
  validates :content, presence: true
end
