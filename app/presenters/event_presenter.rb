class EventPresenter
  attr_reader :now, :offset, :this_month, :events, :months

  def initialize(events: [], offset: 0)
    @now = Time.current
    @offset = offset || 0
    @this_month = @now.beginning_of_month + @offset.months
    @events = events
  end

  def group_month_and_week
    @events = @events.group_by(&:month)
    @events.each_key do |month|
      @events[month] = @events[month].group_by(&:week)
    end
  end

  def months
    @months ||= [@this_month.last_month, @this_month, @this_month.next_month]
  end
end
