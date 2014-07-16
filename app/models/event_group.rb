class EventGroup < ActiveRecord::Base
  validates :name, presence: true

  has_many :events

  translates :name

  def to_s
    name
  end
end
