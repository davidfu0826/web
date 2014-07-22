class ContactForm < ActiveRecord::Base
  belongs_to :page
  has_many :users
  has_many :questions
end
