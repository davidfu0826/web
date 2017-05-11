class StaticPagesController < ApplicationController
	authorize_resource class: :static_pages

  def board
    @meetings = Meeting.board
                       .with_documents
                       .by_order
                       .order_documents
                       .document_locale(I18n.locale)
                       .group_by(&:year)
  end

	def page_get_heltidare
		@sabbatical = Sabbatical.all.order(:order)
		render json: @sabbatical.to_json
	end

	def page_post_heltidare
		s1 = Sabbatical.find(sabbatical_id[:id])
		puts s1
		if s1[:order] != sabbatical_params[:order]
			s2 = Sabbatical.where(order: sabbatical_params[:order]).take
			if s2 then
				s2.update_attribute(:order, s1[:order])
				s2.save()
			end
		end
		s1.update!(sabbatical_params)
		render json: s1
	end

	def page_put_heltidare
		name = "Hilbert"
		title = "DimensionsÖvermäktige"
		description = "Ser till att det finns tillräckligt många egenfunktionärer"
		tel = "046-445 23 78"
		email = "elg@tlth.se"
		img = "https://tlth.s3-eu-west-1.amazonaws.com/images/54/thumb_bl_C3_A5_m_C3_A4rke.png"
		order = Sabbatical.maximum("order")
		if !order then
			order = 0
		end
		order = order + 1
		s = Sabbatical.new(:name => name, :title => title, :description => description, :tel => tel, :email => email, :img => img, :order => order)
		s.save()
		render json: s
	end

	def page_delete_heltidare
		s = Sabbatical.delete(params[:id])
		sall = Sabbatical.all.order(:order)
		i = 0;
		while (i<sall.length)
			sab = sall[i];
			sab.update_attribute(:order, i+1)
			sab.save()
			i = i + 1
		end
		render json: s
	end

  def robots
    render(:robots, content_type: 'text/plain')
  end

private
 	def sabbatical_params
 		params.require(:sabbatical).permit(:name, :title, :description, :tel, :email, :order, :img)
 	end

 	def sabbatical_id
 		params.require(:sabbatical).permit(:id)
 	end
end
