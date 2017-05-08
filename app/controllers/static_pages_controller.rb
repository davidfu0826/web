class StaticPagesController < ApplicationController
  def robots
    render(:robots, content_type: 'text/plain')
  end
end
