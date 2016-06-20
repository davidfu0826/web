module CalendarService
  require 'icalendar/tzinfo'

  def self.export(events, locale: 'sv')
    calendar = set_timezone(Icalendar::Calendar.new)
    events.each do |e|
      calendar.add_event(event(e, locale: locale))
    end

    calendar.publish
    calendar
  end

  def self.set_timezone(calendar)
    tz = TZInfo::Timezone.get(Event::TZID)
    timezone = tz.ical_timezone(Time.zone.now)
    calendar.add_timezone(timezone)
    calendar
  end

  def self.event(resource, locale: 'sv')
    ical_event = Icalendar::Event.new
    ical_event.dtstart = Icalendar::Values::DateTime.new(resource.start_time,
                                                         'tzid' => Event::TZID)
    ical_event.dtend = Icalendar::Values::DateTime.new(resource.end_time,
                                                       'tzid' => Event::TZID)

    if locale == 'en'
      ical_event.description = resource.description_en
      ical_event.summary = resource.title_en
    else
      ical_event.description = resource.description_sv
      ical_event.summary = resource.title_sv
    end
    ical_event.uid = ical_event.url = Rails.application.routes.url_helpers.event_url(resource.id,
                                                                                     host: PUBLIC_URL)
    ical_event.created = Icalendar::Values::DateTime.new(resource.created_at.utc,
                                                        'tzid' => 'UTC')
    ical_event.last_modified = Icalendar::Values::DateTime.new(resource.updated_at.utc,
                                                              'tzid' => 'UTC')
    ical_event.ip_class = "PUBLIC"
    ical_event
  end
end
