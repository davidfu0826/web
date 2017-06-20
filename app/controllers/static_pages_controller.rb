class StaticPagesController < ApplicationController
  def board
    @meetings = Meeting.board
                       .with_documents
                       .by_order
                       .order_documents
                       .document_locale(I18n.locale)
                       .group_by(&:year)
  end

  def council
    @meetings = Meeting.council
                       .with_documents
                       .by_order
                       .order_documents
                       .document_locale(I18n.locale)
                       .group_by(&:year)
  end

  def robots
    render(:robots, content_type: 'text/plain')
  end
end
