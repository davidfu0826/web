class SettingsController < ApplicationController
  load_and_authorize_resource class: :settings

  def edit
    @cover_images = Image.where(id: Settings.cover_image_ids)
    @images = Image.all
  end

  def update
    notice = if update_setting
               t('.success')
             else
               t('.failure')
             end
    redirect_to(settings_path, notice: notice)
  end

  private

  def settings_params
    params.require(:settings).permit(:front_page_video,
                                     cover_image_ids: [])
  end

  def update_setting
    Settings.cover_image_ids = prepare_images
    Settings.front_page_video = prepare_video
    Settings.save
  end

  def prepare_images
    images = settings_params.fetch(:cover_image_ids, Settings.cover_image_ids)
    images.reject(&:blank?).map(&:to_i).uniq
  end

  def prepare_video
    settings_params.fetch(:front_page_video, Settings.front_page_video)
  end
end
