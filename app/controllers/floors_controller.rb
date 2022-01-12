class FloorsController < ApplicationController
  before_action :set_floor, only: %i[show edit update destroy]

  # GET /floors or /floors.json
  def index
    @floors = Floor.all
  end

  # GET /floors/1 or /floors/1.json
  def show
    @floor = Floor.find(params[:id])
  end

  # GET /floors/new
  def new
    @floor = Floor.new
  end

  # GET /floors/1/edit
  def edit; end

  # POST /floors or /floors.json
  def create
    @floor = Floor.new(floor_params)

    respond_to do |format|
      if @floor.save
        format.html { redirect_to @floor, notice: "Floor was successfully created." }
        format.json { render :show, status: :created, location: @floor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @floor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @floor.update(floor_params)
        format.html { redirect_to @floor, notice: "Floor was successfully updated." }
        format.json { render :show, status: :ok, location: @floor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @floor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @floor.destroy
    respond_to do |format|
      format.html { redirect_to floors_url, notice: "Floor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_floor
    @floor = Floor.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def floor_params
    params.fetch(:floor, {})
  end
end
