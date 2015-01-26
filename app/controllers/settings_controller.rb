class SettingsController < ApplicationController
  load_and_authorize_resource class: "Settings"

  def edit
    @pages = Page.with_image
  end

  def update
    @settings[:index_leads]    = params[:settings][:index_leads]
    @settings[:promoted_pages] = params[:settings][:promoted_pages]
                                  .reject { |page| page.blank? }
                                  .map { |page| page.to_i }
    @settings[:sidebar_links]  = params[:settings][:sidebar_links].map { |key, value| value }

    redirect_to root_path
  end
end
