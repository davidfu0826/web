require 'rails_helper'

RSpec.describe CalendarService do
  describe 'set_timezone' do
    it 'sets the right timezone' do
      events = []
      events << build_stubbed(:event, :timestamps)
      events << build_stubbed(:event, :timestamps)

      result = CalendarService.export(events)
      expect(result.to_ical).to include("TZID:#{Event::TZID}")
    end

    it 'sets UTC for created and modified' do
      event = build_stubbed(:event, :timestamps)
      ical = CalendarService.export([event]).to_ical
      expect(ical).to include("CREATED:#{event.created_at.utc.strftime('%Y%m%dT%H%M%SZ')}")
      expect(ical).to include("LAST-MODIFIED:#{event.created_at.utc.strftime('%Y%m%dT%H%M%SZ')}")
    end
  end

  describe '#set_timezone' do
    it 'sets TZInfo' do
      calendar = Icalendar::Calendar.new
      expect(calendar.has_timezone?).to be_falsey

      calendar = CalendarService.set_timezone(calendar)
      expect(calendar.has_timezone?).to be_truthy
      expect(calendar.timezones.first.tzid).to eq(Event::TZID)
    end
  end

  describe '#event' do
    it 'sets title from locale' do
      event = build_stubbed(:event, :timestamps,
                            title_sv: 'Svensk titel', title_en: 'English title',
                            description_sv: 'Svensk beskrivning',
                            description_en: 'English description')

      result = CalendarService.event(event)
      en_result = CalendarService.event(event, locale: 'en')
      expect(result.summary).to eq('Svensk titel')
      expect(en_result.summary).to eq('English title')
      expect(result.description).to eq('Svensk beskrivning')
      expect(en_result.description).to eq('English description')
    end

    it 'applies timezone to start_time and end_time' do
      start_time = 1.hour.from_now
      end_time = start_time + 4.hours
      event = build_stubbed(:event, :timestamps,
                            start_time: start_time,
                            end_time: end_time)

      result = CalendarService.event(event)
      expect(result.dtstart).to eq(start_time)
      expect(result.dtstart.time_zone.tzinfo.name).to eq(Event::TZID)
    end
  end
end
