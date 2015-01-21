class Question < ActiveRecord::Base
  belongs_to :contact_form
  validates :content, presence: true
end
