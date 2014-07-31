class Event < ActiveRecord::Base
  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  #validate :start_time_before_end_time #TODO Valideringen

  belongs_to :event_group

  scope :by_group, ->(group) { where event_group: group }

  translates :title, :description

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = start_time
    event.dtend = end_time
    event.summary = self.title
    event.description = self.description
    event.ip_class = "PUBLIC"
    event.created = self.created_at
    event.last_modified = self.updated_at
    #event.uid = event.url = "#{PUBLIC_URL}events/#{self.id}" #TODO: Rätt address
    event
  end

  def day
    start_time.strftime("%e")
  end

  def short_month
    start_time.strftime("%B")[0,3]
  end

end
