class EventsController < ApplicationController
  before_filter :load_tags, only: [:index, :new, :edit, :change_cover]
  before_filter :load_images, only: [:change_cover]
  before_filter :load_cover_image
  load_and_authorize_resource

  def index
    @events = @events.filter(filtering_params)

    @now = Time.current
    @offset = params[:offset].to_i || 0
    @this_month = @now.beginning_of_month + @offset.months

    respond_to do |format|
      format.html { @events = events_by_month_and_week(@events) }
      format.js   { @events = events_by_month_and_week(@events) }
      format.ics do
        calendar = Icalendar::Calendar.new
        @events.each { |event| calendar.add_event(event.to_ics) }
        calendar.publish
        render text: calendar.to_ical
      end
    end
  end

  def show
  end

  def new
  end

  def create
    @event = Event.create_with_tags(event_params, params[:event][:tags])
    unless @event.new_record?
      redirect_to event_path(@event)
    else
      load_tags
      render 'new'
    end
  end

  def edit
  end

  def update
    if @event.update_with_tags(event_params, params[:event][:tags])
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

  def change_cover
    authorize! :manage, Event
    @cover_image = Image.find(Settings.events_cover_image) if Settings.events_cover_image.present?
    @image = Image.new
  end

  def change_cover_update
    authorize! :manage, Event
    if params[:image_id] =~ /^\d+$/ #Should only contain integers
      Settings.events_cover_image = params[:image_id]
      redirect_to events_path
    else
      load_tags
      load_images
      render 'change_cover'
    end
  end

  def delete_cover
    authorize! :manage, Event
    Settings.events_cover_image = nil

    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:title_sv, :title_en, :description_sv, :description_en, :start_time, :end_time)
  end

  def filtering_params
    params.slice(:search, :tag)
  end

  def load_tags
    @tags = Tag.all
  end

  def load_images
    @images = Image.all
  end

  def events_by_month_and_week(events)
    events = events.group_by { |u| u.start_time.to_time.beginning_of_month }
    events.each_key do |k|
      events[k] = events[k].group_by { |e| e.start_time.strftime("%W").to_i }
    end
    events
  end

  def load_cover_image
    if Settings.events_cover_image.present?
      @events_cover = Image.where(id: Settings.events_cover_image)
      if @events_cover.blank?
        Settings.events_cover_image = nil
      end
    end
  end
end
