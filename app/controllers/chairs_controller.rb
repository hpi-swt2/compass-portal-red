class ChairsController < ApplicationController
  before_action :set_chair, only: %i[show edit update destroy]

  # GET /chairs or /chairs.json
  def index
    @chairs = Chair.all
  end

  # GET /chairs/1 or /chairs/1.json
  def show; end

  # GET /chairs/new
  def new
    @chair = Chair.new
  end

  # GET /chairs/1/edit
  def edit; end

  # POST /chairs or /chairs.json
  def create
    puts(chair_params)
    @chair = Chair.new(chair_params)

    respond_to do |format|
      if @chair.save
        format.html { redirect_to @chair, notice: "Chair was successfully created." }
        format.json { render :show, status: :created, location: @chair }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chairs/1 or /chairs/1.json
  def update
    respond_to do |format|
      if @chair.update(chair_params)
        format.html { redirect_to @chair, notice: "Chair was successfully updated." }
        format.json { render :show, status: :ok, location: @chair }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chairs/1 or /chairs/1.json
  def destroy
    @chair.destroy
    respond_to do |format|
      format.html { redirect_to chairs_url, notice: "Chair was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chair
    @chair = Chair.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def chair_params
    params.fetch(:chair, {}).permit(:name, :person_ids, :room_ids)
  end
end
