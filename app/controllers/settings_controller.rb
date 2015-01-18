class SettingsController < ApplicationController
  load_and_authorize_resource class: "Settings"

  def edit
  end

  def update
    @settings[:sidebar_links] = params[:settings][:index_leads]
    @settings[:sidebar_links] = params[:settings][:sidebar_links].map { |key, value| value }

    redirect_to root_path
  end
end
