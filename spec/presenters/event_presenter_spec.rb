require 'rails_helper'

RSpec.describe EventPresenter, type: :presenter do
  describe '#initialize' do
    it 'sets instance variables' do
      time = Time.new(2016, 03, 25, 13, 37, 00)
      allow(Time).to receive(:current) { time }
      events = [build_stubbed(:event), build_stubbed(:event)]
      presenter = EventPresenter.new(events: events, offset: 5)

      expect(presenter.now).to eq(time)
      expect(presenter.offset).to eq(5)
      expect(presenter.this_month).to eq(time.beginning_of_month + 5.months)
    end
  end

  describe '#group_month_and_week' do
    it 'groups by month and week' do
      events = []
      current_month = Time.zone.now.beginning_of_month
      (1..4).each do |i|
        events << build_stubbed(:event, start_time: current_month - i.months)
        events << build_stubbed(:event, start_time: current_month - i.months + 1.week)
      end

      presenter = EventPresenter.new(events: events, offset: 2)
      presenter.group_month_and_week
      expect(presenter.events.keys.count).to eq(4)
      expect(presenter.events[current_month - 1.month].count).to eq(2)
    end
  end

  describe '#months' do
    it 'sets months' do
      allow(Time).to receive(:current) { Time.new(2016, 5, 1) }
      presenter = EventPresenter.new
      expect(presenter.months).to eq([Time.new(2016, 4, 1),
                                      Time.new(2016, 5, 1),
                                      Time.new(2016, 6, 1)])
    end
  end
end
