class EventsController < ApplicationController
  before_filter :load_tags, only: [:index, :new, :edit]
  load_and_authorize_resource

  def index
    if params[:tag] && !params[:tag].blank?
      @tag = Tag.find(params[:tag])
      @events = @events.with_tag(@tag)
    end

    @offset = params[:offset].to_i || 0
    @this_month = Time.now.beginning_of_month + @offset.months
    respond_to do |format|
      format.html do
        @events = events_by_month_and_week(@events)
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
      load_tags
      render 'new'
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      load_tags
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time, :event_group_id)
  end

  def load_tags
    @tags = Tag.all
  end

  def events_by_month_and_week(events)
    events = events.group_by { |u| u.start_time.to_time.beginning_of_month }
    events.each_key do |k|
      events[k] = events[k].group_by { |e| e.start_time.strftime("%W").to_i }
    end
    events
  end
end
