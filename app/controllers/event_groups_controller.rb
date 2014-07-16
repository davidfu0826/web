class EventGroupsController < ApplicationController
  load_and_authorize_resource

  def new
    @event_group = EventGroup.new
  end

  def create
    @event_group = EventGroup.new(event_group_params)

    if @event_group.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  private

  def event_group_params
    params.require(:event_group).permit(:name)
  end
end
