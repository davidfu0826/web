class Question < ActiveRecord::Base
  belongs_to :contact_form
  validates :contact_form, presence: true
  validates :content, presence: true
end
