class EventsController < ApplicationController
  before_filter :load_tags, only: [:edit, :index, :new]
  load_and_authorize_resource

  def index
    @events = @events.by_start
    respond_to do |format|
      format.html do
        @event_presenter = EventPresenter.new(events: @events,
                                              offset: params.fetch(:offset, 0)
                                         .to_i)
        @event_presenter.group_month_and_week
      end
      format.ics do
        render text: \
          CalendarService.export(@events, locale: params.fetch(:locale, 'sv'))
            .to_ical
      end
    end
  end

  def show
    @event = Event.includes(:tags).find(params[:id])
  end

  def new; end

  def create
    @event = Event.new(event_params.except(:tag_ids))
    if @event.save && @event.update(tag_ids: event_params.fetch(:tag_ids, []))
      redirect_to event_path(@event), notice: 'Event created'
    else
      load_tags
      render :new, status: 422
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event), notice: 'Event updated'
    else
      load_tags
      render :edit, status: 422
    end
  end

  def destroy
    @event.destroy!
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:title_sv, :title_en,
                                  :description_sv, :description_en,
                                  :start_time, :end_time,
                                  tag_ids: [])
  end

  def filtering_params
    params.slice(:search, :tag)
  end

  def load_tags
    @tags = Tag.order(:title)
  end
end
