class SettingsController < ApplicationController
  load_and_authorize_resource class: "Settings"
end
