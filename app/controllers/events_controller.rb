class EventsController < ApplicationController
  before_filter :load_event_groups, only: [:index, :new, :edit]
  load_and_authorize_resource

  def index
    if params[:search].present?
      group = @event_groups.find(params[:search])
      @events = @events.by_group(group)
    end

    respond_to do |format|
      format.html do
        @events = events_by_month_and_week(@events)
        @this_month = Time.now.month
        @last_month = (@this_month-2)%12+1 #Kan inte månader vara nollindexerade
        @next_month = (@this_month)%12+1
      end
      format.ics do
        calendar = Icalendar::Calendar.new
        @events.each do |event|
          calendar.add_event(event.to_ics)
        end
        calendar.publish
        render :text => calendar.to_ical
      end
    end
  end

  def show
  end

  def new
  end

  def create
    if @event.save
      redirect_to event_path(@event)
    else
      load_event_groups
      render 'new'
    end
  end

  def edit
  end

  def update
    if @event.save
      redirect_to event_path(@event)
    else
      load_event_groups
      render 'edit'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time, :event_group_id)
  end

  def load_event_groups
    @event_groups = EventGroup.all
  end

  def events_by_month_and_week(events)
    events = events.group_by { |u| u.start_time.month }
    events.each_key do |k|
      events[k] = events[k].group_by { |e| e.start_time.strftime("%W").to_i }
    end
    events
  end
end
