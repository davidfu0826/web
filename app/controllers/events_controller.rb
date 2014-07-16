class EventsController < ApplicationController
  load_and_authorize_resource

  def index
    @events = Event.all

    respond_to do |format|
      format.html
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
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @event_groups = EventGroup.all
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to event_path(@event)
    else
      @event_groups = EventGroup.all
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
    @event_groups = EventGroup.all
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)

    if @event.save
      redirect_to event_path(@event)
    else
      @event_groups = EventGroup.all
      render 'edit'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time, :event_group_id)
  end

end
