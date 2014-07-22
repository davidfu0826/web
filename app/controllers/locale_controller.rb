class LocaleController < ApplicationController
  #load_and_authorize_resource

  def locale_sv
    cookies['locale'] = { :value => :sv, :expires => 1.year.from_now }
    I18n.locale = :sv
    redirect_to :back
  end

  def locale_en
    cookies['locale'] = { :value => :en, :expires => 1.year.from_now }
    I18n.locale = :en
    redirect_to :back
  end
end
