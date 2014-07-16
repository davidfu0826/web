class EventGroup < ActiveRecord::Base
  validates :name, presence: true

  has_many :events
end
