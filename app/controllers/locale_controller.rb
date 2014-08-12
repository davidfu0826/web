class LocaleController < ApplicationController
  #load_and_authorize_resource

  def locale_sv
    cookies['locale'] = { :value => :sv, :expires => 1.year.from_now }
    I18n.locale = :sv
    if params[:url].present?
      redirect_to params[:url]
    else
      redirect_to :back
    end
  end

  def locale_en
    cookies['locale'] = { :value => :en, :expires => 1.year.from_now }
    I18n.locale = :en
    if params[:url].present?
      redirect_to params[:url]
    else
      redirect_to :back
    end
  end
end
