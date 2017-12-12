class Position < ApplicationRecord
	translates :title
	translates :committee
	translates :desc

	validates(:title_sv, :title_en, presence: true)
	validates(:number, presence: true)
	validates(:committee_sv, :committee_en, presence: true)
	validates(:desc_sv, :desc_en, presence: true)
	validates(:term, :apply_url, presence: true)

	validates :kind, presence: true
  	enum kind: { uncategorized: 0, position_of_trust: 10, committee_member: 12 }

  	scope(:by_order, -> { order(:kind) })

end
