class SettingsController < ApplicationController
  load_and_authorize_resource class: :settings

  def edit
    @cover_images = Image.where(id: Settings.cover_image_ids)
    @images = Image.all
  end

  def update
    Settings.cover_image_ids = settings_params.fetch(:cover_image_ids,
                                                     Settings.cover_image_ids)
                                              .reject(&:blank?)
                                              .map(&:to_i)
    redirect_to(settings_path, notice: "Inställningar uppdaterades")
  end

  private

  def settings_params
    params.require(:settings).permit(cover_image_ids: [])
  end
end
