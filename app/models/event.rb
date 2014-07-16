class Event < ActiveRecord::Base
  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = start_time
    event.dtend = end_time
    event.summary = self.title
    event.description = self.description
    event.ip_class = "PUBLIC"
    event.created = self.created_at
    event.last_modified = self.updated_at
    #event.uid = event.url = "#{PUBLIC_URL}events/#{self.id}"
    event
  end

end
