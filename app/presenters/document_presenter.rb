class DocumentPresenter
  attr_reader(:annual_plan, :annual_report, :budget,
              :guideline, :opinion, :policy, :vision,
              :bylaws, :regulation, :directive)

  def initialize(documents)
    by_title = documents.by_title(I18n.locale).group_by(&:category)
    by_revision = documents.by_revision.group_by(&:category)
    @annual_plan = by_revision['annual_plan'] || []
    @annual_report = by_revision['annual_report'] || []
    @budget = by_revision['budget'] || []

    @bylaws = by_title['bylaws'] || []
    @directive = by_title['directive'] || []
    @vision = by_title['vision'] || []
    @regulation = by_title['regulation'] || []
    @guideline = by_title['guideline'] || []
    @opinion = by_title['opinion'] || []
    @policy = by_title['policy'] || []
  end
end
