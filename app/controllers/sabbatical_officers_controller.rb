class SabbaticalOfficersController < ApplicationController
  load_and_authorize_resource

  def index
    @sabbatical_officers = SabbaticalOfficer.by_position
  end

  def new
    @sabbatical_officer = SabbaticalOfficer.new
  end

  def create
    @sabbatical_officer = SabbaticalOfficer.new(sabbatical_officer_params)
    if @sabbatical_officer.save
      redirect_to(edit_sabbatical_officer_path(@sabbatical_officer),
                  notice: t('.success'))
    else
      render(:new, status: 422)
    end
  end

  def edit
    @sabbatical_officer = SabbaticalOfficer.find(params[:id])
  end

  def update
    @sabbatical_officer = SabbaticalOfficer.find(params[:id])
    if @sabbatical_officer.update(sabbatical_officer_params)
      redirect_to(edit_sabbatical_officer_path(@sabbatical_officer),
                  notice: t('.success'))
    else
      render(:edit, status: 422)
    end
  end

  def destroy
    SabbaticalOfficer.find(params[:id]).destroy!
    redirect_to(sabbatical_officers_path, notice: t('.success'))
  end

  private

  def sabbatical_officer_params
    params.require(:sabbatical_officer).permit(:name, :phone, :email,
                                               :role_sv, :role_en,
                                               :description_sv, :description_en,
                                               :image, :remove_image, :position)
  end
end
