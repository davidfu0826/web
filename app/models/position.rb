class Position < ApplicationRecord
	translates :title
	translates :committee
	translates :desc

	validates(:title_sv, :title_en, presence: true)
	validates(:number, presence: true)
	validates(:committee_sv, :committee_en, presence: true)
	validates(:desc_sv, :desc_en, presence: true)
	validates(:term, :apply_url, presence: true)
end
