class PositionsController < ApplicationController

  # GET /positions
  def index
    @positions = Position.all
  end

  # GET /positions/new
  def new
    @position = Position.new
  end

  # GET /positions/1/edit
  def edit
    @position = Position.find(params[:id])
  end

  # POST /positions
  def create
    @position = Position.new(position_params)

    if @position.save
      redirect_to positions_url, notice: 'Position was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /positions/1
  def update
    @position = Position.find(params[:id])
    if @position.update(position_params)
      redirect_to positions_url, notice: 'Position was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /positions/1
  def destroy
    @position = set_position
    @position.destroy
    redirect_to positions_url, notice: 'Position was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def position_params
      params.require(:position).permit(:title_sv, :title_en, :number, :committee_sv, :committee_en, :term, :apply_url, :desc_sv, :desc_en)
    end
end
