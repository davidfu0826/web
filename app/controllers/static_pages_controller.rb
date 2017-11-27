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

  def logo_mail
    send_file 'app/assets/images/logo-mail.png', type: 'image/png', disposition: 'inline'
  end
end
