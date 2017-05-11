class StaticPagesController < ApplicationController
  def board
    @meetings = Meeting.board
                       .by_order
                       .document_locale(I18n.locale)
                       .group_by(&:year)
  end

  def robots
    render(:robots, content_type: 'text/plain')
  end
end
