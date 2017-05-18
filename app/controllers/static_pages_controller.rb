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

	def show_sabbatical
		@sabbatical = Sabbatical.all.order(:order)
		render json: @sabbatical.to_json
	end

	def update_sabbatical
		s1 = Sabbatical.find(sabbatical_id[:id])
		puts s1
		if s1[:order] != sabbatical_params[:order]
			s2 = Sabbatical.where(order: sabbatical_params[:order]).take
			if s2 then
				s2.update(order: s1[:order])
			end
		end
		s1.update!(sabbatical_params)
		render json: s1
	end

	def create_sabbatical
		name = "John Doe"
		order = Sabbatical.maximum("order")
		if !order then
			order = 0
		end
		order = order + 1
		s = Sabbatical.new(name: name, order: order)
		s.save
		render json: s
	end

	def delete_sabbatical
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
